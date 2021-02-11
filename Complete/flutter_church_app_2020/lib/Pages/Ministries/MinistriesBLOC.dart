//System
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

//Firebase
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_church_app_2020/Models/MinistryModel.dart';
import 'package:flutter_church_app_2020/Models/SystemCheckModel.dart';
//Other



class MinistriesBLOC{
  ChurchDB churchDB;
  AuthCentral _auth = AuthCentral();
  UserCredential firebaseUser;
  //Instances

  bool isInUse = false;
   // directory for ministries

  //---------- BLOC Logic -----------
  //Get all Ministry
  Future getMinistries(BuildContext context) async{
    List<MinistryModel> ministries = churchDB.launchMinistryPath(
        context: context,
        ministryModel: null,
        isAdmin: false,
        actionToDo: "read"
    );
    return ministries;
  }

  //Set All Ministries
  setAllMinistries(BuildContext context){
    setBibleMinistry(context: context, isAdmin: true, isInUse: true);
    setChatMinistry(context: context, isAdmin: true, isInUse: true);
    setEventMinistry(context: context, isAdmin: true, isInUse: true);
    setMediaMinistry(context: context, isAdmin: true, isInUse: true);
    setPastoralMinistry(context: context, isAdmin: true, isInUse: true);
    setPrayerMinistry(context: context, isAdmin: true, isInUse: true);
    setSocialMinistry(context: context, isAdmin: true, isInUse: true);
    setTithesAndOfferingMinistry(context: context, isAdmin: true, isInUse: true);
  }


  //Checks

  setAllMinistryChecks(BuildContext context){
    for (var i in demoMinistries){
      churchDB.launchMinistryPath(
          context: context,
          ministryModel: i,
          isAdmin: true,
          actionToDo: "createChecks"
      );
    }
  }


  runSystemChecks(BuildContext context, List<SystemCheckModel> systemChecks){
    for (SystemCheckModel i in systemChecks){
      switch(i.key){
        case "Bible":
          print("is Bible");
          (i.inUse == true)
              ? setBibleMinistry(context: context, isAdmin: true, isInUse: true)
              : setBibleMinistry(context: context, isAdmin: true, isInUse: false);
          break;
        case "Chat":
          print("is Chat");
          (i.inUse == true)
              ? setChatMinistry(context: context, isAdmin: true, isInUse: true)
              : setChatMinistry(context: context, isAdmin: true, isInUse: false);
          break;
        case "Events":
          print("is Events");
          (i.inUse == true)
              ? setEventMinistry(context: context, isAdmin: true, isInUse: true)
              : setEventMinistry(context: context, isAdmin: true, isInUse: false);
          break;
        case "Media":
          print("is Media");
          (i.inUse == true)
              ? setMediaMinistry(context: context, isAdmin: true, isInUse: true)
              : setMediaMinistry(context: context, isAdmin: true, isInUse: false);
          break;
        case "Pastoral":
          print("is Pastoral");
          (i.inUse == true)
              ? setPastoralMinistry(context: context, isAdmin: true, isInUse: true)
              : setPastoralMinistry(context: context, isAdmin: true, isInUse: false);
          break;
        case "Prayer":
          print("is Prayer");
          (i.inUse == true)
              ? setPrayerMinistry(context: context, isAdmin: true, isInUse: true)
              : setPrayerMinistry(context: context, isAdmin: true, isInUse: false);
          break;
        case "Social":
          print("is Social");
          (i.inUse == true)
              ? setSocialMinistry(context: context, isAdmin: true, isInUse: true)
              : setSocialMinistry(context: context, isAdmin: true, isInUse: false);
          break;
        case "Tithes And Offering":
          print("is Social");
          (i.inUse == true)
              ? setTithesAndOfferingMinistry(context: context, isAdmin: true, isInUse: true)
              : setTithesAndOfferingMinistry(context: context, isAdmin: true, isInUse: false);
          break;
      }
      print("Checks: ${i.inUse}");
    }
  }



  //Check Ministries

  checkMinistry(BuildContext context, MinistryModel ministryModel, bool isAdmin, bool isInUse,){
    if (isInUse == true){
      //creating on DB
      addMinistry(context, ministryModel, isAdmin);
    }else{
      //delete from DB
      removeMinistry(context, ministryModel, isAdmin);
    }
  }



  setEventMinistry({BuildContext context, bool isAdmin, bool isInUse}){

    MinistryModel thisMinistry = MinistryModel(
        "Assets/EventsIcon.png",
        "Events",
        "A place to find current events",
        "events_page"
    );

    //Check the ministries if this can be used from the App Developer
    checkMinistry(context, thisMinistry, isAdmin, isInUse);
  }

