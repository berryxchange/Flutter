import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

abstract class PaymentOrderProtocol{
  int titheTotalCost;
  String purchaseDate;
  String deliveryAddress;
  String deliveryCity;
  String deliveryState;
  String deliveryZip;
  String deliveryApartmentNumber;
  String paymentCardNumber;
  String paymentExpiryDate;
  int paymentExpiryMonth;
  int paymentExpiryYear;
  String paymentCardHolderName;
  String paymentCvvCode;
  String paymentFirstName;
  String paymentLastName;
  String orderName;
  String orderStatus;
  String orderUserId;
  String paymentType;
  String paymentId;


  Color checkOrderStatusColor(){
    switch (orderStatus){
      case "Waiting for processing":
        return Colors.amber;
        break;
      case "Completed":
        return Colors.green;
        break;
      case "Refunded":
        return Colors.black;
        break;
      case "Cancelled":
        return Colors.red;
        break;
    }
    return Colors.black;
  }
}


class PaymentOrderModel extends PaymentOrderProtocol{
  var key;
  var orderTotalCost = 0;
  var purchaseDate;
  var deliveryAddress;
  var deliveryCity;
  var deliveryState;
  var deliveryZip;
  var deliveryApartmentNumber;
  var paymentCardNumber;
  var paymentExpiryDate;
  var paymentExpiryMonth;
  var paymentExpiryYear;
  var paymentCardHolderName;
  var paymentCvvCode;
  var paymentFirstName;
  var paymentLastName;
  var orderName;
  var orderStatus;
  var orderUserId;
  var paymentType;
  var paymentId;


  PaymentOrderModel({
    this.orderTotalCost,
    this.purchaseDate,
    this.orderName,
    this.orderStatus,
    this.deliveryAddress,
    this.deliveryCity,
    this.deliveryState,
    this.deliveryZip,
    this.deliveryApartmentNumber,
    this.paymentFirstName,
    this.paymentLastName,
    this.paymentCardNumber,
    this.paymentExpiryDate,
    this.paymentExpiryMonth,
    this.paymentExpiryYear,
    this.paymentCardHolderName,
    this.paymentCvvCode,
    this.orderUserId,
    this.paymentType,
    this.paymentId
  });


  PaymentOrderModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        orderTotalCost = snapshot.value["orderTotalCost"],
        purchaseDate = snapshot.value["purchaseDate"],
        orderName = snapshot.value["orderName"],
        orderStatus = snapshot.value["orderStatus"],
        deliveryAddress = snapshot.value["deliveryAddress"],
        deliveryCity = snapshot.value["deliveryCity"],
        deliveryState = snapshot.value["deliveryState"],
        deliveryZip = snapshot.value["deliveryZip"],
        deliveryApartmentNumber = snapshot.value["deliveryApartmentNumber"],
        paymentFirstName = snapshot.value["paymentFirstName"],
        paymentLastName = snapshot.value["paymentLastName"],
        paymentCardNumber = snapshot.value["paymentCardNumber"],
        paymentExpiryDate = snapshot.value["paymentExpiryDate"],
        paymentExpiryMonth = snapshot.value["paymentExpiryMonth"],
        paymentExpiryYear = snapshot.value["paymentExpiryYear"],
        paymentCardHolderName = snapshot.value["paymentCardHolderName"],
        paymentCvvCode = snapshot.value["paymentCvvCode"],
        orderUserId = snapshot.value["orderUserId"],
        paymentType = snapshot.value["paymentType"],
        paymentId = snapshot.value["paymentId"];


  toJson() {
    return {
      //"orderItems": orderItems,
      "orderTotalCost": orderTotalCost,
      "purchaseDate": purchaseDate,
      "orderName": orderName,
      "orderStatus": orderStatus,
      "deliveryAddress": deliveryAddress,
      "deliveryCity":  deliveryCity,
      "deliveryState" : deliveryState,
      "deliveryZip": deliveryZip,
      "deliveryApartmentNumber": deliveryApartmentNumber,
      "paymentFirstName": paymentFirstName,
      "paymentLastName": paymentLastName,
      "paymentCardNumber": paymentCardNumber,
      "paymentExpiryDate": paymentExpiryDate,
      "paymentExpiryMonth": paymentExpiryMonth ,
      "paymentExpiryYear": paymentExpiryYear,
      "paymentCardHolderName": paymentCardHolderName,
      "paymentCvvCode": paymentCvvCode,
      "orderUserId": orderUserId,
      "paymentType": paymentType,
      "paymentId": paymentId
    };
  }
}



List<PaymentOrderModel> demoOrders = [
  PaymentOrderModel(
    orderTotalCost: 10700,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "2EJH9J",
    orderStatus: "Completed",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 4500,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "66JH9B",
    orderStatus: "Completed",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 31200,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "37KH9J",
    orderStatus: "Cancelled",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 2000,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "2EJPP1",
    orderStatus: "Refunded",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),
  PaymentOrderModel(
    orderTotalCost: 10700,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "2EJH9J",
    orderStatus: "Completed",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 4500,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "66JH9B",
    orderStatus: "Completed",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 31200,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "37KH9J",
    orderStatus: "Cancelled",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 2000,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "2EJPP1",
    orderStatus: "Refunded",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),
  PaymentOrderModel(
    orderTotalCost: 10700,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "2EJH9J",
    orderStatus: "Completed",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 4500,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "66JH9B",
    orderStatus: "Completed",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 31200,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "37KH9J",
    orderStatus: "Cancelled",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 2000,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "2EJPP1",
    orderStatus: "Refunded",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),
  PaymentOrderModel(
    orderTotalCost: 10700,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "2EJH9J",
    orderStatus: "Completed",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 4500,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "66JH9B",
    orderStatus: "Completed",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 31200,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "37KH9J",
    orderStatus: "Cancelled",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),

  PaymentOrderModel(
    orderTotalCost: 2000,
    purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
    orderName: "2EJPP1",
    orderStatus: "Refunded",
    deliveryAddress: "7708 N.W. 84th st",
    deliveryCity: "Oklahoma City",
    deliveryState: "Oklahoma",
    deliveryZip: "73132",
    deliveryApartmentNumber: "8A",
    paymentFirstName: "Quinton",
    paymentLastName: "D",
    paymentCardNumber: "4242424242424242",
    paymentExpiryDate: "04/24",
    paymentExpiryMonth: 04,
    paymentExpiryYear: 24,
    paymentCardHolderName: "Quinton D",
    paymentCvvCode: "423",
    orderUserId: "ASF23983dSAcj",
  ),
];