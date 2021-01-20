import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';


class MenuPageBLOC{

  FirebaseAuth auth = AuthCentral.auth;
  RestaurantDB restaurantDB;

//---------- BLOC Logic ------------


//----------------- Futures ---------------


  MenuPageBLOC(){
    restaurantDB = RestaurantDB();
  }
}