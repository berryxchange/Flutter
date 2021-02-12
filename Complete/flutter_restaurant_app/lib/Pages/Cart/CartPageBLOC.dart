import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';

class CartPageBLOC{

  FirebaseAuth auth = AuthCentral.auth;
  RestaurantDB restaurantDB;

//---------- BLOC Logic ------------
// set the profile update alertAnimation from GlobalAnimations chart
  getDeleteItemFromListAlertAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        deleteItemFromListAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  getDeleteItemFromListAlertBackgroundAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        deleteItemFromListAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

//----------------- Futures ---------------


  CartPageBLOC(){
    restaurantDB = RestaurantDB();
  }
}