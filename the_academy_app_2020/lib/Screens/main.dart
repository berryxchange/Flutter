import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_academy_app_2020/Screens/CoursePage.dart';
import 'package:the_academy_app_2020/Screens/ExplorePageDetail.dart';
import 'package:the_academy_app_2020/Screens/Stripe/ExistingCards.dart';
import 'package:the_academy_app_2020/Screens/MainContainerPage.dart';
import 'package:the_academy_app_2020/Screens/HomePage.dart';
import 'package:the_academy_app_2020/Screens/ExplorePage.dart';
import 'package:the_academy_app_2020/Screens/CoursesPage.dart';
import 'package:the_academy_app_2020/Screens/Stripe/PaymentPage.dart';
import 'package:the_academy_app_2020/Screens/ProfilePage.dart';
import 'package:the_academy_app_2020/Screens/CoursesPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  // this widget is the root of your application
  @override
  Widget build(BuildContext context){

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(

      initialRoute: '/',// states the first page to show when the app comes alive

      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context){
          return MainContainerPage();
        },
        // When navigating to the "/second" route, build the SecondScreen widget.

        HomePage.id: (context) {
          return HomePage();
        },

        ExplorePage.id: (context) {
          return ExplorePage();
        },

        ExplorePageDetailPage.id: (context) {
          return ExplorePageDetailPage();
        },

        MyCoursesPage.id: (context) {
          return MyCoursesPage();
        },

        ProfilePage.id: (context) {
          return ProfilePage();
        },

        PaymentsPage.id: (context){
          return PaymentsPage();
        },

        ExistingCardsPage.id: (context){
          return ExistingCardsPage();
        },

        CoursePage.id: (context) {
          return CoursePage();
        }
      },

      title: "The Academy",

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Color(0xFFFEF9EB),
          splashColor: Colors.red
      ),
    );
  }
}