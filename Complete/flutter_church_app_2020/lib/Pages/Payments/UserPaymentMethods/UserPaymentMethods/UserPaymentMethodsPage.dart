import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_church_app_2020/Models/PaymentOrderModel.dart';
//import 'package:flutter_restaurant_backend_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Models/CreditCardModel.dart';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/Services/payment-service.dart';
import 'package:flutter_church_app_2020/Pages/Payments/UserPaymentMethods/TransactionDetailPage.dart';
import 'package:flutter_church_app_2020/Widget/CreditCardWidget.dart';
import 'package:flutter_church_app_2020/Animations/GlobalAnimations.dart';
import 'package:flutter_church_app_2020/Widget/DialogueWidgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:secure_random/secure_random.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Widget/NewCardFormWithFloatingBackgroundWidget.dart';
import 'package:flutter_church_app_2020/Pages/Payments/UserPaymentMethods/UserPaymentMethods/UserPaymentMethodsBLOC.dart';
import 'package:progress_dialog/progress_dialog.dart';


// Create a Form widget.
class UserPaymentMethodsPage extends StatefulWidget {
  final ChurchUserModel thisUser;
  final int tabIndex;
  final bool fromPaymentsPage;
  final bool fromPaymentPageNewCard;

  UserPaymentMethodsPage({this.thisUser, this.tabIndex, this.fromPaymentsPage, this.fromPaymentPageNewCard});

  @override
  UserPaymentMethodsPageState createState() {
    return UserPaymentMethodsPageState();
  }
}


