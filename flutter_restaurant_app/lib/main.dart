import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant_app/Pages/DeliveryAddress/DeliveryAddressPage.dart';
import 'package:flutter_restaurant_app/Pages/MainContainer/MainContainerPage.dart';
import 'package:flutter_restaurant_app/Pages/Home/HomePage.dart';
import 'package:flutter_restaurant_app/Pages/Login/LoginPage.dart';
import 'package:flutter_restaurant_app/Pages/OrderHistory/OrderHistoryPage/OrderHistoryPage.dart';
import 'package:flutter_restaurant_app/Pages/Profile/ProfilePage.dart';
import 'package:flutter_restaurant_app/Pages/Signup/SignupPage.dart';
import 'package:flutter_restaurant_app/Pages/Cart/CartPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_restaurant_app/Pages/Splash/SplashPage.dart';
import 'package:flutter_restaurant_app/Pages/Login/LoginPage.dart';
import 'package:flutter_restaurant_app/Pages/Root/RootPage.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  // this widget is the root of your application
  @override
  Widget build(BuildContext context){

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(

      initialRoute: SplashPage.id,// states the first page to show when the app comes alive
      debugShowCheckedModeBanner: false,

      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context){
          return SplashPage();
        },

        //login page
        LoginPage.id: (context) {
          return LoginPage(auth: AuthCentral());
        },

        //splash page
        SplashPage.id: (context) {
          return SplashPage();
        },

        //RootPage
        RootPage.id: (context) {
          return RootPage(auth: AuthCentral());
        },

        SignupPage.id: (context){
          return SignupPage(auth: AuthCentral());
        },

        // When navigating to the "/second" route, build the SecondScreen widget.

        MainContainerPage.id: (context) {
          return MainContainerPage();
        },

        CartPage.id: (context) {
          return CartPage();
        },


        HomePage.id: (context) {
          return HomePage();
        },

        LoginPage.id: (context) {
          return LoginPage();
        },

        ProfilePage.id: (context){
          return ProfilePage();
        },

        DeliveryAddressPage.id: (context){
          return DeliveryAddressPage();
        },

        OrderHistoryPage.id: (context){
          return OrderHistoryPage();
        },

      },

      title: "Restaurant App",


      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Color(0xFFFEF9EB),
          splashColor: Colors.red
      ),
    );
  }
}