import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant_app/Pages/Stripe/PaymentPage/CheckoutPaymentPage/PaymentPageBLOC.dart';
import 'package:flutter_restaurant_app/Pages/UserPaymentMethods/UserPayment/UserPaymentMethodsBLOC.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/CreditCardWidget.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:flutter_restaurant_app/Pages/Stripe/Services/payment-service.dart';
import 'package:flutter_restaurant_app/Widgets/DialogueWidgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:secure_random/secure_random.dart';


class CheckoutPaymentMethodPage extends StatefulWidget {
  final UserModel thisUser;
  CheckoutPaymentMethodPage({this.thisUser});

  @override
  _CheckoutPaymentMethodPageState createState() => _CheckoutPaymentMethodPageState();
}

class _CheckoutPaymentMethodPageState extends State<CheckoutPaymentMethodPage> with TickerProviderStateMixin {

  
  //Models
  PaymentPageBLOC paymentPageBLOC;
  UserPaymentMethodsBLOC userPaymentMethodsBLOC;
  RestaurantDB restaurantDB;
  UserModel thisUser;
  DatabaseReference cardsRef;
  FirebaseDatabase firebaseDB = FirebaseDatabase.instance;
  
  
  //ints
  int paymentMethodIndex = 0;
  
  //lists
  List<CreditCardModel> cards = List();

  //variables
  var thisCard = CreditCardModel();

  //bools
  bool cardOnFile = false;


  //------------ Colors -------------
  Color cardTextColor;

  Color paymentMethodTabColor({int index}) {
    return userPaymentMethodsBLOC.paymentMethodTabColor(index: index, paymentMethodIndex: paymentMethodIndex);
  }

  Color paymentMethodTabMainTextColor({int index}) {
    return userPaymentMethodsBLOC.paymentMethodTabMainTextColor(index: index, paymentMethodIndex: paymentMethodIndex);
  }

  Color paymentMethodTabSubtextColor({int index}) {
    return userPaymentMethodsBLOC.paymentMethodTabSubtextColor(index: index, paymentMethodIndex: paymentMethodIndex);
  }


  //---------- Keys -----------
  final _formKey = GlobalKey<FormState>();


  void submitAddingNewCardToLibrary({bool isFromPaymentsPage, bool isFromPaymentPageNewCard}) async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();

      //preps the card details needed to proceed
      setOtherCardDetails();
      
      //set card details to stripe
      await StripePaymentService.addPaymentMethodToCustomer(
          thisUser: thisUser, thisCard: thisCard).then((paymentMethodId) {

            //then sendNewCardData to FB
        print("Addable Payment Method Id: $paymentMethodId");

        //add last card data
        setFinalCardData(paymentMethodId: paymentMethodId);
        
        //add complete card to FB
        restaurantDB.launchUserCardsPath(thisUser, thisCard, "create");
        
        //present added a new card to library
        startAddCardAnimation();
      });
    }
  }

  setOtherCardDetails(){
    thisCard.expiryDate = "${thisCard.expiryMonth}/${thisCard.expiryYear} ";
    thisCard.cardHolderName = "${thisCard.firstName} ${thisCard.lastName}";
    thisCard.showBackView = false;
  }
  
  setFinalCardData({String paymentMethodId}){
    //change card number
    var lastFourDigits = thisCard.cardNumber.substring(thisCard.cardNumber.length - 4);
    thisCard.cardNumber = "xxxx xxxx xxxx $lastFourDigits";
    thisCard.paymentId = paymentMethodId;

    print("last four digits: ${thisCard.cardNumber}");

  }

  //-----------------------


  //--------- Payment Cards --------
  payViaNewCard({BuildContext context, UserModel thisUser ,OrderModel thisOrder, CreditCardModel thisNewCard}) async{

    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      
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
          thisPaymentOrder: thisOrder,
          thisNewCard: thisNewCard
      ).then((newResponse) {
        dialog.hide();
        response = newResponse;
        checkForNewCardSuccess(response: response);
      }); //chargeCustomerThroughToken(context, thisUser, paymentOrder
    }
  }

  
  checkForNewCardSuccess({StripeTransactionResponse response}){
    if (response.success == true){
      
      // clearing data
      globalCurrentOrder.orderItems = [];

      startPaymentCompleteAnimation();
    }else{
      print("Your payment did not go through");
      Navigator.pop(context);
    }
  }

  //for cards
  setUserCardDataListener(){
//Instances & listeners
    cardsRef =  firebaseDB.reference().child('users').child("${thisUser.uid}").child("Cards");
    cardsRef.onChildAdded.listen(_currentUsersCardsEvent);
  }
  _currentUsersCardsEvent(Event event) {

    //thisUserInfo
    var thisCard = CreditCardModel.fromSnapshot(event.snapshot);
    print(event.snapshot.toString());
    if (thisCard.cardHolderName != null) {
      setState(() {
        cards.add(thisCard);
      });
      //thisCard = thisCard;
    }
  }
  //----------------


