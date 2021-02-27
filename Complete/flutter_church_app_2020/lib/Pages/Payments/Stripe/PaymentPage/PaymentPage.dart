import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Pages/MainSelectionsPage/MainSelectionsPage.dart';
import 'package:flutter_church_app_2020/Pages/Payments/PaymentMethodSelection/PaymentSelectionPage.dart';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/Services/payment-service.dart';
import 'package:flutter_church_app_2020/Widget/MainButtonWidgets.dart';
import 'package:flutter_church_app_2020/Widget/NewCardFormWithFloatingBackgroundWidget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Models/PaymentOrderModel.dart';
import 'package:flutter_church_app_2020/Models/CreditCardModel.dart';
import 'package:flutter_church_app_2020/Animations/GlobalAnimations.dart';
import 'package:flutter_church_app_2020/Widget/DialogueWidgets.dart';
import 'package:secure_random/secure_random.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_church_app_2020/Widget/CreditCardWidget.dart';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/PaymentPage/PaymentPageBLOC.dart';
import 'package:flutter_church_app_2020/Pages/Payments/UserPaymentMethods/UserPaymentMethods/UserPaymentMethodsPage.dart';
import 'package:flutter_church_app_2020/Pages/Payments/NoCard/NoCardPaymentPage.dart';

class PaymentPage extends StatefulWidget {
  static String id = "payments";
  final ChurchUserModel thisUser;
  final String paymentType;
  final double paymentAmount;

  PaymentPage({this.paymentType, this.thisUser, this.paymentAmount});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with TickerProviderStateMixin {
  //---------- Initializers -----------
  ChurchDB churchDB;
  PaymentPageBLOC paymentPageBLOC;
  DatabaseReference cardsRef;
  DatabaseReference addressesRef;
  ChurchUserModel thisUser;
  PaymentOrderModel thisPaymentOrder;
  CreditCardModel thisCard;

  //---------- Lists -----------
  List<CreditCardModel> cards = List();

  //---------- ints -----------
  int paymentMethodIndex = 0;

  //---------- Keys -----------
  //for snackbar use outside of tree
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //---------- functions -----------

  Color paymentMethodTabColor({int index}) {
    return paymentPageBLOC.paymentMethodTabColor(
        index: index, paymentMethodIndex: paymentMethodIndex);
  }

  Color paymentMethodTabMainTextColor({int index}) {
    return paymentPageBLOC.paymentMethodTabMainTextColor(
        index: index, paymentMethodIndex: paymentMethodIndex);
  }

  Color paymentMethodTabSubtextColor({int index}) {
    return paymentPageBLOC.paymentMethodTabSubtextColor(
        index: index, paymentMethodIndex: paymentMethodIndex);
  }

  //--------- Payment Cards --------
  Future payViaNewCard(
      BuildContext context, ChurchUserModel thisUser, int paymentTotal) async {
    StripeTransactionResponse response;
    //progress dialog spinner

    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: "Please wait..");
    await dialog.show();

    //first create form with user card data.
    //then function data with token

    CreditCardModel thisNewCard =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoCardPaymentPage(
        thisUser: thisUser,
      );
    }));

    if (thisNewCard != null) {
      thisPaymentOrder.paymentCardNumber = thisNewCard.cardNumber;
      thisPaymentOrder.paymentExpiryMonth = thisNewCard.expiryMonth;
      thisPaymentOrder.paymentExpiryYear = thisNewCard.expiryYear;
      thisPaymentOrder.paymentCvvCode = thisNewCard.cvvCode;

      await StripePaymentService.chargeCustomerThroughToken(
              context: context,
              thisUser: thisUser,
              thisPaymentOrder: thisPaymentOrder)
          .then((newResponse) {
        dialog.hide();
        response = newResponse;
        checkForNewCardSuccess(response: response);
      }); //chargeCustomerThroughToken(context, thisUser, paymentOrder
    } else {
      print("No Card was entered");
      dialog.hide();
      startNoCardAnimation();
      //Navigator.pop(context);
      //Navigator.pop(context);
    }

    /*
    await paymentPageBLOC.payViaNewCard(
        context: context,
        thisUser: thisUser,
        paymentOrder: thisPaymentOrder,
    ).then((value) {
          response = value;

          checkForNewCardSuccess(response: response);
    });

     */
  }

  checkForNewCardSuccess({StripeTransactionResponse response}) {
    if (response.success == true) {
      //setDataToUserPaymentHistory();

      startPaymentCompleteAnimation();
    } else {
      print("Your payment did not go through");
      Navigator.pop(context);
    }
  }
  //-----------------

