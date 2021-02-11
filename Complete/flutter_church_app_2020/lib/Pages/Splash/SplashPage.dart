import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:flutter/services.dart';
import 'package:flutter_church_app_2020/Pages/Root/RootPage.dart';

class SplashPage extends StatefulWidget {
  static String id = "splash_Page";

  @override
  SplashPageState createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
// THIS FUNCTION WILL NAVIGATE FROM SPLASH SCREEN
// TO HOME SCREEN, USING NAVIGATOR CLASS.

  void navigationToNextPage() {
    Navigator.pushReplacementNamed(context, RootPage.id);
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    // full screen image for splash screen.
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "Assets/backgroundImage.png",
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.6),
            ),
            Container(
              child: Center(
                child: Container(
                  height: 175,
                  width: 175,
                  child: Image.asset(
                    "Assets/TCILogo.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
