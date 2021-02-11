import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Models/CreditCardModel.dart';
import 'package:flutter_church_app_2020/Models/PaymentOrderModel.dart';
import 'package:flutter_church_app_2020/Animations/GlobalAnimations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';

class UserPaymentMethodsBLOC {
  ChurchDB churchDB;

  //---------- Initializers -----------

  getUserCardRef(ChurchUserModel thisUser){
    return FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child("${thisUser.userUID}")
        .child("Cards");
  }

  getUserCardTitheTransactionsRef(ChurchUserModel thisUser){
    return FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child("${thisUser.userUID}")
        .child("Orders")
        .child("tithe");
  }

  getUserCardOfferingTransactionsRef(ChurchUserModel thisUser){
    return FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child("${thisUser.userUID}")
        .child("Orders")
        .child("offering");
  }


  //---------- Variables -----------
PaymentOrderModel thisTransaction;


  //---------- ints -----------


  //---------- Lists -----------
  List<PaymentOrderModel> transactions = List();
  List<PaymentOrderModel> emptyTransactions = [
    PaymentOrderModel(
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

  Future checkTransaction({String transactionStyle, List<PaymentOrderModel> transactionList, CreditCardModel thisCard})async{
    transactions = [];
    thisTransaction = PaymentOrderModel();

    if (transactionStyle == "tithe"){
      print("Tithe section clicked");
      for (PaymentOrderModel transaction in transactionList) {
        //return a list of transactions
        checkMatchingCardHolderNames(
            transaction: transaction,
            thisCard: thisCard);
      }
    }

    if (transactionStyle == "offering") {
      print("Offering section clicked");
      for (PaymentOrderModel transaction in transactionList) {
        //return a list of transactions
        checkMatchingCardHolderNames(
            transaction: transaction,
            thisCard: thisCard);
      }
    }

    print("Total Transactions: ${transactions.length}");

    return transactions;
  }


  Future checkMatchingCardHolderNames({PaymentOrderModel transaction, CreditCardModel thisCard}) async {

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

  setTransaction(PaymentOrderModel transaction){
    thisTransaction = transaction;
      transactions.add(transaction);
      return thisTransaction;
  }
  
  
  //---------- Futures -----------


  UserPaymentMethodsBLOC(){
    churchDB = ChurchDB();
  }
}