//For payment method
  payViaExistingCard(BuildContext context,OrderModel thisPaymentOrder)async{
    StripeTransactionResponse response;

    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(
        message: "Please wait.."
    );
    await dialog.show();

    //try pay with card
    paymentPageBLOC.payViaExistingCard(
        context: context,
        thisUser: thisUser,
        paymentOrder: thisPaymentOrder,
    ).then((value) {
      response = value;
      dialog.hide();
      checkForExistingCardSuccess(response: response);
    });
  }


  checkForExistingCardSuccess({StripeTransactionResponse response}){
    if (response.success){

      setFinalDataToOrder();

      setDataToUserPaymentHistory();

      startPaymentCompleteAnimation();

    }else{
     print("Something went wrong..");
    }
  }


  setFinalDataToOrder(){
    //set extra data to the purchase
    var secureRandom = SecureRandom();
    globalCurrentOrder.orderName = secureRandom.nextString(length: 6);
    globalCurrentOrder.orderUserId = thisUser.uid;
    globalCurrentOrder.orderStatus = "Waiting for processing";
    globalCurrentOrder.purchaseDate = "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}";
  }

  setDataToUserPaymentHistory(){
    paymentPageBLOC.setDataToUserPaymentHistory(
        context: context,
        thisUser: thisUser,
        thisPaymentOrder: globalCurrentOrder,
    );
  }

  //----------------- end of payment method


  // used when clicking a card to pay for amount this must await for the response
  onItemPressed(BuildContext context, OrderModel currentPaymentOrder) async{
    payViaExistingCard(context, globalCurrentOrder);
  }

  //-----------------

  onCheckoutPressed(){
    if(cardOnFile == true){
      onItemPressed(context, globalCurrentOrder);
    }else{
      payViaNewCard(context: context, thisUser: thisUser, thisOrder: globalCurrentOrder, thisNewCard: thisCard );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    
    //Setup the user
    thisUser = widget.thisUser;
    
    //prepare cardData
    setUserCardDataListener();
    
    paymentPageBLOC = PaymentPageBLOC();
    userPaymentMethodsBLOC = UserPaymentMethodsBLOC();
    restaurantDB = RestaurantDB();

    cardTextColor = Colors.white;

    //---------- Animation Setters -----------

    // set the controller from GlobalAnimations chart
    addCardAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //

    paymentCompleteAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //requ

    // set the profile update alertAnimation from GlobalAnimations chart
    addCardAlertAnimation = userPaymentMethodsBLOC.getAddCardAlertAnimation();
    addCardAlertBackgroundAnimation = userPaymentMethodsBLOC.getAddCardAlertBackgroundAnimation();

    //Animations
    paymentCompleteAlertAnimation = paymentPageBLOC.getPaymentCompleteAlertAnimation();
    paymentCompleteAlertBackgroundAnimation = paymentPageBLOC.getPaymentCompleteAlertBackgroundAnimation();


    super.initState();
  }



  checkCardInventory(){
    if (cards.isEmpty){
      cardOnFile = true;
      print("No Cards here...");
      return Container(
        height: 100,
          child: Center(child: Text("No Card on file..")));
    }else{
      print("Cards are here...");
      cardOnFile = true;
      return Container(
        height: 250,
        child: ListView.builder(
          itemCount: cards.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print("Im tapped!!!");
                setState(() {
                  globalCurrentOrder.setOrderPaymentCardParameters(cards[index]);
                  paymentMethodIndex = index;
                  print("index: $paymentMethodIndex");
                });
              },
              child: Padding(
                padding:
                const EdgeInsets.symmetric(
                    horizontal: 8.0),
                child: Row(
                  children: [
                    CreditCardWidget(
                      cards: cards,
                      subtextColor: paymentMethodTabSubtextColor(index: index),
                      mainColor: paymentMethodTabMainTextColor(index: index),
                      tabColor: paymentMethodTabColor(index: index),
                      cardTextColor: cardTextColor,
                      //thisUser: demoUserOne,
                      index: index,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [ Container(
              child: Column(
                children: [
                  checkCardInventory(),
                  Column(
                    children: [
                      //#2
                     Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(100, 0, 0, 0),
                                  offset: Offset(1, 1),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.5)
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                    labelStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  onSaved: (value) {
                                    thisCard.firstName = value;
                                    print(thisCard.firstName);
                                    return null;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter First Name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
                                    labelStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  onSaved: (value) {
                                    thisCard.lastName = value;
                                    print(thisCard.lastName);
                                    return null;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Last Name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Card Number",
                                    labelStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                                  ],
                                  onSaved: (value) {
                                    //cardNumber = int.parse(value);
                                    thisCard.cardNumber = value;
                                    print(thisCard.cardNumber);
                                    return null;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Card Number';
                                    }
                                    //cardNumber = int.parse(value);
                                    thisCard.cardNumber = value;
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "Exp Month",
                                          labelStyle: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        onSaved: (value) {
                                          var numberData = int.parse(value);
                                          thisCard.expiryMonth = numberData;
                                          print(thisCard.expiryMonth);
                                          return null;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Card Expiration Month';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "Exp Year",
                                          labelStyle: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        onSaved: (value) {
                                          var numberData = int.parse(value);
                                          thisCard.expiryYear = numberData;
                                          print(thisCard.expiryYear);
                                          return null;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Card Expiration Year';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "CVV",
                                          labelStyle: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        onSaved: (value) {
                                          thisCard.cvvCode = value;
                                          print(thisCard.cvvCode);
                                          return null;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter CVV';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 30,
                            left: 24,
                            right: 24),
                        child: OutlineButton(
                          borderSide: BorderSide(
                              width: 2, color: Colors.grey),
                          onPressed: () {
                            submitAddingNewCardToLibrary();
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                'Save This Card',
                                style: TextStyle(
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius
                                .circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //height: 220,
            ),
            ]
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
                            onCheckoutPressed();
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
          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: addCardAlertBackgroundAnimation,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 0, 0, 0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      offset: Offset(1, 1),
                      blurRadius: 10.0,
                      spreadRadius: 0.5)
                ],
              ),
            ),
          ),


          SlideTransition(
            position: addCardAlertAnimation,
            child: CardPaymentUpdatedWidget(
              title: "Payment Method Updated",
              subtitle: "Your payment methods have been updated!",
              actionOne: () {
                endAddCardAnimation().then((value){
                  Navigator.pop(context);
                  Navigator.pop(context);
                    //StripePaymentService.addCardToCustomer(thisUser: thisUser, thisCard: thisCard);
                    //do nothing
                });
              })
          ),

          //for completed payments
          SlideTransition(
            position: paymentCompleteAlertBackgroundAnimation,
            child: GestureDetector(
              onTap: (){
                endProfileImageAnimation();
              },
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
          ),

          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: paymentCompleteAlertAnimation,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(

                  //margin: requestedReset? EdgeInsets.only(top: 0): EdgeInsets.only(top: MediaQuery.of(context).size.height + 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),
                  height: 400,//MediaQuery.of(context).size.height - 200,
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
                              /*border: Border.all(
                                color: Colors.grey,
                                width: 2
                              ),
                               */
                              //color: Colors.grey,
                            ),
                            height: 100,
                            width: 100,
                            child: Image.asset("Assets/congrats.png",
                              fit: BoxFit.fill,),
                            //child: Image.asset("Assets/ProductImages/${thisMeal.productImage}",
                            //fit: BoxFit.cover,),
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text("Payment Complete",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: 10,),


                        Text("Your payment was successful",
                          textAlign: TextAlign.center,
                          style:TextStyle(
                              fontSize: 16
                          ),
                        ),

                        SizedBox(height: 30,),

                        MainButtonWidget(text: "Close", onPressed: (){
                          endPaymentCompleteAnimation(context);
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
