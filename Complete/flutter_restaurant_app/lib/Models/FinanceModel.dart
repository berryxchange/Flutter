import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'DeliveryAddressModel.dart';
import 'MealModel.dart';

abstract class FinanceProtocol {
  List<CreditCardModel> cOF;
  List<OrderModel> previousOrders;
  List<OrderModel> currentOrders;
  OrderModel thisOrder;
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

  var previousOrders = List();
  var currentOrders = List();
  var thisOrder = OrderModel();

  FinanceModel({
    this.cOF,
    this.previousOrders,
    this.currentOrders,
    this.thisOrder
  });
}

