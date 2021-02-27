//System
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

//Firebase
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Other
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_church_app_2020/Pages/Root/RootPage.dart';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/Services/payment-service.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignupBLOC {
  ChurchDB churchDB;
  AuthCentral _auth = AuthCentral();
  UserCredential firebaseUser;
  StripePaymentService stripeService = StripePaymentService();

//---------- BLOC Logic ------------
  // Working With Image
  File _image;

  checkImage(File image, ChurchUserModel thisImageUser) {
    if (thisImageUser.userImageUrl != "" &&
        thisImageUser.userImageUrl != null) {
      return Image.file(
        image,
        height: 175,
        width: 175,
        fit: BoxFit.cover,
      );
    } else {
      print("No image bub!");
      return Image.asset(
        "Assets/${"blankUserImage.png"}",
        height: 175,
        width: 175,
        fit: BoxFit.cover,
      );
    }
  }

  //switch this to edit profileBLOC
  checkNewImage(File image, ChurchUserModel thisImageUser) {
    if (image != null) {
      return Image.file(
        image,
        height: 175,
        width: 175,
        fit: BoxFit.cover,
      );
    } else {
      print("No new image!");
      return Image.network(
        thisImageUser.userImageUrl,
        height: 175,
        width: 175,
        fit: BoxFit.cover,
      );
    }
  }

  //------------- Futures --------------

  takePicture() async {
    var image = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    return image;
  }

  getPictureFromGallery() async {
    var image = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    return image;
  }

  Future<bool> submitToFB(
      {BuildContext context,
      VoidCallback onSignedUp,
      ChurchUserModel thisUser,
      bool imageHasChanged}) async {
    bool isSignedIn = false;
    try {
      ChurchUserModel thisUploadingUser = thisUser;

      await createUserWithFB(
          context, onSignedUp, thisUploadingUser, imageHasChanged);

      isSignedIn = true;
    } catch (error) {
      _showThisDialog(context, error);
    }
    return isSignedIn;
  }

  createUserWithFB(BuildContext context, VoidCallback onSignedUp,
      ChurchUserModel thisUploadingUser, var imageHasChanged) async {
   
    firebaseUser = await _auth.createUserWithEmailAndPassword(
        thisUploadingUser.userEmail, thisUploadingUser.password);
    thisUploadingUser.userUID = firebaseUser.user.uid;


    StripePaymentService.createNewCustomer(thisUser: thisUploadingUser)
        .then((newPaymentId) {
      thisUploadingUser.paymentId = newPaymentId;
      if (thisUploadingUser != null) {
        churchDB.launchUsersPath(
            context: context,
            userModel: thisUploadingUser,
            imageHasChanged: imageHasChanged,
            actionToDo: "create");
      }
      
    });
  }

  //------------- Dialogues --------------

  //voids - rewrite with custom alert
  _showThisDialog(BuildContext context, errorItem) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Signup Error",
              textAlign: TextAlign.center,
            ),
            content: _checkSignAlertMessage(errorItem.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //------------- error handling --------------

  _checkSignAlertMessage(messaage) {
    if (messaage.contains("password must be 6 characters")) {
      return Text(
        "Password is too short: password must be atleast 6 characters long",
        textAlign: TextAlign.center,
      );
    } else if (messaage.contains("ERROR_EMAIL_ALREADY_IN_USE")) {
      return Text(
        "Please choose another email, this address is currently in use.",
        textAlign: TextAlign.center,
      );
    } else {
      print(messaage);
      return Text("Sorry unknown error: $messaage");
    }
  }
  //--------------

//---------- The Constructor ------------
  SignupBLOC() {
    churchDB = ChurchDB();
  }
}