  setMediaMinistry({BuildContext context, bool isAdmin, bool isInUse}){

    MinistryModel thisMinistry = MinistryModel(
        "Assets/MediaIcon.png",
        "Media",
        "Sermons, Media, Podcasts and Other",
        "media_page"
    );

    //Check the ministries if this can be used from the App Developer
    checkMinistry(context, thisMinistry, isAdmin, isInUse);
  }

  setSocialMinistry({BuildContext context, bool isAdmin, bool isInUse}){

    MinistryModel thisMinistry = MinistryModel(
        "Assets/SocialIcon.png",
        "Social",
        "Share life's moments",
        "social_page"
    );

    //Check the ministries if this can be used from the App Developer
    checkMinistry(context, thisMinistry, isAdmin, isInUse);
  }

  setBibleMinistry({BuildContext context, bool isAdmin, bool isInUse}){

    MinistryModel thisMinistry = MinistryModel(
        "Assets/BibleIcon.png",
        "Bible",
        "Find, Read, Know Your Pages.Bible",
        "bible_page"
    );

    //Check the ministries if this can be used from the App Developer
    checkMinistry(context, thisMinistry, isAdmin, isInUse);
  }

  setPrayerMinistry({BuildContext context, bool isAdmin, bool isInUse}){

    MinistryModel thisMinistry = MinistryModel(
        "Assets/PrayerIcon.png",
        "Prayer",
        "Prayer Requests and Prayer Wall",
        "prayer_page"
    );

    //Check the ministries if this can be used from the App Developer
    checkMinistry(context, thisMinistry, isAdmin, isInUse);
  }

  setPastoralMinistry({BuildContext context, bool isAdmin, bool isInUse}){

    MinistryModel thisMinistry = MinistryModel(
        "Assets/PastoralIcon.png",
        "Pastoral",
        "Pastoral Provided Blog Messages",
        "pastoral_page"
    );

    //Check the ministries if this can be used from the App Developer
    checkMinistry(context, thisMinistry, isAdmin, isInUse);
  }


  setChatMinistry({BuildContext context, bool isAdmin, bool isInUse}){

    MinistryModel thisMinistry = MinistryModel(
        "Assets/ChatIcon.png",
        "Chat",
        "Get Connected",
        "chat_page"
    );

    //Check the ministries if this can be used from the App Developer
    checkMinistry(context, thisMinistry, isAdmin, isInUse);
  }

  setTithesAndOfferingMinistry({BuildContext context, bool isAdmin, bool isInUse}){

    MinistryModel thisMinistry = MinistryModel(
        "Assets/ChatIcon.png",
        "Tithes And Offering",
        "Giving Back",
        "tithe_and_offering_page"
    );

    //Check the ministries if this can be used from the App Developer
    checkMinistry(context, thisMinistry, isAdmin, isInUse);
  }



  //Adding Ministry
  addMinistry(BuildContext context, MinistryModel ministryModel, bool isAdmin){
    print("Now adding");
    churchDB.launchMinistryPath(
        context: context,
        ministryModel: ministryModel,
        isAdmin: isAdmin,
        actionToDo: "create"
    );
  }

  //Removing Ministry
  removeMinistry(BuildContext context, MinistryModel ministryModel, bool isAdmin){
    churchDB.launchMinistryPath(
        context: context,
        ministryModel: ministryModel,
        isAdmin: isAdmin,
        actionToDo: "delete"
    );
  }

  removeAllMinistries(BuildContext context, bool isAdmin){
    churchDB.launchMinistryPath(
        context: context,
        ministryModel: null,
        isAdmin: isAdmin,
        actionToDo: "deleteAll"
    );
  }



//------------- Futures --------------

// --------------- Raw Data --------------

  var demoMinistries = [
    MinistryModel(
        "Assets/EventsIcon",
        "Events",
        "A place to find current events",
        "events_page"
    ),
    MinistryModel(
        "Assets/MediaIcon.png",
        "Media",
        "Sermons, Media, Podcasts and Other",
        "media_page"
    ),
    MinistryModel(
        "Assets/SocialIcon.png",
        "Social",
        "Share life's moments",
        "social_page"
    ),
    MinistryModel(
        "Assets/BibleIcon.png",
        "Pages.Bible",
        "Find, Read, Know Your Pages.Bible",
        "bible_page"
    ),
    MinistryModel(
        "Assets/PrayerIcon.png",
        "Prayer",
        "Prayer Requests and Prayer Wall",
        "prayer_page"
    ),
    MinistryModel(
        "Assets/PastoralIcon.png",
        "Pastoral",
        "Pastoral Provided Blog Messages",
        "pastoral_page"
    ),
    MinistryModel(
        "Assets/ChatIcon.png",
        "Chat",
        "Get Connected",
        "chat_page"
    ),
    MinistryModel(
        "Assets/ChatIcon.png",
        "Tithes And Offering",
        "Giving Back",
        "tithe_and_offering_page"
    ),
  ];

//---------- The Constructor ------------
  MinistriesBLOC(){
    churchDB = ChurchDB();
  }
}