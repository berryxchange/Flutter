import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Pages/Stripe/PaymentPage/CheckoutPaymentPage/CheckoutPaymentMethodPage.dart';
import 'package:flutter_restaurant_app/Widgets/CartListWidget.dart';
import 'package:flutter_restaurant_app/Widgets/DialogueWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Pages/Cart/CartPageBLOC.dart';


class CartPage extends StatefulWidget {
  static String id = "/cartPage";
  
  //updates parent class
  final ValueChanged<int> menuAction;
  
  CartPage({this.menuAction});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {

  //References
  DatabaseReference userRef;

  //Models
  User firebaseUser = AuthCentral.auth.currentUser;
  FirebaseDatabase firebaseDB = FirebaseDatabase.instance;
  UserModel thisUser;
  CartPageBLOC cartPageBLOC;

  //ints
  int deleteItemIndex = 0;

  

  //Functions
  void onTabDeleteTapped(int index) {
    print("deleting item");
    setState(() {
      deleteItemIndex = index;
      startDeleteItemFromListAnimation();
    });
  }
  
  
  //For userData
  setUserDataListeners()async {
    //Instances & listeners
    userRef = firebaseDB.reference().child('users').child("${firebaseUser.uid}");
    userRef.onChildAdded.listen(_currentUsersEvent);
  }

  //Listeners
  _currentUsersEvent(Event event) {
    var trueUser = UserModel.fromSnapshot(event.snapshot);
    if (trueUser.userName != null) {
      print("The current User Uid: ${trueUser.uid}");
      setState(() {
        thisUser = trueUser;
      });
      //globalCurrentOrder.configureOrder();
    }
  }
  //----------------


  onCheckOutPressed()async{
    var isComplete = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context) {
          return CheckoutPaymentMethodPage(thisUser: thisUser);
        }),
    );
    if(isComplete == true){
      widget.menuAction(4);
    }
  }


  onRemoveItemPressed(){
    setState(() {
      globalCurrentOrder.orderItems.removeAt(deleteItemIndex);
      globalCurrentOrder.configureOrder();
    });
    endDeleteItemFromListAnimation();
  }


  checkCartIfEmpty(){
    if (globalCurrentOrder.orderItems.isEmpty){
      return NoItemsWidget(
        title: "Your Basket Is Empty",
        subtitle: "Please add an item to your cart",
        actionOne: (){
          widget.menuAction(1); // sends the index of the parent page
        },
      );
    }else{
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 450,
              child: CartListWidget(
                menuCategory:
                globalCurrentOrder.orderItems,//currentOrderItems,
                menuAction: onTabDeleteTapped,
                //thisUser: thisUser,
              ),
            ),
          ),

          Container(
            //height: 50,

            //-------- cost widget ---------
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(30, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 10.0,
                          spreadRadius: 0.5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, right: 20,  left: 20, bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Order ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text("|",
                                  style: TextStyle(
                                    fontSize: 18,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(" ${globalCurrentOrder.setOrderTotalItemsCount().toString()} Items",
                                  style: TextStyle(
                                    fontSize: 18,
                                    //fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                            FlatButton(
                              onPressed: (){
                                print("Adding Coupon");
                              },
                              child: Text("Add Coupon",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),

                        Divider(
                          height: 1,
                          thickness: 2,
                        ),

                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Basket Charges ",
                              style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                            Text("\$${globalCurrentOrder.orderSubtotal / 100}",
                              style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery Charges ",
                              style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                            Text("\$${globalCurrentOrder.orderDeliveryCharges/100}",
                              style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Amount Payable ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            Text("\$${(globalCurrentOrder.orderTotalCost) /100}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25,),

                        MainButtonWidget(
                          text: "Checkout",
                          onPressed: (){
                            onCheckOutPressed();
                          },
                        )
                      ],
                    ),
                  ),
                  height: 260,
                ),
              ],
            ),
          ),






          //-------- Transitions ---------
          SlideTransition(
            position: deleteItemFromListAlertBackgroundAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 0, 0, 0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      offset: Offset(1, 1),
                      blurRadius: 10.0,
                      spreadRadius: 0.5                          )
                ],
              ),
            ),
          ),

          SlideTransition(
            position: deleteItemFromListAlertAnimation,
            child: DeleteItemFromListWidget(
              title: "Delete Item",
              subtitle: "Are you sure you want to delete this item?",
              actionOne: (){
                onRemoveItemPressed();
              },
              actionTwo: (){
                endDeleteItemFromListAnimation();
              },
            ),
          ),
        ],
      );
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cartPageBLOC = CartPageBLOC();
    setUserDataListeners();


    // set the controller from GlobalAnimations chart
    deleteItemFromListAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //required

    // set the profile update alertAnimation from GlobalAnimations chart
    deleteItemFromListAlertAnimation = cartPageBLOC.getDeleteItemFromListAlertAnimation();
    deleteItemFromListAlertBackgroundAnimation = cartPageBLOC.getDeleteItemFromListAlertBackgroundAnimation();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    deleteItemFromListAlertAnimationController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: checkCartIfEmpty()
    );
  }
}
