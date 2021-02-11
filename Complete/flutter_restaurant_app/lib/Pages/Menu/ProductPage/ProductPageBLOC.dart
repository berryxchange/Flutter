import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
class ProductPageBLOC{

  FirebaseAuth auth = AuthCentral.auth;
  RestaurantDB restaurantDB;

//---------- BLOC Logic ------------


  // set the alertAnimation from GlobalAnimations chart
  getAddedToCartAlertAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        addedToCartAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  getAddedToCartAlertBackgroundAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        addedToCartAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  // set the alertAnimation from GlobalAnimations chart
  getAddedToCartAlertFromCartAlertBackgroundAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        addedToCartAlertFromCartAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  getAddedToCartAlertFromCartAlertAnimation(){
   return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        addedToCartAlertFromCartAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }


  increaseAmount(MealModel thisMeal){
    return thisMeal.productDuplicates += 1;
  }

  decreaseAmount(MealModel thisMeal){
    MealModel thisNewMeal = thisMeal;

    if (thisNewMeal.productDuplicates == 1){
      thisNewMeal.productDuplicates = 1;
    }else{
      thisNewMeal.productDuplicates -= 1;
    }
    return thisNewMeal.productDuplicates;
  }
//----------------- Futures ---------------


  ProductPageBLOC(){
    restaurantDB = RestaurantDB();
  }
}