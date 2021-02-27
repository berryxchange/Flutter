import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:flutter_church_app_2020/Models/PaymentOrderModel.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Models/MinistryModel.dart';
import 'package:flutter_church_app_2020/Pages/MainSelectionsPage/MainSelectionsPage.dart';
import 'package:flutter_church_app_2020/Models/SystemCheckModel.dart';
import 'package:flutter_church_app_2020/Models/UserAddressModel.dart';
import 'package:secure_random/secure_random.dart';
import 'package:flutter_church_app_2020/Models/CreditCardModel.dart';
import 'dart:io';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/Services/payment-service.dart';

class ChurchDB {
  //instance
  static final ChurchDB _instance = ChurchDB._internal();
  final FirebaseDatabase database =
      FirebaseDatabase.instance; //FirebaseDatabase.instance
  final _auth = AuthCentral.auth;
  List<ChurchUserModel> users = [];

  //models
  ChurchUserModel thisUser = ChurchUserModel();
  ChurchUserModel returningUser = ChurchUserModel();
  User firebaseUser;

  //references
  //Users
  DatabaseReference usersRef =
      FirebaseDatabase.instance.reference().child("Users");
  DatabaseReference basicUserInfoRef =
      FirebaseDatabase.instance.reference().child("BasicUserInfo");
  StorageReference userStorageRef =
      FirebaseStorage.instance.ref().child('Users');
  DatabaseReference ministryRef =
      FirebaseDatabase.instance.reference().child('SystemChecks');
  //DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("Users");
  //StorageReference userStorageRef = FirebaseStorage.instance.ref().child('Users');
  //Ministries
  //DatabaseReference ministryRef = FirebaseDatabase.instance.reference().child('SystemChecks');

  //functions
  //------------------ actions by App sections --------------------

  //----------- Users -----------
   launchUsersPath(
      {BuildContext context,
      ChurchUserModel userModel,
      var imageHasChanged,
      String actionToDo,
      String userUIDToCheck}) async {
    
    DatabaseReference thisUserPath;
    DatabaseReference thisUserBasicPath;

    if (userModel != null) {
      print("Not empty");
      thisUserPath =
          database.reference().child('Users').child("${userModel.userUID}");
        thisUserBasicPath = basicUserInfoRef.child("${userModel.userUID}");
    }else {
      print("this is an empty user..");
    }

    ChurchUserModel thisReturningUser;

    //do the action
    switch (actionToDo) {
      case ("create"):
        createUserObject(context, thisUserPath, thisUserBasicPath, userModel, imageHasChanged);
        break;
      case ("read"):
        await readUserObject(userUIDToCheck).then((value) {
          print("Returning User: ${returningUser.userName}");
          thisReturningUser = returningUser;
        });
        break;
      case ("update"):
        updateUserObject(context, thisUserPath, thisUserBasicPath, userModel, imageHasChanged);
        break;
      case ("delete"):
        deleteUserObject(thisUserPath, thisUserBasicPath, userModel);
        break;
    }
    return thisReturningUser;
  }

  //Create
  createUserObject(BuildContext context, DatabaseReference databasePath, DatabaseReference basicDatabasePath,
      ChurchUserModel userModel, bool imageHasChanged) async {
    //Create the image address from Storage, then add the item to the database

    var thisNewUser = userModel;

    thisNewUser.isAdmin = false;
    thisNewUser.chatNotification = false;
    thisNewUser.mainNotification = true;
    thisNewUser.mediaNotification = false;
    thisNewUser.prayerNotification = true;
    thisNewUser.socialNotification = false;
    thisNewUser.liveStreamNotification = false;
    thisNewUser.userRole = "basic";

    if (imageHasChanged == true) {
      launchUserImagePath(context, thisNewUser, basicDatabasePath ,"create");
    } else {
      //do something else
    }
  }

  //Read
  Future readUserObject(String userToCheck) async {
    //read the item from the database

    ChurchUserModel sendableNewUser = ChurchUserModel();
    usersRef.child(userToCheck).onChildAdded.listen(null).onData((data) {
      if (data.snapshot.key == "thisUserInfo") {
        ChurchUserModel tempUser = ChurchUserModel();
        checkAndSetUserData(event: data).then((value) {
          returningUser = value;
          print("Final Posting User data: ${returningUser.userName}");
        });
      }
    });
    return returningUser;
  }

  Future checkAndSetUserData({Event event}) async {
    ChurchUserModel thisUser = ChurchUserModel();

    var thisCurrentUser = ChurchUserModel.fromSnapshot(event.snapshot);

    print(thisCurrentUser.userLastName);
    if (thisCurrentUser.userName != null) {
      thisUser = thisCurrentUser;
      print("user is not null");
    } else {
      print("There is no data");
    }
    print("This user is: ${thisUser.userLastName}");
    return thisUser;
  }

