import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/PaymentPage/PaymentPage.dart';
import 'package:flutter_church_app_2020/Models/PaymentSourceModel.dart';


class PaymentMethodSelectionBLOC{
  FirebaseAuth auth;

  //---------- Variables -----------
  double paymentAmount = 0.00;


  //---------- Lists -----------
  List<PaymentSourceModel> paymentSources = [
    PaymentSourceModel(
        title: "Debit",
        action: "debit"
    ),
    PaymentSourceModel(
        title: "Paypal",
        action: "paypal"
    ),
    /*PaymentSourceModel(
        title: "Square",
        action: "square"
    ),
    PaymentSourceModel(
        title: "Venmo",
        action: "venmo"
    ),
    PaymentSourceModel(
        title: "Kabbage",
        action: "kabbage"
    ),
    */
  ];

  //---------- BLOC Logic -----------

  launchPaymentURL() async {
    const url = 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=4GZZCSU6KV5R2';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  //---------- Futures -----------

  PaymentMethodSelectionBLOC(){
    auth = AuthCentral.auth;
  }
}