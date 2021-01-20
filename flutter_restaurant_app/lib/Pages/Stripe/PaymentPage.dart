import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_restaurant_app/Pages/Stripe/Services/payment-service.dart';
import 'package:flutter_restaurant_app/Widgets/AddressWidget.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Models/DeliveryAddressModel.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:flutter_restaurant_app/Widgets/DialogueWidgets.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';
import 'package:secure_random/secure_random.dart';
//import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_restaurant_app/Pages/OrderHistory/OrderHistoryPage/OrderHistoryPage.dart';
//import 'package:stripe_payment/stripe_payment.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_restaurant_app/Widgets/CreditCardWidget.dart';
import 'package:flutter_restaurant_app/Pages/Stripe/PaymentPage/CheckoutPaymentPage/PaymentPageBLOC.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Pages/UserPaymentMethods/UserPayment/UserPaymentMethodsPage.dart';


class PaymentsPage extends StatefulWidget {
  static String id = "payments";
  final List<MealModel> orderItems;

  PaymentsPage({
    @required this.orderItems,
    //this.thisUser
  });

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> with TickerProviderStateMixin {

  //Initializers
  User firebaseUser = AuthCentral.auth.currentUser;
  FirebaseAuth _auth = AuthCentral.auth;
  OrderModel thisOrder = OrderModel();
  FirebaseDatabase firebaseDB = FirebaseDatabase.instance;

  //references
  DatabaseReference userRef;
  DatabaseReference cardsRef;
  DatabaseReference addressesRef;

  //Lists
  List<DeliveryAddressModel> deliveryAddresses = List();
  List<CreditCardModel> cards = List();

  //BLOCs
  PaymentPageBLOC paymentPageBLOC;

  //Models
  UserModel thisUser;

  //ints
  int tax = 0;
  int deliveryCharges = 300;
  int deliveryAddressIndex = 0;
  int paymentMethodIndex = 0;

  //bools
  bool cardOnFile = false;


  //Colors
  Color deliveryAddressTabColor(index){

    if (deliveryAddressIndex == index){
      return ThemeData().primaryColor;
    }else{
      return Colors.white;
    }
  }


  Color deliveryAddressTabMainTextColor(int index){
    if (deliveryAddressIndex == index){
      return Colors.white;
    }else{
      return Colors.black54;
    }
  }

  Color deliveryAddressTabSubtextColor(int index){
    if (deliveryAddressIndex == index){
      return Colors.white;
    }else{
      return Colors.grey;
    }
  }


  Color paymentMethodTabColor(index){
    if (paymentMethodIndex == index){
      return ThemeData().primaryColor;
    }else{
      return Colors.white;
    }
  }


  Color paymentMethodTabMainTextColor(int index){
    if (paymentMethodIndex == index){
      return Colors.white;
    }else{
      return Colors.black54;
    }
  }


  Color paymentMethodTabSubtextColor(int index){
    if (paymentMethodIndex == index){
      return Colors.white;
    }else{
      return Colors.grey;
    }
  }

  setOrderBasics({UserModel thisUser}){
    thisOrder = paymentPageBLOC.setOrderBasics(
        thisOrder,
        thisUser,
        widget.orderItems,
        deliveryCharges,
        tax
    );
  }


  setAddressToOrder(DeliveryAddressModel userDeliveryAddress){
    thisOrder = paymentPageBLOC.setOrderAddress(userDeliveryAddress, thisOrder);
  }

  //Functions
  //For userData
  setUserData()async {
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
      setOrderBasics(thisUser: thisUser);
      //setUserCardListData(thisCardUser: thisUser);
      setUserAddressListData(thisAddressUser: thisUser);
    }
  }
  //----------------


  //For userAddressData
  setUserAddressListData({UserModel thisAddressUser}){
    addressesRef = firebaseDB.reference().child('users').child("${thisAddressUser.uid}").child("Addresses");
    addressesRef.onChildAdded.listen(_currentUsersAddressesEvent);

    print("Address Count: ${deliveryAddresses.length}");
  }