  _onPrayerPostUserAdded(Event event) {
    /*
    if (ChurchUserModel.fromSnapshot(event.snapshot).userUID ==
        widget.prayer.byUserUID) {
      print("prayer user" +
          ChurchUserModel.fromSnapshot(event.snapshot).userUID.toString());
    }
    if (ChurchUserModel.fromSnapshot(event.snapshot).userUID ==
        widget.prayer.byUserUID) {
      prayerPostedUser = ChurchUserModel.fromSnapshot(event.snapshot);
      print("Added Post User token: " + prayerPostedUser.token);
    }

     */
  }

  //Update
  void updateUserObject(BuildContext context, DatabaseReference databasePath, DatabaseReference basicDatabasePath,
      ChurchUserModel userModel, bool imageHasChanged) {
    //update the item in the database
    var userInfoPath = databasePath.child("thisUserInfo");

    userInfoPath.update(userModel.toJson());
    basicDatabasePath.update(userModel.toJson());

    if (imageHasChanged == true) {
      print("launching image");
      launchUserImagePath(context, userModel, basicDatabasePath, "update");
    } else {
      //do something else
    }
  }

  //Delete
  void deleteUserObject(DatabaseReference databasePath, DatabaseReference basicDatabasePath, var object) {
    //delete the item from the database
  }
  //-----------

  //----------- Ministries -----------

  launchMinistryPath(
      {BuildContext context,
      MinistryModel ministryModel,
      bool isAdmin,
      String actionToDo}) async {
    final thisMinistryPath = ministryRef;

    bool _thisIsInUse;

    //do the action
    switch (actionToDo) {
      case ("create"):
        createMinistryObject(context, thisMinistryPath, ministryModel);
        break;
      case ("createChecks"):
        createMinistryChecksObject(context, thisMinistryPath, ministryModel);
        break;
      case ("read"):
        return readMinistryObject(thisMinistryPath, ministryModel, isAdmin);
        break;
      case ("update"):
        updateMinistryObject(thisMinistryPath, ministryModel);
        break;
      case ("delete"):
        deleteMinistryObject(thisMinistryPath, ministryModel);
        break;
      case ("deleteAll"):
        deleteAllMinistryObjects(thisMinistryPath);
        break;
    }
    return _thisIsInUse;
  }

  //Create
  createMinistryObject(BuildContext context, DatabaseReference databasePath,
      MinistryModel ministryModel) async {
    // for App Creator Only

    var allMinistriesToLoad = databasePath.child("AllMinistriesToLoad");
    var refKey = allMinistriesToLoad.child("${ministryModel.ministryName}");

    refKey.set(ministryModel.toJson());
  }

  createMinistryChecksObject(BuildContext context,
      DatabaseReference databasePath, MinistryModel ministryModel) async {
    // for App Creator Only
    var allMinistriesToCheckRefKey = databasePath.child("AllMinistriesToCheck");
    var ministryToCheck =
        allMinistriesToCheckRefKey.child("${ministryModel.ministryName}");
    ministryToCheck.set(ministryModel.checksToJson());
  }

  //Read
  readMinistryObject(DatabaseReference databasePath, var object, bool isAdmin) {
    //read the item from the database

    List<MinistryModel> ministries = List();

    _onMinistryEntryAdded(Event event) {
      print("the current user from ministry: ${thisUser.userUID}");

      if (isAdmin == true) {
        print("setting ministries for admin");
        ministries.add(MinistryModel.fromSnapshot(event.snapshot));
        print(ministries);
      } else if (isAdmin == false) {
        //not an admin
        print("setting ministries for non-admin");
        if (event.snapshot.key == "Administrator") {
          print("this is an administrator item and cannot be used here");
        } else {
          ministries.add(MinistryModel.fromSnapshot(event.snapshot));
          print(ministries);
        }
      }
    }

    _onMinistryEntryChanged(Event event) {
      var old = ministries.singleWhere((entry) {
        return entry.key == event.snapshot.key;
      });

      ministries[ministries.indexOf(old)] =
          MinistryModel.fromSnapshot(event.snapshot);
    }

    _onMinistryChildRemoved(Event event) {
      var old = ministries.singleWhere((entry) {
        return entry.key == event.snapshot.key;
      });
      //ministries[ministries.indexOf(old)] = Ministry.fromSnapshot(event.snapshot);
      ministries.removeAt(ministries.indexOf(old));
    }

    //Listeners
    ministryRef.onChildAdded.listen(_onMinistryEntryAdded);
    ministryRef.onChildChanged.listen(_onMinistryEntryChanged);
    ministryRef.onChildRemoved.listen(_onMinistryChildRemoved);

    return ministries;
  }

