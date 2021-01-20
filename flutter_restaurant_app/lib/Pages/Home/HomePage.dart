import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class HomePage extends StatefulWidget {
  HomePage({
    Key key,
    this.title,
    this.firebaseUser,
    //this.thisUser
  }) : super(key: key);

  final String title;
  static String id = "/home";
  final User firebaseUser;
  //final UserModel thisUser;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

