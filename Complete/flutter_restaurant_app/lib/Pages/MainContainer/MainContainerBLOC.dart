//System
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

//Fire3base
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';

//Other


class MainContainerBLOC{
  RestaurantDB restaurantDB;
  FirebaseAuth _auth = AuthCentral.auth;
  UserCredential firebaseUser;


  //---------- BLOC Logic ------------


  //Navigation
  Future logOut(BuildContext context, VoidCallback onSignOut) async {
    try {
      onSignOut();
    } catch (error) {
      print(error);
    }
  }


  // for current User
  Future<User> checkLogedInUser() async {
    User thisCurrentUser;
    try {
      final thisUser = _auth.currentUser;
      thisCurrentUser = setCurrentUser(thisUser);
    } catch (error) {
      print("something went wrong: $error");
    }
    return thisCurrentUser;
  }


  setCurrentUser(User thisUser){
    User thisCurrentUser;

    if (thisUser != null) {
      thisCurrentUser = thisUser;
      print(thisCurrentUser.email);
      print(thisCurrentUser.uid);

      print("Current user is setup");
    } else {
      print("this user is not in the database...");
    }
    return thisCurrentUser;
  }


  //setting User Data
  checkAndSetUserData({Event event}){
    UserModel thisUser;

    if (event.snapshot.key == "thisUserInfo") {
      var userData = UserModel.fromSnapshot(event.snapshot);
        thisUser = userData;
    }else{
      print("Something is not right... here: ${event.snapshot.key}");
    }
    return thisUser;
  }



//------------- Futures --------------

//---------- The Constructor ------------
  MainContainerBLOC(){
    restaurantDB = RestaurantDB();
  }
}