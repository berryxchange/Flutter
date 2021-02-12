import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Models/PaymentOptionCardModel.dart';


class TitheAndOfferingBLOC{

  //------------- Initializers ---------------
  ChurchDB churchDB;

  //------------- List ----------------

  List<PaymentOptionCardModel> paymentOptions = [
    PaymentOptionCardModel(
        title: "Send A Tithe",

        description: "Looking to send in your 10%?",
        color: "Color(0xff7c4dff)",
        paymentType: "tithe"
    ),
    PaymentOptionCardModel(
      title: "Send An Offering",
      description: "Every little, is MUCH in the Kingdom",
      color: "Color(0xffff5722)",
      paymentType: "offering",
    )
  ];


  //------------- BLOC Logic ---------------

  // ------------ Futures ------------------


  TitheAndOfferingBLOC(){
    churchDB = ChurchDB();
  }
}