  //Update
  void updateMinistryObject(DatabaseReference databasePath, var object) {
    //update the item in the database
    var userInfoPath = databasePath.child("thisUserInfo");

    userInfoPath.update(thisUser.toJson());
  }

  //Delete
  void deleteMinistryObject(
      DatabaseReference databasePath, MinistryModel ministryModel) {
    //delete the item from the database
    var allMinistriesToLoad = databasePath.child("AllMinistriesToLoad");
    var refKey = allMinistriesToLoad.child("${ministryModel.ministryName}");
    refKey.remove();
  }

  void deleteAllMinistryObjects(DatabaseReference databasePath) {
    //delete the item from the database
    var allMinistriesToDelete = databasePath.child("AllMinistriesToLoad");
    allMinistriesToDelete.remove();
  }
  //-----------

  //For User Address
  void launchUserAddressesPath(
      ChurchUserModel thisUser, UserAddressModel address, String actionToDo) {
    final thisAddressPath = database
        .reference()
        .child('Users')
        .child("${thisUser.userUID}")
        .child("Addresses");

    //do the action
    switch (actionToDo) {
      case ("create"):
        createAddressObject(thisAddressPath, address);
        break;
      case ("read"):
        readAddressObject(thisAddressPath, address);
        break;
      case ("update"):
        updateAddressObject(thisAddressPath, address);
        break;
      case ("delete"):
        deleteAddressObject(thisAddressPath, address);
        break;
    }
  }

  //Create
  void createAddressObject(
      DatabaseReference databasePath, UserAddressModel thisAddress) {
    //add the item to the database
    print("Adding a address the list");
    var secureRandom = SecureRandom();
    var randomId = secureRandom.nextString(length: 6);

    databasePath.child(randomId).set(thisAddress.toJson());
    print("Congrats, ${thisAddress.address} has been added!");
  }

  //Read
  void readAddressObject(
      DatabaseReference databasePath, UserAddressModel thisAddress) {
    //read the item from the database
  }
  //Update
  void updateAddressObject(
      DatabaseReference databasePath, UserAddressModel thisAddress) {
    //update the item in the database
  }
  //Delete
  void deleteAddressObject(
      DatabaseReference databasePath, UserAddressModel thisAddress) {
    databasePath.child(thisAddress.key).remove();
    //delete the item from the database
  }

  //for adding payment cards

  void launchUserCardsPath(
      ChurchUserModel thisUser, CreditCardModel card, String actionToDo) {
    final thisCardPath = database
        .reference()
        .child('Users')
        .child("${thisUser.userUID}")
        .child("Cards");

    //do the action
    switch (actionToDo) {
      case ("create"):
        createCardObject(thisCardPath, card);
        break;
      case ("read"):
        readCardObject(thisCardPath, card);
        break;
      case ("update"):
        updateCardObject(thisCardPath, card);
        break;
      case ("delete"):
        deleteCardObject(thisCardPath, card);
        break;
    }
  }

  //Create
  void createCardObject(
      DatabaseReference databasePath, CreditCardModel thisCard) {
    //add the item to the database
    print("Adding a card the list");

    var secureRandom = SecureRandom();
    var randomId = secureRandom.nextString(length: 6);

    databasePath.child(randomId).set(thisCard.toJson());

    print("Congrats, ${thisCard.firstName}'s card has been added!");
  }

  //Read
  void readCardObject(
      DatabaseReference databasePath, CreditCardModel thisCard) {
    //read the item from the database
  }
  //Update
  void updateCardObject(
      DatabaseReference databasePath, CreditCardModel thisCard) {
    //update the item in the database
  }
  //Delete
  void deleteCardObject(
      DatabaseReference databasePath, CreditCardModel thisCard) {
    //delete the item from the database
  }

  //----------- Users -----------

  launchOrderPath(
      {BuildContext context,
      ChurchUserModel thisUser,
      PaymentOrderModel thisOrder,
      String paymentType,
      String actionToDo}) {
    final thisOrderPath = database
        .reference()
        .child('Users')
        .child("${thisUser.userUID}")
        .child("Orders")
        .child(paymentType)
        .child(thisOrder.orderName);

    //do the action
    switch (actionToDo) {
      case ("create"):
        createOrderObject(context, thisOrderPath, thisUser, thisOrder);
        break;
      case ("read"):
        readOrderObject(thisOrderPath, thisUser);
        break;
      case ("update"):
        updateOrderObject(context, thisOrderPath, thisUser);
        break;
      case ("delete"):
        deleteOrderObject(thisOrderPath, thisUser);
        break;
    }
  }

  //Create
  createOrderObject(BuildContext context, DatabaseReference databasePath,
      ChurchUserModel userModel, PaymentOrderModel thisOrder) async {
    //Create the image address from Storage, then add the item to the database
    var thisOrderPathRef = databasePath;
    thisOrderPathRef.update(thisOrder.toJson());
  }

