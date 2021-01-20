import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Pages/MainContainer/MainContainerPage.dart';
import 'package:flutter_restaurant_app/Pages/Root/RootPage.dart';
import 'package:flutter_restaurant_app/Pages/Login/LoginPage.dart';
import 'package:flutter_restaurant_app/Pages/Signup/SignupPage.dart';

class LoginBLOC {
  AuthCentral auth = AuthCentral();
  var rootPage = RootPage();

//---------- BLOC Logic ------------

  //----------------- Futures ---------------
 Future<bool> submitUserToFB({
   BuildContext context,
   FormState form,
   String email,
   String password}) async {

   bool isSignedIn = false;
   print("username: $email");
   print("Password: $password");

      //loginWithAuthentication
      isSignedIn = await loginWithAuthentication(context, email, password);
    return isSignedIn;
  }
  //------------------


  //----------------- Functions ---------------
  loginWithAuthentication(BuildContext context, String email, String password) async{
    User firebaseUser;
    bool isSignedIn = false;
    var _authCentral = AuthCentral();

    try {
      firebaseUser = await _authCentral.signInWitEmailAndPassword(email, password);
      isSignedIn = await checkIfUserIsSignedIn(context, firebaseUser);

    } catch (error) {
      print("Error!!!!!: $error");
      print("Password: $password");
      _showThisDialog(context: context, errorItem: error);
    }
    return isSignedIn;
  }


  checkIfUserIsSignedIn(BuildContext context, User firebaseUser){
   bool isSignedIn = false;

   if (firebaseUser != null) {
      print("Successfully Logged in. User UID: ${firebaseUser.uid}");

      //tell the main observer we are signed in and to switch to the mainSelections page
      print("Finished, now pop..");
      isSignedIn = true;
    }

    return isSignedIn;
  }


  //----------------- SignupPage ---------------
  Future signup(BuildContext context, AuthCentral auth) async {
    bool isSignedIn;
    isSignedIn = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
          return SignupPage(auth: auth);
          },
    ));

    return isSignedIn;
  }

  //----------------- Alerts ---------------
  _showThisDialog({BuildContext context, errorItem}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Signin Error",
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
  //------


  //----------------- Error Handling ---------------
  _checkSignAlertMessage(message) {
    if (message.contains("The user may have been deleted")) {
      return Text(
        "There is no such user",
        textAlign: TextAlign.center,
      );
    } else if (message.contains("ERROR_INVALID_EMAIL")) {
      return Text(
        "Invalid email address",
        textAlign: TextAlign.center,
      );
    } else if (message.contains("ERROR_WRONG_PASSWORD") ||
        message.contains(
            "The password is invalid or the user does not have a password")) {
      return Text(
        "Invalid password",
        textAlign: TextAlign.center,
      );
    } else {
      return Text("Sorry unknown error: $message");
    }
  }
  //--------------


//---------- The Constructor ------------
  LoginBLOC() {}
}
