import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';

Container NewCardFormWithFloatingCardWidget(BuildContext context, GlobalKey formKey, CreditCardModel thisCard) {
  return Container(
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
      key: formKey,
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
  );
}
