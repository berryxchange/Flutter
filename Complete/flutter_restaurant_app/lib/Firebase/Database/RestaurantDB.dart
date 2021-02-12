import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/DeliveryAddressModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:secure_random/secure_random.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';

class RestaurantDB{

  //instance
  static final RestaurantDB _instance = RestaurantDB._internal();
  final FirebaseDatabase database = FirebaseDatabase.instance;

  //models


  //references
  DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
  StorageReference userStorageRef = FirebaseStorage.instance.ref().child('users');
  DatabaseReference mealRef = FirebaseDatabase.instance.reference().child('SystemChecks');


  //-------------- for the users --------------

  //----------- Users -----------
  launchUsersPath({BuildContext context, UserModel userModel, var imageHasChanged, String actionToDo}) {

    final thisUserPath = database.reference().child('users').child("${userModel.uid}");

    //do the action
    switch (actionToDo) {
      case ("create"):
        createUserObject(context, thisUserPath, userModel, imageHasChanged);
        break;
      case ("read"):
        readUserObject(thisUserPath, userModel);
        break;
      case ("update"):
        updateUserObject(context, thisUserPath, userModel, imageHasChanged);
        break;
      case ("delete"):
        deleteUserObject(thisUserPath, userModel);
        break;
    }
  }

  //Create
  createUserObject(BuildContext context, DatabaseReference databasePath, UserModel userModel, bool imageHasChanged) async {
    //Create the image address from Storage, then add the item to the database

    var thisNewUser = userModel;
    //thisNewUser.mainNotification = false;


    if(imageHasChanged == true){
      launchUserImagePath(context, thisNewUser, "create");
    }else{
      //do something else
    }
  }

  //Read
  void readUserObject(DatabaseReference databasePath, var object) {
    //read the item from the database
  }

  //Update
  void updateUserObject(BuildContext context, DatabaseReference databasePath, UserModel userModel, bool imageHasChanged) {
    //update the item in the database
    var userInfoPath = databasePath.child("thisUserInfo");

    userInfoPath.update(userModel.toJson());

    if(imageHasChanged == true){
      print("launching image");
      launchUserImagePath(context, userModel, "update");
    }else{
      //do something else
    }

  }

  //Delete
  void deleteUserObject(DatabaseReference databasePath, var object) {
    //delete the item from the database
  }
  //-----------


//For User Address
  void launchUserAddressesPath(UserModel thisUser, DeliveryAddressModel address, String actionToDo) {
    final thisAddressPath = database
        .reference()
        .child('users')
        .child("${thisUser.uid}")
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
      DatabaseReference databasePath, DeliveryAddressModel thisAddress) {
    //add the item to the database
    print("Adding a address the list");
    var secureRandom = SecureRandom();
    var randomId = secureRandom.nextString(length: 6);

    databasePath.child(randomId).set(thisAddress.toJson());
    print("Congrats, ${thisAddress.address} has been added!");
  }

  //Read
  void readAddressObject(
      DatabaseReference databasePath, DeliveryAddressModel thisAddress) {
    //read the item from the database
  }
  //Update
  void updateAddressObject(
      DatabaseReference databasePath, DeliveryAddressModel thisAddress) {
    //update the item in the database
  }
  //Delete
  void deleteAddressObject(
      DatabaseReference databasePath, DeliveryAddressModel thisAddress) {
    databasePath.child(thisAddress.key).remove();
    //delete the item from the database
  }

  //for adding payment cards

  void launchUserCardsPath(UserModel thisUser, CreditCardModel card, String actionToDo) {
    final thisCardPath = database
        .reference()
        .child('users')
        .child("${thisUser.uid}")
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
  void createCardObject(DatabaseReference databasePath, CreditCardModel thisCard) {
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


//------------Storage Database --------------

  launchUserImagePath(BuildContext context, UserModel userModel, String actionToDo) {
    StorageReference thisUserImagePath = userStorageRef.child("${userModel.uid}");
    final thisUserPath = database.reference().child('users').child("${userModel.uid}");

    //do the action
    switch (actionToDo) {
      case ("create"):
        createUserImageObject(
            context, thisUserPath, thisUserImagePath, userModel);
        break;
      case ("read"):
        readUserImageObject(thisUserImagePath, userModel);
        break;
      case ("update"):
        updateUserImageObject(context, thisUserImagePath, thisUserPath, userModel);
        break;
      case ("delete"):
        deleteUserImageObject(thisUserImagePath, userModel);
        break;
    }
  }

  //Create
  createUserImageObject(BuildContext context, DatabaseReference databasePath, StorageReference storagePath,
      UserModel userModel) async {

    var userImageInfoPath = storagePath.child("ProfileImage");
    var userInfoPath = databasePath.child("thisUserInfo");

    handleStorageTask(context, userInfoPath, userImageInfoPath, userModel);
  }


  handleStorageTask(BuildContext context, DatabaseReference userInfoPath, StorageReference userImageInfoPath, UserModel userModel) async{

    StorageUploadTask uploadTask = userImageInfoPath.putFile(
        File(userModel.imageUrl)
    );

    await uploadTask.onComplete;
    print('File Uploaded');

    handleUserDataStorage(context, userInfoPath ,userImageInfoPath, userModel);

  }

  handleUserDataStorage(BuildContext context, DatabaseReference userInfoPath, StorageReference userImageInfoPath, UserModel userModel){

    userImageInfoPath.getDownloadURL().then((fileURL) {
      UserModel thisUploadingUser = userModel;
      thisUploadingUser.imageUrl = fileURL;

      checkUserImageDataAndUpload(context, thisUploadingUser, userInfoPath);

    });
  }

  checkUserImageDataAndUpload(BuildContext context, UserModel thisUploadingUser, DatabaseReference userInfoPath){

    //if (thisUploadingUser.userImageUrl == "" || thisUploadingUser.userImageUrl == null) {

    //thisUploadingUser.userImageUrl = "blankUserImage.png";
    //uploadDataToDB(context, onSignedUp, thisUploadingUser, userInfoPath);

    //} else {
    uploadDataToDB(context, thisUploadingUser, userInfoPath);
    //}
  }

  uploadDataToDB(BuildContext context, UserModel thisUploadingUser, DatabaseReference userInfoPath){
    userInfoPath.update(thisUploadingUser.toJson());
  }



  //Read
  void readUserImageObject(
      StorageReference storagePath, var object) {
    //read the item from the database
  }

  //Update
  void updateUserImageObject(BuildContext context, StorageReference storagePath,  DatabaseReference databasePath, UserModel userModel) {
    //update the item in the database
    var userImageInfoPath = storagePath.child("thisUserInfo");
    var userInfoPath = databasePath.child("thisUserInfo");

    handleStorageTask(context, userInfoPath, userImageInfoPath, userModel);


    //userInfoPath.update(thisUser.toJson());
  }

  //Delete
  void deleteUserImageObject(
      StorageReference storagePath, var object) {
    //delete the item from the database
  }




  //---------------------------


  //-------------- for the meals -------------------

  //-------------- for the orders --------------


//factory
  factory RestaurantDB() {
    return _instance;
  }

  RestaurantDB._internal();


}