class UserPaymentMethodsPageState extends State<UserPaymentMethodsPage>
    with TickerProviderStateMixin {


  //---------- Initializers -----------
  ChurchDB churchDB;
  UserPaymentMethodsBLOC userPaymentMethodsBLOC;
  ChurchUserModel thisUser;
  DatabaseReference userCardRef;
  DatabaseReference userCardTitheTransactionsRef;
  DatabaseReference userCardOfferingTransactionsRef;


  //---------- Variables -----------
  var thisCard = CreditCardModel();
  var transactionStyle;

  //---------- ints -----------
  int paymentMethodIndex;
  int tabIndex;

  //---------- bools -----------
  bool fromPaymentsPage;
  bool fromPaymentPageNewCard;

  //---------- Colors -----------
  Color cardTextColor;

  //---------- Lists -----------
  List<CreditCardModel> cards = List();
  List<PaymentOrderModel> transactions = List();
  List<PaymentOrderModel> titheTransactions = List();
  List<PaymentOrderModel> offeringTransactions = List();

  //---------- Keys -----------
  final _formKey = GlobalKey<FormState>();


  //---------- functions -----------

  Color paymentMethodTabColor({int index}) {
    return userPaymentMethodsBLOC.paymentMethodTabColor(index: index, paymentMethodIndex: paymentMethodIndex);
  }

  Color paymentMethodTabMainTextColor({int index}) {
    return userPaymentMethodsBLOC.paymentMethodTabMainTextColor(index: index, paymentMethodIndex: paymentMethodIndex);
  }

  Color paymentMethodTabSubtextColor({int index}) {
    return userPaymentMethodsBLOC.paymentMethodTabSubtextColor(index: index, paymentMethodIndex: paymentMethodIndex);
  }


// Getting card transactions
  showCardTransactions(CreditCardModel thisPaymentCard) async {
      transactions = [];
      print("Style: $transactionStyle");
      if (transactionStyle == "tithe") {
        checkIfTransactionIsTithe(transactionStyle: transactionStyle, thisPaymentCard: thisPaymentCard);
      }else if (transactionStyle == "offering") {
        checkIfTransactionIsOffering(transactionStyle: transactionStyle, thisPaymentCard: thisPaymentCard);
      }
  }

  checkIfTransactionIsOffering({String transactionStyle,CreditCardModel thisPaymentCard})async{
    userPaymentMethodsBLOC.checkTransaction(
        transactionStyle: transactionStyle,
        transactionList: offeringTransactions,
        thisCard: thisPaymentCard).then((newTransactions) {
            if (newTransactions.isEmpty || newTransactions == null){
              transactions = [];
            }else{
              setState(() {
                transactions = newTransactions;
              });
              print("Transactions ${transactions.length}");
            }
        });
  }

  checkIfTransactionIsTithe({String transactionStyle, CreditCardModel thisPaymentCard}) async {
    userPaymentMethodsBLOC.checkTransaction(
        transactionStyle: transactionStyle,
        transactionList: titheTransactions,
        thisCard: thisPaymentCard).then((newTransactions) {
            if (newTransactions.isEmpty || newTransactions == null){
              transactions = [];
            }else{
              setState(() {
                transactions = newTransactions;
              });
              print("Transactions ${transactions.length}");
            }
        });
  }

  checkTransactionTitle({int index}){
    if (transactions != null && transactions.isNotEmpty){
      return Text("${transactions[index]
          .orderName}",
        style: TextStyle(
            fontSize: 20,
            color: Colors
                .blue
        ),
      );
    }
  }

  checkTransactionDescription({int index}){
    if (transactions != null && transactions.isNotEmpty){
      return Text("Transaction ${index + 1} description");
    }
  }

  checkTransactionTotalCost({int index}){
    if (transactions != null && transactions.isNotEmpty){
      return Text("\$${transactions[index]
          .orderTotalCost / 100}",
        style: TextStyle(
            fontSize: 20,
            color: Colors
                .blue
        ),
      );
    }
  }

  //---------

  setOtherCardDetails(){
    thisCard.expiryDate = "${thisCard.expiryMonth}/${thisCard.expiryYear} ";
    thisCard.cardHolderName = "${thisCard.firstName} ${thisCard.lastName}";
    thisCard.showBackView = false;
  }



  void handleSubmit({bool isFromPaymentsPage, bool isFromPaymentPageNewCard}) async {

    if (isFromPaymentsPage == true){
      // segue back to payments page
      final FormState form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        form.reset();

        setOtherCardDetails();
        //set card details to stripe
        await StripePaymentService.addPaymentMethodToCustomer(thisUser: thisUser, thisCard: thisCard).then((paymentMethodId) {
          //then sendNewCardData to FB
          print("Addable Payment Method Id: $paymentMethodId");
          //change card number
          var lastFourDigits = thisCard.cardNumber.substring(thisCard.cardNumber.length - 4);
          thisCard.cardNumber = "xxxx xxxx xxxx $lastFourDigits";
          thisCard.paymentId = paymentMethodId;
          print("last four digits: ${thisCard.cardNumber}");
          churchDB.launchUserCardsPath(thisUser, thisCard, "create");
          startAddCardAnimation();
        });



      }
    }else if (isFromPaymentPageNewCard == true){
      // segue back to payments page
      final FormState form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        form.reset();

        setOtherCardDetails();
        //set card details to stripe

        Navigator.pop(context, thisCard);
      }
    }{
      final FormState form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        form.reset();

        setOtherCardDetails();
        //set card details to stripe
        await StripePaymentService.addPaymentMethodToCustomer(thisUser: thisUser, thisCard: thisCard).then((paymentMethodId) {
          //then sendNewCardData to FB
          print("Addable Payment Method Id: $paymentMethodId");
          //change card number
          var lastFourDigits = thisCard.cardNumber.substring(thisCard.cardNumber.length - 4);
          thisCard.cardNumber = "xxxx xxxx xxxx $lastFourDigits";
          thisCard.paymentId = paymentMethodId;
          print("last four digits: ${thisCard.cardNumber}");
          churchDB.launchUserCardsPath(thisUser, thisCard, "create");
          startAddCardAnimation();
        });
      }
    }
  }

  //-----------------------


  @override
  void initState() {
    // TODO: implement initState


    //---------- Initial Setters -----------
    thisUser = widget.thisUser;
    print(thisUser.userUID);

    churchDB = ChurchDB();

    userPaymentMethodsBLOC = UserPaymentMethodsBLOC();

    transactionStyle = "offering";

    print("the is $transactionStyle style");

    paymentMethodIndex = 0;

    cardTextColor = Colors.white;

    fromPaymentsPage = widget.fromPaymentsPage;

    fromPaymentPageNewCard = widget.fromPaymentPageNewCard;


    if (widget.tabIndex == null){
      tabIndex = 0;
    }else{
      tabIndex = widget.tabIndex;
    }


    //---------- Reference Setters -----------

    userCardRef = userPaymentMethodsBLOC.getUserCardRef(thisUser);

    userCardTitheTransactionsRef = userPaymentMethodsBLOC.getUserCardTitheTransactionsRef(thisUser);

    userCardOfferingTransactionsRef = userPaymentMethodsBLOC.getUserCardOfferingTransactionsRef(thisUser);


    //---------- Animation Setters -----------

    // set the controller from GlobalAnimations chart
    addCardAlertAnimationController = userPaymentMethodsBLOC.getAddCardAlertAnimationController(thisClass: this);

    // set the profile update alertAnimation from GlobalAnimations chart
    addCardAlertAnimation = userPaymentMethodsBLOC.getAddCardAlertAnimation();
    addCardAlertBackgroundAnimation = userPaymentMethodsBLOC.getAddCardAlertBackgroundAnimation();


    //---------- Listener Setters -----------
    setListeners();
    super.initState();
  }


  setListeners() {
    userCardRef.onChildAdded.listen(_getCurrentUsersCardsEvent);
    userCardRef.onChildChanged.listen(_onCardChanged);
    userCardRef.onChildRemoved.listen(_onCardRemoved);

    userCardTitheTransactionsRef.onChildAdded.listen(_getUsersTithesEvent);
    userCardTitheTransactionsRef.onChildChanged.listen(_onUserTithesChanged);
    userCardTitheTransactionsRef.onChildRemoved.listen(_onUserTithesRemoved);

    userCardOfferingTransactionsRef.onChildAdded.listen(_getUsersOfferingEvent);
    userCardOfferingTransactionsRef.onChildChanged.listen(
        _onUserOfferingChanged);
    userCardOfferingTransactionsRef.onChildRemoved.listen(
        _onUserOfferingRemoved);
  }


  //setters

  //User
  _getCurrentUsersCardsEvent(Event event) {
    //thisUserInfo
    CreditCardModel thisCard = CreditCardModel.fromSnapshot(event.snapshot);
    if (thisCard.cardHolderName != null) {
      setState(() {
        cards.add(thisCard);
      });
    }
  }

  _onCardChanged(Event event) {
    var old = cards.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      cards[cards.indexOf(old)] = CreditCardModel.fromSnapshot(event.snapshot);
    });
  }


  _onCardRemoved(Event event) {
    var old = cards.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      cards.removeAt(cards.indexOf(old));
    });
  }



  // for tithe
  _getUsersTithesEvent(Event event) {
    //thisUserInfo
    PaymentOrderModel thisTithe = PaymentOrderModel.fromSnapshot(
        event.snapshot);
    print(thisTithe.paymentCardHolderName);
    if (thisTithe.paymentCardHolderName != null) {
      setState(() {
        titheTransactions.add(thisTithe);
      });
    }
  }

  _onUserTithesChanged(Event event) {
    var old = titheTransactions.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      titheTransactions[titheTransactions.indexOf(old)] =
          PaymentOrderModel.fromSnapshot(event.snapshot);
    });
  }


  _onUserTithesRemoved(Event event) {
    var old = titheTransactions.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      titheTransactions.removeAt(titheTransactions.indexOf(old));
    });
  }




  //for offering
  _getUsersOfferingEvent(Event event) {
    //thisUserInfo
    PaymentOrderModel thisOffering = PaymentOrderModel.fromSnapshot(
        event.snapshot);
    print(thisOffering.paymentCardHolderName);
    if (thisOffering.paymentCardHolderName != null) {
      setState(() {
        offeringTransactions.add(thisOffering);
      });
    }
  }

  _onUserOfferingChanged(Event event) {
    var old = offeringTransactions.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      offeringTransactions[offeringTransactions.indexOf(old)] =
          PaymentOrderModel.fromSnapshot(event.snapshot);
    });
  }


  _onUserOfferingRemoved(Event event) {
    var old = offeringTransactions.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      offeringTransactions.removeAt(offeringTransactions.indexOf(old));
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    //addCardAlertAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return DefaultTabController(
      initialIndex: tabIndex,
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: 75,
            color: Colors.blue,
            child: TabBar(
              tabs: [
                Tab(
                  child: Column(
                    children: [
                      Icon(Icons.list_alt),
                      Text("Transactions")
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Icon(Icons.library_add_sharp),
                      Text("Add A Card")
                    ],
                  ),
                ),
                Tab(
                  child:Column(
                    children: [
                      Icon(Icons.search),
                      Text("extra")
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: (){
                if (fromPaymentPageNewCard != null){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }else{
                  Navigator.pop(context, false);
                }
              },
            ),
            title: Text("Payment Methods"),
          ),
          body: Stack(
            children: [
              ListView(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // the card horizontal slider
                          Container(
                            child: ListView.builder(
                              itemCount: cards.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    print("Im tapped!!!");
                                    setState(() {
                                      paymentMethodIndex = index;
                                      print("index: $paymentMethodIndex");
                                      showCardTransactions(cards[index]);
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
                            height: 220,
                          ),
                          //end
                          SizedBox(
                            height: 20,
                          ),

                          //Recent Transactions text in horizontal slider
                          Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height - 415,
                                child: TabBarView(
                                  children: [
                                    Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets
                                                .symmetric(horizontal: 24.0),
                                            child: Text(
                                              "Recent Transactions",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight
                                                      .bold),
                                            ),
                                          ),

                                          SizedBox(
                                            height: 20,
                                          ),

                                          //Buttons for tithe and offering
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              FlatButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      transactionStyle = "tithe";
                                                    });
                                                  },
                                                  child: Text("Tithes")
                                              ),
                                              FlatButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      transactionStyle = "offering";
                                                    });
                                                  },
                                                  child: Text("Offerings")
                                              )
                                            ],
                                          ),


                                          //Recent Transactions data in horizontal slider
                                          Expanded(
                                            child: Container(
                                              //height: 375,
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .all(8),
                                                  child: Container(
                                                    //height: MediaQuery.of(context).size.height,
                                                    child: ListView.builder(
                                                        itemCount: transactions.length,
                                                        itemBuilder: (
                                                            BuildContext context,
                                                            int index) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (
                                                                      context) {
                                                                    return TransactionDetailPage(
                                                                      thisOrder: transactions[index],
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                            child: ClipRRect(
                                                              child: Container(
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      children: [
                                                                        Row(children: [
                                                                          Icon(
                                                                              Icons
                                                                                  .airplanemode_active_outlined),
                                                                          SizedBox(
                                                                            width: 10,),
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .symmetric(
                                                                                vertical: 8.0),
                                                                            child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment
                                                                                  .start,
                                                                              children: [
                                                                                checkTransactionTitle(index: index),
                                                                                checkTransactionDescription(index: index)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                        Row(children: [
                                                                          checkTransactionTotalCost(index: index),

                                                                        ]),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  )),
                                            ),
                                          ),
                                        ]
                                    ),
                                    //end

                                    //#2

                                    Column(
                                      children: [
                                        //#2
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          child: Text(
                                            "Add New Card",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ), Padding(
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
                                              handleSubmit(isFromPaymentsPage: fromPaymentsPage, isFromPaymentPageNewCard: fromPaymentPageNewCard);
                                            },
                                            child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  'Update Profile',
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
                                    Icon(Icons.directions_bike),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                  ]
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
                      if (fromPaymentsPage == true){
                        Navigator.pop(context, true);
                        //StripePaymentService.addCardToCustomer(thisUser: thisUser, thisCard: thisCard);
                      }else if (fromPaymentPageNewCard == true){
                        Navigator.pop(context, thisCard);
                      }else{
                        //StripePaymentService.addCardToCustomer(thisUser: thisUser, thisCard: thisCard);
                        //do nothing
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}