  //Read
  void readOrderObject(DatabaseReference databasePath, var object) {
    //read the item from the database
  }

  //Update
  void updateOrderObject(BuildContext context, DatabaseReference databasePath,
      ChurchUserModel userModel) {
    //update the item in the database
    var userInfoPath = databasePath.child("thisUserInfo");

    userInfoPath.update(userModel.toJson());
  }

  //Delete
  void deleteOrderObject(DatabaseReference databasePath, var object) {
    //delete the item from the database
  }
  //-----------
  //------------- End --------------

  //------------Storage Database --------------

  launchUserImagePath(
      BuildContext context, ChurchUserModel userModel, DatabaseReference basicDatabasePath, String actionToDo) {
    StorageReference thisUserImagePath =
        userStorageRef.child("${userModel.userUID}");
    final thisUserPath =
        database.reference().child('Users').child("${userModel.userUID}");

    //do the action
    switch (actionToDo) {
      case ("create"):
        createUserImageObject(
            context, thisUserPath, basicDatabasePath, thisUserImagePath, userModel);
        break;
      case ("read"):
        readUserImageObject(thisUserImagePath, userModel);
        break;
      case ("update"):
        updateUserImageObject(
            context, thisUserImagePath, thisUserPath, basicDatabasePath, userModel);
        break;
      case ("delete"):
        deleteUserImageObject(thisUserImagePath, userModel);
        break;
    }
  }

  //Create
  createUserImageObject(BuildContext context, DatabaseReference databasePath, DatabaseReference basicDatabasePath,
      StorageReference storagePath, ChurchUserModel userModel) async {
    var userImageInfoPath = storagePath.child("ProfileImage");
    var userInfoPath = databasePath.child("thisUserInfo");

    handleStorageTask(context, userInfoPath, basicDatabasePath, userImageInfoPath, userModel);
  }

  handleStorageTask(BuildContext context, DatabaseReference userInfoPath, DatabaseReference basicDatabasePath,
      StorageReference userImageInfoPath, ChurchUserModel userModel) async {
    StorageUploadTask uploadTask =
        userImageInfoPath.putFile(File(userModel.userImageUrl));

    await uploadTask.onComplete;

    print('File Uploaded');
    handleUserDataStorage(context, userInfoPath, basicDatabasePath, userImageInfoPath, userModel);
  }

  handleUserDataStorage(BuildContext context, DatabaseReference userInfoPath, DatabaseReference basicDatabasePath,
      StorageReference userImageInfoPath, ChurchUserModel userModel) {
    userImageInfoPath.getDownloadURL().then((fileURL) {
      ChurchUserModel thisUploadingUser = userModel;
      thisUploadingUser.userImageUrl = fileURL;

      checkUserImageDataAndUpload(context, thisUploadingUser, userInfoPath, basicDatabasePath);
    });
  }

  checkUserImageDataAndUpload(BuildContext context,
      ChurchUserModel thisUploadingUser, DatabaseReference userInfoPath, DatabaseReference basicDatabasePath) {
    //if (thisUploadingUser.userImageUrl == "" || thisUploadingUser.userImageUrl == null) {

    //thisUploadingUser.userImageUrl = "blankUserImage.png";
    //uploadDataToDB(context, onSignedUp, thisUploadingUser, userInfoPath);

    //} else {
    uploadDataToDB(context, thisUploadingUser, userInfoPath, basicDatabasePath);
    //}
  }

  uploadDataToDB(BuildContext context, ChurchUserModel thisUploadingUser,
      DatabaseReference userInfoPath, DatabaseReference basicDatabasePath) {
    
    //var thisBasicUser = basicUserInfoRef.child(thisUploadingUser.userUID);
    basicUserInfoRef.update(thisUploadingUser.toJson());
    userInfoPath.update(thisUploadingUser.toJson());
  }

  //Read
  void readUserImageObject(StorageReference storagePath, var object) {
    //read the item from the database
  }

  //Update
  void updateUserImageObject(BuildContext context, StorageReference storagePath,
      DatabaseReference databasePath, DatabaseReference basicDatabasePath, ChurchUserModel userModel) {
    //update the item in the database
    var userImageInfoPath = storagePath.child("thisUserInfo");
    var userInfoPath = databasePath.child("thisUserInfo");

    handleStorageTask(context, userInfoPath, basicUserInfoRef, userImageInfoPath, userModel);

    //userInfoPath.update(thisUser.toJson());
  }

  //Delete
  void deleteUserImageObject(StorageReference storagePath, var object) {
    //delete the item from the database
  }

  //---------------------------

//factory
  factory ChurchDB() {
    return _instance;
  }

  ChurchDB._internal();
}
