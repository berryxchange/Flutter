import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';

class AddressesBLOC{
  AuthCentral auth = AuthCentral();
  RestaurantDB restaurantDB;

//---------- BLOC Logic ------------

//----------------- Futures ---------------


  AddressesBLOC(){
    restaurantDB = RestaurantDB();
  }
}