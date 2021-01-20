import 'package:flutter/material.dart';

abstract class UserProtocol {
  String userFirstName;
  String userLastName;
  var userImage;
}

class UserModel extends UserProtocol {
  var userFirstName = "Quinton";
  var userLastName = "Quaye";
  var userImage = "";

  UserModel({this.userFirstName, this.userLastName, this.userImage});
}

UserModel userOne =
    UserModel(userFirstName: "Quinton", userLastName: "Quaye", userImage: "");
