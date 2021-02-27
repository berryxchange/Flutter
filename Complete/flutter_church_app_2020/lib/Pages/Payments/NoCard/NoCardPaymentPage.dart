import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Models/CreditCardModel.dart';

class NoCardPaymentPage extends StatefulWidget {
  static String id = "no_card_page";
  ChurchUserModel thisUser;

  NoCardPaymentPage({this.thisUser});

  @override
  _NoCardPaymentPageState createState() => _NoCardPaymentPageState();
}

class _NoCardPaymentPageState extends State<NoCardPaymentPage> {

  //---------- Variables -----------
  var thisCard = CreditCardModel();

  //---------- Keys -----------
  final _formKey = GlobalKey<FormState>();


setOtherCardDetails(){
    thisCard.expiryDate = "${thisCard.expiryMonth}/${thisCard.expiryYear} ";
    thisCard.cardHolderName = "${thisCard.firstName} ${thisCard.lastName}";
    thisCard.showBackView = false;
  }

void handleSubmit() async {

  // segue back to payments page
  final FormState form = _formKey.currentState;
  if (form.validate()) {
    form.save();
    form.reset();

    setOtherCardDetails();
    //set card details to stripe

    Navigator.pop(context, thisCard);
  } 
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("No Card Page"),
      ),
      body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20, bottom: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                                child: Form ( 
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Center(
                  child: Container(
                    height: 300,
                    //color: Colors.blueAccent,
                    child: Image.asset("Assets/Wallet.png"),
                  ),
                ),
              ),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "First Name",
                      labelStyle: TextStyle(
                          fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold),
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

                  SizedBox(
                        height: 20,
                      ),


                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      labelStyle: TextStyle(
                          fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold),
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

                  SizedBox(
                        height: 20,
                      ),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Card Number",
                      labelStyle: TextStyle(
                          fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
                  SizedBox(
                        height: 20,
                      ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Exp Month",
                            labelStyle: TextStyle(
                                fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
                                fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
                                fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0,
                        bottom: 30,
                        left: 24,
                        right: 24),
                    child: OutlineButton(
                      borderSide: BorderSide(
                          width: 2, color: Colors.grey),
                      onPressed: () {
                        handleSubmit();
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Submit Donation',
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
        ),
        ),
        ),
      ),
        
    );
  }
}
