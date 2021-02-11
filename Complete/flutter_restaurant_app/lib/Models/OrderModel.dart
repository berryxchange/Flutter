import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';

abstract class OrderProtocol{
  List<MealModel> orderItems = List();
  int orderTotalCost;
  int orderSubtotal;
  int orderDeliveryCharges;
  int orderTax;
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
  int deliveryRating;
  String orderUserId;
  String paymentId;

  //--------- Setting items to cart ----------
  addThisItemToCart(MealModel thisMeal){
    //find the index
    findTheIndex(thisMeal: thisMeal);
  }

  findTheIndex({MealModel thisMeal}){
    var contains = false;
    var containedIndex = 0;

    for (var item in orderItems){
      //print(item.productDuplicates);
      if (item.productId == thisMeal.productId){
        contains = true;
        containedIndex = orderItems.indexOf(item);
      }
    }

    setContainedItems(
        contains: contains,
        containedIndex: containedIndex,
        thisMeal: thisMeal
    );
  }

  setContainedItems({bool contains, int containedIndex, MealModel thisMeal}){
    if (contains == true){
      //print("yay we can edit the product!!");
      print("Index: $containedIndex");
      orderItems[containedIndex].productDuplicates = thisMeal.productDuplicates;
      print("duplicates: ${orderItems[containedIndex].productDuplicates}");
    }else {
      print("I have no duplicates!");
      orderItems.add(thisMeal);
    }
    printItems();
  }

  printItems(){
    for (var product in globalCurrentOrder.orderItems){
      print("Item: ${product.productName}");
    }
  }



//--------- Configure Items in cart ----------
  configureOrder(){
    OrderModel thisNewOrder = this;

    //this.orderUserId = thisUser.uid;
    this.orderDeliveryCharges = 300;
    this.orderTax = 0;
    this.orderSubtotal = this.setSubtotal();
    this.orderTotalCost = this.setOrderTotal();

    return thisNewOrder;
  }

  int setSubtotal(){
    var total = 0;

    combine(a, b){
      return a + b;
    }

    for (var item in orderItems){
      var itemDuplicatedTotal = item.productPrice * item.productDuplicates;
       total = combine(total, itemDuplicatedTotal);
       print("total order cost is: $total");
    }

    return total;
  }


  int setOrderTotal(){
    var total = 0;

    combine(a, b){
      return a + b;
    }

    for (var item in orderItems){
      var itemDuplicatedTotal = item.productPrice * item.productDuplicates;
      total = combine(total, itemDuplicatedTotal);
      print("total order cost is: $total");
    }

    return total + orderDeliveryCharges + orderTax;
  }


  //--------- When Order Is Complete ----------
  onOrderComplete(){
    this.orderItems = [];
  }

  //---------

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


  int setOrderTotalItemsCount(){
    var total = 0;

    combine(a, b){
      return a + b;
    }

    for (var item in orderItems){
      var itemDuplicates = item.productDuplicates;
      total = combine(total, itemDuplicates);
      print("There are: $total items in total");
    }
    return total;
  }

  setOrderPaymentCardParameters(CreditCardModel userPaymentMethod){
    this.paymentFirstName =  userPaymentMethod.firstName;
    this.paymentLastName =  userPaymentMethod.lastName;
    this.paymentCardNumber =  userPaymentMethod.cardNumber;
    this.paymentExpiryDate =  userPaymentMethod.expiryDate;
    this.paymentExpiryMonth =  userPaymentMethod.expiryMonth;
    this.paymentExpiryYear =  userPaymentMethod.expiryYear;
    this.paymentCardHolderName =  userPaymentMethod.cardHolderName;
    this.paymentCvvCode =  userPaymentMethod.cvvCode;
    this.paymentId = userPaymentMethod.paymentId;
  }

