import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Pages/Menu/ProductPage/ProductPageBLOC.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';

class ProductPage extends StatefulWidget {
  final String from;
  final MealModel thisMeal;
  final ValueChanged<int> menuAction;
  final UserModel thisUser;

  ProductPage({this.thisMeal, this.menuAction, this.from, this.thisUser});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with TickerProviderStateMixin{

  //Initializers
  ProductPageBLOC productPageBLOC;
  MealModel thisNewMeal = MealModel();
  OrderModel thisNewOrder;

  //vars
  var contains = false;


  _increaseAmount(MealModel thisMeal){
    thisNewMeal.productDuplicates = productPageBLOC.increaseAmount(thisMeal);
  }

  _decreaseAmount(MealModel thisMeal){
    thisNewMeal.productDuplicates = productPageBLOC.decreaseAmount(thisMeal);
  }

  //functions
  checkFromPage({String fromPage}){
    switch(fromPage){
      case "Menu":
        startAddedToCartAnimation();
        break;
      case "Cart":
        startAddedToCartAlertFromCartAnimation();
        break;
    }
  }

  onAddedItemToCart(){
    setState(() {
      //Add Item to cart
      globalCurrentOrder.addThisItemToCart(thisNewMeal);
      //set the updated data to the order
      globalCurrentOrder.configureOrder();
    });
    //once all is set, show the proper alert to return
    // based on the way you came
    checkFromPage(fromPage: widget.from);
  }

  onClosedAddedToCartNotification(){
    endAddedToCartAlertFromCartAnimation().then((value) {
      Navigator.pop(context);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productPageBLOC = ProductPageBLOC();

    //sets up the order
    thisNewOrder = globalCurrentOrder;

    //sets the incoming meal
    thisNewMeal = widget.thisMeal;
    thisNewMeal.productDuplicates = 1;


    //amount = thisMeal.productDuplicates;
    // set the controller from GlobalAnimations chart
    addedToCartAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //required

    // set the controller from GlobalAnimations chart
    addedToCartAlertFromCartAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //required


    // set the alertAnimation from GlobalAnimations chart
    addedToCartAlertAnimation = productPageBLOC.getAddedToCartAlertAnimation();
    addedToCartAlertBackgroundAnimation = productPageBLOC.getAddedToCartAlertBackgroundAnimation();

    // set the alertAnimation from GlobalAnimations chart
    addedToCartAlertFromCartAlertBackgroundAnimation = productPageBLOC.getAddedToCartAlertFromCartAlertAnimation();
    addedToCartAlertFromCartAlertAnimation = productPageBLOC.getAddedToCartAlertFromCartAlertBackgroundAnimation();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    addedToCartAlertAnimationController.dispose();
    addedToCartAlertFromCartAlertAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: ListView(
                children: [
                  SizedBox(height: 12,),

                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(100, 0, 0, 0),
                              offset: Offset(1, 1),
                              blurRadius: 10.0,
                              spreadRadius: 0.5
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("Assets/ProductImages/${thisNewMeal.productImage}",
                          width: MediaQuery.of(context).size.width,
                        ),
                      )
                  ),

                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          thisNewMeal.productName,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(thisNewMeal.productDescription,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text("\$${thisNewMeal.productPrice.toString()}",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),

                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(100, 203, 206, 212),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                _increaseAmount(thisNewMeal);
                                });
                              },
                              //backgroundColor: Colors.blue,
                              child: Text("+",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: ThemeData().primaryColor
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              height: 50,
                              width: 300,
                              child: Center(
                                child: Text("${thisNewMeal.productDuplicates}",
                                  style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeData().primaryColor
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _decreaseAmount(thisNewMeal);
                                });
                              },
                              //backgroundColor: Colors.blue,
                              child: Text("-",
                                style: TextStyle(
                                    fontSize: 28,
                                    color: ThemeData().primaryColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  MainButtonWidget(
                    text: "Add to Cart",
                    onPressed: (){
                      onAddedItemToCart();
                    },
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ),

          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: addedToCartAlertBackgroundAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height + AppBar().preferredSize.height,
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


          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: addedToCartAlertAnimation,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(

                  //margin: requestedReset? EdgeInsets.only(top: 0): EdgeInsets.only(top: MediaQuery.of(context).size.height + 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height - 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                            height: 150,
                            width: 150,
                            child: Image.asset("Assets/ProductImages/${thisNewMeal.productImage}",
                            fit: BoxFit.cover,),
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text("Item Added",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: 10,),


                        Text("${thisNewMeal.productName}\n has been added to your cart.",
                          textAlign: TextAlign.center,
                          style:TextStyle(
                              fontSize: 16
                          ),
                        ),

                        SizedBox(height: 30,),

                        CancelButton(
                          text: "Close",
                          onPressed: (){
                            endAddedToCartAnimation().then((value) {
                              Navigator.pop(context);
                            });
                          },
                        ),

                        SizedBox(height: 10,),

                        MainButtonWidget(
                          text: "Go to Cart",
                          onPressed: (){
                            //endAddedToCartAnimation();
                            widget.menuAction(1);
                            endAddedToCartAndPushToCartAnimation(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: addedToCartAlertFromCartAlertBackgroundAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height + AppBar().preferredSize.height,
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


          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: addedToCartAlertFromCartAlertAnimation,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(

                  //margin: requestedReset? EdgeInsets.only(top: 0): EdgeInsets.only(top: MediaQuery.of(context).size.height + 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height - 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                            height: 150,
                            width: 150,
                            child: Image.asset("Assets/ProductImages/${thisNewMeal.productImage}",
                              fit: BoxFit.cover,),
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text("Item Added",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: 10,),


                        Text("${thisNewMeal.productName}\n has been added to your cart.",
                          textAlign: TextAlign.center,
                          style:TextStyle(
                              fontSize: 16
                          ),
                        ),

                        SizedBox(height: 30,),

                        CancelButton(
                          text: "Close",
                          onPressed: (){
                            onClosedAddedToCartNotification();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