//For payment method
  payViaExistingCard(
      BuildContext context, PaymentOrderModel thisPaymentOrder) async {
    StripeTransactionResponse response;

    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: "Please wait..");
    await dialog.show();

    //try pay with card
    paymentPageBLOC
        .payViaExistingCard(
            context: context,
            thisUser: thisUser,
            paymentOrder: thisPaymentOrder,
            paymentType: widget.paymentType)
        .then((value) {
      response = value;
      dialog.hide();
      checkForExistingCardSuccess(response: response);
    });
  }

  checkForExistingCardSuccess({StripeTransactionResponse response}) {
    if (response.success) {
      setFinalDataToOrder();

      setDataToUserPaymentHistory();

      startPaymentCompleteAnimation();
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(
            content: Text(response.message),
            duration: Duration(milliseconds: 3000),
          ))
          .closed
          .then((_) {
        print(response.message);
        //Navigator.popUntil(context, ModalRoute.withName("/main_page") );
      });
    }
  }

  setFinalDataToOrder() {
    //set extra data to the purchase
    var secureRandom = SecureRandom();
    thisPaymentOrder.orderName = secureRandom.nextString(length: 6);
    thisPaymentOrder.orderStatus = "Waiting for processing";
    thisPaymentOrder.purchaseDate =
        "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}";
  }

  setDataToUserPaymentHistory() {
    paymentPageBLOC.setDataToUserPaymentHistory(
        context: context,
        thisUser: thisUser,
        thisPaymentOrder: thisPaymentOrder,
        paymentType: widget.paymentType);
  }

  //----------------- end of payment method

  setOrderPaymentCardParameters(CreditCardModel userPaymentMethod) {
    setState(() {
      thisPaymentOrder.paymentFirstName = userPaymentMethod.firstName;
      thisPaymentOrder.paymentLastName = userPaymentMethod.lastName;
      thisPaymentOrder.paymentCardNumber = userPaymentMethod.cardNumber;
      thisPaymentOrder.paymentExpiryDate = userPaymentMethod.expiryDate;
      thisPaymentOrder.paymentExpiryMonth = userPaymentMethod.expiryMonth;
      thisPaymentOrder.paymentExpiryYear = userPaymentMethod.expiryYear;
      thisPaymentOrder.paymentCardHolderName = userPaymentMethod.cardHolderName;
      thisPaymentOrder.paymentCvvCode = userPaymentMethod.cvvCode;
      thisPaymentOrder.paymentId = userPaymentMethod.paymentId;
    });
    showCardUser();
  }

  showCardUser() {
    print("CardNumber: ${thisPaymentOrder.paymentCardNumber}");
    print("CardUserName: ${thisPaymentOrder.paymentCardHolderName}");
  }

  noCardsPresent() {
    startNoCardAnimation();
  }

  // used when clicking a card to pay for amount this must await for the response
  onItemPressed(BuildContext context, int index,
      PaymentOrderModel currentPaymentOrder) async {
    // Check basket alert?
    print("This payment CardUser: ${thisPaymentOrder.paymentFirstName}");
    payViaExistingCard(context, thisPaymentOrder);
  }

  //-----------------

  // override the init state to call the services init state
  // to authorize a payment function
  @override
  void initState() {
    super.initState();

    //---------- Initial Setters -----------
    churchDB = ChurchDB();
    paymentPageBLOC = PaymentPageBLOC();
    thisPaymentOrder = PaymentOrderModel();
    thisUser = widget.thisUser;
    thisPaymentOrder.orderUserId = thisUser.userUID;
    thisPaymentOrder.orderTotalCost = widget.paymentAmount.toInt();

    //---------- Reference Setters -----------
    cardsRef = FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child("${thisUser.userUID}")
        .child("Cards");

    cardsRef.once().then((value) {
      print("once read: ${value.key}");

      if (value.value == null) {
        noCardsPresent();
      } else {
        var thisCard = CreditCardModel.fromSnapshot(value);
      }
    });

    //---------- Listener Setters -----------
    setListeners();

    //---------- Animation Setters -----------

    //Controllers
    deleteAddressAlertAnimationController =
        alertController(duration: Duration(seconds: 1), thisClass: this);

    paymentCompleteAlertAnimationController =
        alertController(duration: Duration(seconds: 1), thisClass: this);

    noCardAlertAnimationController =
        alertController(duration: Duration(seconds: 1), thisClass: this);

    //Animations
    paymentCompleteAlertAnimation =
        paymentPageBLOC.getPaymentCompleteAlertAnimation();

    paymentCompleteAlertBackgroundAnimation =
        paymentPageBLOC.getPaymentCompleteAlertBackgroundAnimation();

    deleteAddressAlertAnimation =
        paymentPageBLOC.getDeleteAddressAlertAnimation();

    deleteAddressAlertBackgroundAnimation =
        paymentPageBLOC.getDeleteAddressAlertBackgroundAnimation();

    noCardAlertAnimation = paymentPageBLOC.getNoCardAlertAnimation();

    noCardAlertBackgroundAnimation =
        paymentPageBLOC.getNoCardAlertBackgroundAnimation();

  }

  setListeners() {
    cardsRef.onChildAdded.listen(_currentUsersCardsEvent);

    cardsRef.onChildChanged.listen(_currentUsersCardsEvent);
  }

  _currentUsersCardsEvent(Event event) {
    //thisUserInfo
    var thisCard = CreditCardModel.fromSnapshot(event.snapshot);
    print(event.snapshot.toString());
    if (thisCard.cardHolderName != null) {
      print("A Card is being added");
      setState(() {
        cards.add(thisCard);
        if (cards.isNotEmpty) {
          print("Cards are not empty");
          print("Card detail: ${cards[0].cardNumber}");
          setOrderPaymentCardParameters(cards[0]);
        }
      });
      //thisCard = thisCard;
    } else {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    paymentCompleteAlertAnimationController.dispose();
    deleteAddressAlertAnimationController.dispose();
    noCardAlertAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Finalize Your Donation"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12, bottom: 12, top: 0),
                //padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  children: [
                    Center(
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width - 50,
                        //color: Colors.blueAccent,
                        child: Image.asset("Assets/FinalizePayment.png"),
                      ),
                    ),
                  ],
                ),
              ),
              // delivery addresses
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                child: Row(
                  children: [
                    Text(
                      "Payment Source",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              // payment source
              Container(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: CreditCardWidget(
                            cards: cards,
                            cardTextColor: Colors.white,
                            tabColor: paymentMethodTabColor(index: index),
                            mainColor:
                                paymentMethodTabMainTextColor(index: index),
                            subtextColor:
                                paymentMethodTabSubtextColor(index: index),
                            //thisUser: widget.thisUser,
                            index: index,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          setOrderPaymentCardParameters(cards[index]);
                          paymentMethodIndex = index;
                        });
                        print(index);
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 275,
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
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
                  padding: const EdgeInsets.only(
                      top: 12.0, right: 20, left: 20, bottom: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount Payable ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$${(thisPaymentOrder.orderTotalCost) / 100}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MainButtonWidget(
                        text: "Send",
                        onPressed: () {
                          //paymentPageBLOC.chargeCustomerThroughToken(thisUser, thisPaymentOrder);
                          //paymentPageBLOC.createNewCustomerToken(thisUser, thisPaymentOrder);
                          //paymentPageBLOC.createNewCustomer(thisUser);
                          onItemPressed(context, 1, thisPaymentOrder);
                        },
                      )
                    ],
                  ),
                ),
                height: 175,
              ),
            ],
          ),

          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: deleteAddressAlertBackgroundAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height,
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
            position: deleteAddressAlertAnimation,
            child: DeleteAddressWidget(
              title: "Delete Address",
              subtitle: "Are you sure you want to delete this address?",
              actionOne: () {
                //print("deleting ${deliveryAddresses[addressIndex]}");
                //FirebaseUserSingleton.sharedInstance.thisUser.removeAddressFromList(deliveryAddresses[addressIndex]);
                endDeleteAddressAnimation();
              },
              actionTwo: () {
                endDeleteAddressAnimation();
              },
            ),
          ),

          //for completed payments
          SlideTransition(
            position: paymentCompleteAlertBackgroundAnimation,
            child: GestureDetector(
              onTap: () {
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
                        spreadRadius: 0.5)
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
                  height: 400, //MediaQuery.of(context).size.height - 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30),
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
                            child: Image.asset(
                              "Assets/congrats.png",
                              fit: BoxFit.fill,
                            ),
                            //child: Image.asset("Assets/ProductImages/${thisMeal.productImage}",
                            //fit: BoxFit.cover,),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Donation Complete",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Your donation was successful",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        MainButtonWidget(
                            text: "Close",
                            onPressed: () {
                              endPaymentCompleteAnimation(context)
                                  .then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                //Navigator.popUntil(context, ModalRoute.withName("${PaymentSelectionPage.id}") );
                                /*Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return MainSelectionsPage();
                                    })
                            );

                             */
                              });
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          //for no cards Alert
          SlideTransition(
            position: noCardAlertBackgroundAnimation,
            child: GestureDetector(
              onTap: () {
                //endNoCardAnimation();
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
                        spreadRadius: 0.5)
                  ],
                ),
              ),
            ),
          ),

          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: noCardAlertAnimation,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  //margin: requestedReset? EdgeInsets.only(top: 0): EdgeInsets.only(top: MediaQuery.of(context).size.height + 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),
                  height: 400, //MediaQuery.of(context).size.height - 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30),
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
                              child: Icon(
                                Icons.credit_card,
                                size: 72,
                              )
                              //child: Image.asset("Assets/ProductImages/${thisMeal.productImage}",
                              //fit: BoxFit.cover,),
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "No Card On File",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "",
                          //"Would you like to add a card for later use?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        /*MainButtonWidget(
                            text: "Yes",
                            onPressed: () {
                              endNoCardAnimation().then((value) async {
                                var isCompleted = await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UserPaymentMethodsPage(
                                    thisUser: thisUser,
                                    tabIndex: 1,
                                    fromPaymentsPage: true,
                                  );
                                }));
                                if (isCompleted == true) {
                                } else if (isCompleted == false) {
                                  startNoCardAnimation();
                                }
                              });
                              //pop until mainSelections, then push to userPaymentSelections Page, the add cards tab
                              //or popup add a card window
                              //addCardToLibrary();

                              // then
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        */
                        FlatSecondaryMainButton(
                            text: "Continue",
                            onPressed: () {
                              endNoCardAnimation().then((value) {
                                payViaNewCard(context, thisUser,
                                    widget.paymentAmount.toInt());
                              });
                              //segue to the enter card number for direct pay
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
