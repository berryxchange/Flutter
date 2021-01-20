import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Models/CreditCardModel.dart';

// Create a Form widget.
class AddNewPaymentCardFormPage extends StatefulWidget {

  UserModel thisUser;

  AddNewPaymentCardFormPage({this.thisUser});

  @override
  AddNewPaymentCardFormPageState createState() {
    return AddNewPaymentCardFormPageState();
  }
}

class AddNewPaymentCardFormPageState extends State<AddNewPaymentCardFormPage> {

  final _formKey = GlobalKey<FormState>();


  var thisCard = CreditCardModel(
    firstName: "",
    lastName: "",
    cardNumber: "",
    expiryDate: "",
    expiryMonth: 0,
    expiryYear: 0,
    cardHolderName: "",
    cvvCode: "",
  );

  void handleSubmit() {
    final FormState form = _formKey.currentState;

    // Validate will return true if the form is valid, or false if
    // the form is invalid.

    if (form.validate()) {
      form.save();
      form.reset();
      // put data below form.save()
      thisCard.expiryDate = "${thisCard.expiryMonth}/${thisCard.expiryYear} ";
      thisCard.cardHolderName = "${thisCard.firstName} ${thisCard.lastName}";
      thisCard.showBackView = false;
      widget.thisUser.addCardToList(thisCard);

      print("Set to list : ${widget.thisUser.finance.cOF[0].firstName}");
      Navigator.pop(context);
    }
  }


  void handleUpdate(){
    //prayerRef.push().update((prayer.toJson()));
  }
  //-----------------------



  @override
  Widget build(BuildContext context) {




    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text("Add A Card"),
      ),
      body: ListView(

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[


                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.border_color,
                            ),
                            labelText: "First Name",
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ) ,
                          ),
                          onSaved: (value){
                            setState(() {
                              thisCard.firstName = value;
                            });
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
                            prefixIcon: Icon(
                              Icons.border_color,
                            ),
                            labelText: "Last Name",
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ) ,
                          ),
                          onSaved: (value){
                            setState(() {
                              thisCard.lastName = value;
                            });
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
                            prefixIcon: Icon(
                              Icons.border_color,
                            ),
                            labelText: "Card Number",
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ) ,
                          ),
                          onSaved: (value){
                            setState(() {
                              thisCard.cardNumber = value;
                            });
                            print(thisCard.cardNumber);
                            return null;

                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Card Number';
                            }
                            return null;
                          },
                        ),


                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.border_color,
                            ),
                            labelText: "Card Expiration Month",
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ) ,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],

                          onSaved: (value){
                            setState(() {
                              var numberData = int.parse(value);
                              thisCard.expiryMonth = numberData;
                            });
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


                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.border_color,
                            ),
                            labelText: "Expiration Year",
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ) ,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],

                          onSaved: (value){
                            setState(() {
                              var numberData = int.parse(value);
                              thisCard.expiryYear = numberData;
                            });
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

                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.border_color,
                            ),
                            labelText: "CVV",
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ) ,
                          ),
                          onSaved: (value){
                            setState(() {
                              thisCard.cvvCode = value;
                            });
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


                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child:
                          OutlineButton(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.grey
                            ),
                            onPressed: () {

                              handleSubmit();
                            },
                            child: Text('Submit'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}