//System
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

//Fire3base
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Pages/Ministries/MinistriesBLOC.dart';
import 'package:firebase_database/firebase_database.dart';

//Other


class MainSelectionsBLOC{
  ChurchDB churchDB;
  FirebaseAuth _auth = AuthCentral.auth;
  UserCredential firebaseUser;
  MinistriesBLOC ministriesBLOC = MinistriesBLOC();

  //---------- BLOC Logic ------------


  //Navigation
  Future logOut(BuildContext context, VoidCallback onSignOut) async {
    try {
      onSignOut();
    } catch (error) {
      print(error);
    }
  }


  runSystemChecks(BuildContext context, systemChecks){
    Future.delayed(const Duration(milliseconds: 500), () {
      ministriesBLOC.runSystemChecks(context, systemChecks);
    });
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
    ChurchUserModel thisUser;

    if (event.snapshot.key == "thisUserInfo") {
      var userData = ChurchUserModel.fromSnapshot(event.snapshot);
        thisUser = userData;
    }else{
      print("Something is not right... here: ${event.snapshot.key}");
    }
    return thisUser;
  }



//------------- Futures --------------

//---------- The Constructor ------------
  MainSelectionsBLOC(){
    churchDB = ChurchDB();
  }
}