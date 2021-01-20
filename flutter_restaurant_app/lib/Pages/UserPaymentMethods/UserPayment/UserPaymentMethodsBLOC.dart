import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';

class UserPaymentMethodsBLOC {
  RestaurantDB restaurantDB;

  //---------- Initializers -----------

  getUserCardRef(UserModel thisUser){
    return FirebaseDatabase.instance
        .reference()
        .child('users')
        .child("${thisUser.uid}")
        .child("Cards");
  }

  getUserCardTitheTransactionsRef(UserModel thisUser){
    return FirebaseDatabase.instance
        .reference()
        .child('users')
        .child("${thisUser.uid}")
        .child("Orders")
        .child("tithe");
  }

  getUserCardOfferingTransactionsRef(UserModel thisUser){
    return FirebaseDatabase.instance
        .reference()
        .child('users')
        .child("${thisUser.uid}")
        .child("Orders")
        .child("offering");
  }


  //---------- Variables -----------
OrderModel thisTransaction;


  //---------- ints -----------


  //---------- Lists -----------
  List<OrderModel> transactions = List();
  List<OrderModel> emptyTransactions = [
    OrderModel(
      orderTotalCost: 0,
      purchaseDate: "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
      orderName: "N/A",
      orderStatus: "N/A",
      deliveryAddress: "N/A",
      deliveryCity: "N/A",
      deliveryState: "N/A",
      deliveryZip: "N/A",
      deliveryApartmentNumber: "N/A",
      paymentFirstName: "N/A",
      paymentLastName: "N/A",
      paymentCardNumber: "N/A",
      paymentExpiryDate: "N/A",
      paymentExpiryMonth: 00,
      paymentExpiryYear: 00,
      paymentCardHolderName: "N/A",
      paymentCvvCode: "N/A",
      orderUserId: "N/A",
    ),
  ];

  //---------- Animations -----------


  getAddCardAlertAnimationController({thisClass}){
    return alertController(
        duration: Duration(seconds: 1),
        thisClass: thisClass
    ); //required
  }

  getPaymentCompleteAlertAnimationController({thisClass}){
    return alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //required
  }


  getAddCardAlertAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: addCardAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

  }

  getAddCardAlertBackgroundAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: addCardAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);
  }


  //---------- Colors -----------
  Color paymentMethodTabColor({int index, int paymentMethodIndex}) {
    if (paymentMethodIndex == index) {
      return ThemeData().primaryColor;
    } else {
      return Colors.white;
    }
  }


  Color paymentMethodTabMainTextColor({int index, int paymentMethodIndex}) {
    if (paymentMethodIndex == index) {
      return Colors.white;
    } else {
      return Colors.black54;
    }
  }


  Color paymentMethodTabSubtextColor({int index, int paymentMethodIndex}) {
    if (paymentMethodIndex == index) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }

  //---------- BLOC Logic -----------

  Future checkTransaction({String transactionStyle, List<OrderModel> transactionList, CreditCardModel thisCard})async{
    transactions = [];
    thisTransaction = OrderModel();

    if (transactionStyle == "tithe"){
      print("Tithe section clicked");
      for (OrderModel transaction in transactionList) {
        //return a list of transactions
        checkMatchingCardHolderNames(
            transaction: transaction,
            thisCard: thisCard);
      }
    }

    if (transactionStyle == "offering") {
      print("Offering section clicked");
      for (OrderModel transaction in transactionList) {
        //return a list of transactions
        checkMatchingCardHolderNames(
            transaction: transaction,
            thisCard: thisCard);
      }
    }

    print("Total Transactions: ${transactions.length}");

    return transactions;
  }


  Future checkMatchingCardHolderNames({OrderModel transaction, CreditCardModel thisCard}) async {

    if (thisCard.cardHolderName == transaction.paymentCardHolderName) {
      print("Cardholder Name: ${thisCard.cardHolderName}");
      print("transaction cardholder Name: ${transaction.paymentCardHolderName}");
      setTransaction(transaction);
    } else {
      print("Cardholder Name: ${thisCard.cardHolderName}");
      print("transaction cardholder Name: ${transaction.paymentCardHolderName}");
      print("There are no transactions with this card...");
    }
    return thisTransaction;
  }

  setTransaction(OrderModel transaction){
    thisTransaction = transaction;
      transactions.add(transaction);
      return thisTransaction;
  }
  
  
  //---------- Futures -----------


  UserPaymentMethodsBLOC(){
    restaurantDB = RestaurantDB();
  }
}