import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Pages/Login/LoginPage.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Pages/MainContainer/MainContainerPage.dart';
//import 'package:flutter_restaurant_app/Pages/Onboarding/OnboardingPage.dart';
import 'package:flutter_restaurant_app/Pages/Signup/SignupPage.dart';

//The page that Checks server data when a user quits the app or goes on standby

enum AuthStatus {
  //Various states the app currently is in
  notSignedIn,
  signedIn,
  signingUp,
  signedInWithWalkthrough
}

class RootPage extends StatefulWidget {
  RootPage({this.auth}); //requires authentication

  //Items to use within the RootPage
  final AuthProtocol auth;
  static String id = "root_page"; //allows main page to locate

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn; //Default setting

  @override
  void initState() {
    //once app wakes, will start with this
    // TODO: implement initState
    super.initState();

    // questions the state of the current user
    // whether there they are signed in or not
    // and sets the current state based on the Id verification
    widget.auth.getCurrentUser().then((userId) {
      setState(() {
        _authStatus =
        userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void signedIn() {
    setState(() {
      print("signing in");
      _authStatus = AuthStatus.signedIn;
    });
  }

  void signingUp() {
    setState(() {
      print("signing Up");
      _authStatus = AuthStatus.signingUp;
    });
  }

  void signedUp() {
    setState(() {
      print("signed Up");
      _authStatus = AuthStatus.signedInWithWalkthrough;
    });
  }

  void signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    //based on the authentication status,
    // and after the initialization has taken place
    // the action will be taken based on that.
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
      //taken to login page
        return LoginPage(
          //issues the pages with required parameters
          auth: widget.auth,
          onSignedIn: signedIn,
        );

      case AuthStatus.signingUp:
      //taken to Registration page
        return SignupPage(
          auth: widget.auth,
        );

      case AuthStatus.signedIn:
      //taken to Main Selections page
        return MainContainerPage(
          auth: widget.auth,
          onSignOut: signedOut,
        );

      /*case AuthStatus.signedInWithWalkthrough:
      //taken to Onboarding page
        return OnboardingPage(
          //issues the pages with required parameters
          kindOfOnboardingString: "intro_page",
          auth: widget.auth,
          onSignedIn: signedIn,
        );

       */
    }
  }
}

