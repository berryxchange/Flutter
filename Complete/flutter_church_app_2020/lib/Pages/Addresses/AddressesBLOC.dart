import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';

class AddressesBLOC{
  AuthCentral auth;
  ChurchDB churchDB;

//---------- BLOC Logic ------------

//----------------- Futures ---------------


  AddressesBLOC(){
    auth = AuthCentral();
    churchDB = ChurchDB();
  }
}