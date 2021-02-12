import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class PaymentOptionCardProtocol{

  String title;
  String description;
  String color;
  String paymentType;
}


class PaymentOptionCardModel extends PaymentOptionCardProtocol{
  var key;
  var title;
  var description;
  var color;
  var paymentType;

  PaymentOptionCardModel({
    this.title,
    this.description,
    this.color,
    this.paymentType
  });

  PaymentOptionCardModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        description = snapshot.value["description"],
        color = snapshot.value["color"],
        paymentType = snapshot.value["paymentType"];



  toJson() {
    return {
      "title": title,
      "description": description,
      "color": color,
      "paymentType": paymentType
    };
  }
}