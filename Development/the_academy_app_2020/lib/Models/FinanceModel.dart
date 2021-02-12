import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CreditCardModel.dart';
import 'package:the_academy_app_2020/Models/paymentModel.dart';

abstract class FinanceProtocol {
  List<CrediCardProtocol> cOF;
  List<PaymentProtocol> previousPayments;
}

class FinanceModel extends FinanceProtocol{
  var cOF = [
    CreditCardModel(
      firstName: "Quinton",
      lastName: "D",
      cardNumber: "4242424242424242",
      expiryDate: "04/24",
      expiryMonth: 04,
      expiryYear: 24,
      cardHolderName: "Quinton D",
      cvvCode: "423",
      showBackView: false,
    ),
  ];

  var previousPayments = [
    PaymentModel(
      productName: "Traveling In China 2020",
      productTotalCost: "999.99",
      purchaseDate: DateTime.now().toString(),
      productSellingCategory: "Premium",
      productTerm: "Year",
    ),
  ];

  FinanceModel({
    this.cOF,
    this.previousPayments
  });

}

FinanceModel myFinanceOne = FinanceModel(
  cOF: List(),
    previousPayments: []
);

FinanceModel myFinanceTwo = FinanceModel(
    cOF: [
      CreditCardModel(
        firstName: "Quinton",
        lastName: "D",
        cardNumber: "4242424242424242",
        expiryDate: "04/24",
        expiryMonth: 04,
        expiryYear: 24,
        cardHolderName: "Quinton D",
        cvvCode: "423",
        showBackView: false,
      )
    ],
  previousPayments: [
    PaymentModel(
      productName: "Traveling In China 2021",
      productTotalCost: "999.99",
      purchaseDate: DateTime.now().toString(),
      productSellingCategory: "Premium",
      productTerm: "Year",
    ),
    PaymentModel(
      productName: "Traveling In Japan 2020",
      productTotalCost: "49.99",
      purchaseDate: DateTime.now().toString(),
      productSellingCategory: "Regular",
      productTerm: "Year",
    ),
    PaymentModel(
      productName: "Traveling In Italy 2020",
      productTotalCost: "499.99",
      purchaseDate: DateTime.now().toString(),
      productSellingCategory: "All-Access",
      productTerm: "Year",
    ),
    PaymentModel(
      productName: "Traveling In France 2020",
      productTotalCost: "999.99",
      purchaseDate: DateTime.now().toString(),
      productSellingCategory: "Premium",
      productTerm: "Year",
    ),
  ]
); 