  _currentUsersAddressesEvent(Event event) {
    var thisAddress = DeliveryAddressModel.fromSnapshot(event.snapshot);
    if (thisAddress.address != null) {
      setState(() {
        deliveryAddresses.add(thisAddress);
      });
      setAddressToOrder(deliveryAddresses[0]);
    }
  }
//----------------


//for cards
  setUserCardData(UserModel thisCardUser){
//Instances & listeners
    cardsRef =  firebaseDB.reference().child('users').child("${thisCardUser.uid}").child("Cards");
    cardsRef.onChildAdded.listen(_currentUsersCardsEvent);
  }
  _currentUsersCardsEvent(Event event) {

    //thisUserInfo
    var thisCard = CreditCardModel.fromSnapshot(event.snapshot);
    print(event.snapshot.toString());
    if (thisCard.cardHolderName != null) {
      cards.add(thisCard);
      //thisCard = thisCard;
    }
  }
  //----------------


  //--------- Payment Cards --------
  payViaNewCard(BuildContext context, UserModel thisUser,  OrderModel currentOrder ) async{

    //add purchaseItem a model object
    StripeTransactionResponse response;

    //progress dialog spinner
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(
        message: "Please wait.."
    );

    await dialog.show();

    await StripePaymentService.chargeCustomerThroughToken(
        context: context,
        thisUser: thisUser,
        thisPaymentOrder: thisOrder
    ).then((newResponse) {
      dialog.hide();
      response = newResponse;
      checkForNewCardSuccess(response: response);
    });//chargeCustomerThroughToken(context, thisUser, paymentOrder

  }

  checkForNewCardSuccess({StripeTransactionResponse response}){
    if (response.success == true){
      // clearing data
      thisOrder.orderItems = [];
      globalCurrentOrder.orderItems = [];
      //thisOrder.clearDuplicates();

      startPaymentCompleteAnimation();

    }else{
      print("Your payment did not go through");
      Navigator.pop(context);
    }
  }


  @override
  void initState(){
    super.initState();
    paymentPageBLOC = PaymentPageBLOC();

    //animations
    // set the controller from GlobalAnimations chart
    deleteAddressAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //required

    paymentCompleteAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //required

    noCardAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    );


    //Animations
    paymentCompleteAlertAnimation = paymentPageBLOC.getPaymentCompleteAlertAnimation();
    paymentCompleteAlertBackgroundAnimation = paymentPageBLOC.getPaymentCompleteAlertBackgroundAnimation();

    deleteAddressAlertAnimation = paymentPageBLOC.getDeleteAddressAlertAnimation();
    deleteAddressAlertBackgroundAnimation = paymentPageBLOC.getDeleteAddressAlertBackgroundAnimation();

    noCardAlertAnimation = paymentPageBLOC.getNoCardAlertAnimation();
    noCardAlertBackgroundAnimation = paymentPageBLOC.getNoCardAlertBackgroundAnimation();

    setUserData();

  }



  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Payments"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12, top: 30),
                //padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  children: [
                    Text("Check Out",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                  ],
                ),
              ),
              // delivery addresses
              SizedBox(height: 20,),


              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                child: Row(
                  children: [
                    Text("Delivery Address",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 10,),

              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: deliveryAddresses.length,
                  itemBuilder: (BuildContext context, int index){
                    return Row(
                      children: [
                        SizedBox(width: 12,),
                        GestureDetector(
                          child: AddressWidget(
                            deliveryAddresses: deliveryAddresses,
                            //thisUser: widget.thisUser,
                            index: index,
                            deleteAction: startDeleteAddressAnimation,
                            tabColor: deliveryAddressTabColor(index),
                            mainColor: deliveryAddressTabMainTextColor(index),
                            subtextColor: deliveryAddressTabSubtextColor(index),
                          ),
                          onTap: (){
                            setState(() {
                              setAddressToOrder(deliveryAddresses[index]);
                              //thisOrder.deliveryAddress = demoUserOne.deliveryAddresses[index];
                              deliveryAddressIndex = index;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),

              Column(
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
                      padding: const EdgeInsets.only(top: 12.0, right: 20,  left: 20, bottom: 30),
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
                                  Text(" ${thisOrder.setOrderTotalItemsCount().toString()} Items",
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
                              Text("\$${thisOrder.orderSubtotal / 100}",
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
                              Text("\$${thisOrder.orderDeliveryCharges/100}",
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

                              Text("\$${(thisOrder.orderTotalCost) /100}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 25,),

                          MainButtonWidget(
                            text: "Place Order",
                            onPressed: (){
                              if(cardOnFile == true){
                                //onItemPressed(context, thisOrder);
                              }else{
                                payViaNewCard(context,thisUser,thisOrder);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    height: 275,
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}