  showData(){
    for (var i in this.orderItems){
      print("OrderItem Inventory: ${this.orderItems}");
    }
    print("orderTotalCost: ${this.orderTotalCost}");
    print("orderSubtotal: ${this.orderSubtotal}");
    print("orderDeliveryCharges: ${this.orderDeliveryCharges}");
    print("orderTax: ${this.orderTax}");
    print("purchaseDate: ${this.purchaseDate}");
    print("deliveryAddress: ${this.deliveryAddress}");
    print("deliveryCity: ${this.deliveryCity}");
    print("deliveryState: ${this.deliveryState}");
    print("deliveryZip: ${this.deliveryZip}");
    print("deliveryApartmentNumber: ${this.deliveryApartmentNumber}");
    print("paymentCardNumber: ${this.paymentCardNumber}");
    print("paymentExpiryDate: ${this.paymentExpiryDate}");
    print("paymentExpiryMonth: ${this.paymentExpiryMonth}");
    print("paymentExpiryYear: ${this.paymentExpiryYear}");
    print("paymentCardHolderName: ${this.paymentCardHolderName}");
    print("paymentCvvCode: ${this.paymentCvvCode}");
    print("paymentFirstName: ${this.paymentFirstName}");
    print("paymentLastName: ${this.paymentLastName}");
    print("orderName: ${this.orderName}");
    print("orderStatus: ${this.orderStatus}");
    print("deliveryRating: ${this.deliveryRating}");
    print("orderUserId: ${this.orderUserId}");
    print("paymentId: ${this.paymentId}");
  }
}




class OrderModel extends OrderProtocol{
  var key;
  Map<dynamic, dynamic> loggedOrderItems;
  var orderItems = List();
  var orderTotalCost = 899;
  var orderSubtotal = 0;
  var orderDeliveryCharges = 0;
  var orderTax = 0;
  var purchaseDate = "";
  var productImage = "";
  var orderName;
  var orderStatus = "Awaiting for processing";
  var deliveryRating = 0;
  var deliveryAddress;
  var deliveryCity;
  var deliveryState;
  var deliveryZip;
  var deliveryApartmentNumber;
  var paymentFirstName;
  var paymentLastName;
  var paymentCardNumber;
  var paymentExpiryDate;
  var paymentExpiryMonth;
  var paymentExpiryYear;
  var paymentCardHolderName;
  var paymentCvvCode;
  var orderUserId;
  var paymentId;

  OrderModel({
    this.orderItems,
    this.orderTotalCost,
    this.orderSubtotal,
    this.orderDeliveryCharges,
    this.orderTax,
    this.purchaseDate,
    this.productImage,
    this.orderName,
    this.orderStatus,
    this.deliveryRating,
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
    this.paymentId
  });


  OrderModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        loggedOrderItems = snapshot.value["orderItems"],
        orderTotalCost = snapshot.value["orderTotalCost"],
        orderSubtotal = snapshot.value["orderSubtotal"],
        orderDeliveryCharges = snapshot.value["orderDeliveryCharges"],
        orderTax = snapshot.value["orderTax"],
        purchaseDate = snapshot.value["purchaseDate"],
        productImage = snapshot.value["productImage"],
        orderName = snapshot.value["orderName"],
        orderStatus = snapshot.value["orderStatus"],
        deliveryRating = snapshot.value["deliveryRating"],
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
        paymentId = snapshot.value["paymentId"];


  toJson() {
    return {
      //"orderItems": orderItems,
      "orderTotalCost": orderTotalCost,
      "orderSubtotal": orderSubtotal,
      "orderDeliveryCharges": orderDeliveryCharges,
      "orderTax": orderTax,
      "purchaseDate": purchaseDate,
      "productImage": productImage,
      "orderName": orderName,
      "orderStatus": orderStatus,
      "deliveryRating": deliveryRating,
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
      "paymentId": paymentId
    };
  }
}


//order Model

OrderModel globalCurrentOrder = OrderModel(
  orderItems: [],
  orderTotalCost: 0,
  purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
  productImage: "",
  orderName: "",
  orderStatus: "",
  orderDeliveryCharges: 0,
  orderSubtotal: 0,
  orderTax: 0,
  deliveryRating: 0,
  deliveryAddress: "",
  deliveryCity: "",
  deliveryState: "",
  deliveryZip: "",
  deliveryApartmentNumber: "",
  paymentFirstName: "",
  paymentLastName: "",
  paymentCardNumber: "",
  paymentExpiryDate: "",
  paymentExpiryMonth: 0,
  paymentExpiryYear: 0,
  paymentCardHolderName: "",
  paymentCvvCode: "",
  paymentId: "",
);
