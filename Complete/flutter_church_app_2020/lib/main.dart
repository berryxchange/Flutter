import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:flutter_church_app_2020/Pages/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Pages/Payments/TitheAndOffering/TitheAndOffering.dart';
import 'package:flutter_church_app_2020/Pages/PrayerPage/PrayerPage.dart';
import 'package:flutter_church_app_2020/Pages/PrayerPage/AddPrayerPage.dart';
import 'package:flutter_church_app_2020/Pages/PrayerPage/PrayerDetailPage.dart';
import 'package:flutter_church_app_2020/Pages/SignupPage/SignupPage.dart';
//import 'package:flutter_church_app_2020/Pages/event_page';
//import 'package:flutter_church_app_2020/Pages/social_page.dart';
import 'package:flutter_church_app_2020/Pages/Bible/bible_page.dart';
//import 'package:flutter_church_app_2020/Pages/pastoral_list_page.dart';
//import 'package:flutter_church_app_2020/Pages/admin.dart';
import 'package:flutter_church_app_2020/Pages/Profile/ProfilePage.dart';
import 'package:flutter_church_app_2020/Pages/MainSelectionsPage/MainSelectionsPage.dart';
import 'package:flutter_church_app_2020/Pages/Payments/PaymentMethodSelection/PaymentSelectionPage.dart';
import 'package:flutter_church_app_2020/Pages/Onboarding/OnboardingPage.dart';
import 'package:flutter_church_app_2020/Pages/Profile/edit_profile_page.dart';
import 'package:flutter_church_app_2020/Pages/Root/RootPage.dart';
import 'package:flutter_church_app_2020/Pages/Splash/SplashPage.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_church_app_2020/Pages/add_pastor_page.dart';
//import 'package:flutter_church_app_2020/Pages/pastoral_page.dart';
//import 'package:flutter_church_app_2020/Pages/pastoral_detail_page.dart';
//import 'package:flutter_church_app_2020/Pages/add_blog_page.dart';
//import 'package:flutter_church_app_2020/Pages/contact_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/PaymentPage/PaymentPage.dart';
import 'package:flutter_church_app_2020/Pages/SignupPage/TermsOfUse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Setting the main app orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return new MaterialApp(
        theme: ThemeData(fontFamily: "Futura"),
        title: 'Named App Routes',
        initialRoute: SplashPage.id,
        debugShowCheckedModeBanner: false, // Turns off banner

        routes: {

          //login page
          LogInPage.id: (context) {
            return LogInPage(auth: AuthCentral());
          },

          //splash page
          SplashPage.id: (context) {
            return SplashPage();
          },

          //RootPage
          RootPage.id: (context) {
            return RootPage(auth: AuthCentral());
          },

          // signup page
          RegistrationPage.id: (context) {
            return RegistrationPage(auth: AuthCentral());
          },

          //Terms page
          TermsOfUsePage.id: (context) {
            return TermsOfUsePage();
          },

          // onboarding page
          OnboardingPage.id: (context) {
            return OnboardingPage(
              auth: AuthCentral(),
            );
          },

          // home page
          MainSelectionsPage.id: (context) {
            return MainSelectionsPage();
          },

          // profile page
          ProfilePage.id: (context) {
            return ProfilePage();
          },

          // edit profile page
          EditProfilePage.id: (context) {
            return EditProfilePage();
          },

          //prayer page
          PrayerPage.id: (context) {
            return PrayerPage();
          },

          //add prayer page
          AddPrayerPage.id: (context) {
            return AddPrayerPage();
          },

          //prayer detail page
          PrayerDetailPage.id: (context) {
            return PrayerDetailPage();
          },


          // tithe and offering page
          TitheAndOffering.id: (context) {
            return TitheAndOffering();
          },

          //Payment Selection page
          PaymentSelectionPage.id: (context) {
            return PaymentSelectionPage();
          },

          //Payment page
          PaymentPage.id: (context) {
            return PaymentPage();
          },

          //bible page
          BiblePage.id: (context) {
            return BiblePage();
          },


/*
          //events page
          EventsPage.id: (context) {
            return EventsPage();
          },

          //events page
          //MediaPage.id: (context) {
          //return MediaPage();
          //},

          //media page
          //YoutubeVideoPlayer.id: (context) {
          //return YoutubeVideoPlayer();
          //},

          //social page
          SocialPage.id: (context) {
            return SocialPage();
          },


          //pastoral page
          PastoralListPage.id: (context) {
            return PastoralListPage();
          },

          //pastoral page
          PastoralPage.id: (context) {
            return PastoralPage();
          },

          //pastoral page
          PastoralDetailPage.id: (context) {
            return PastoralDetailPage();
          },

          //Add Pastoral Page
          AddBlogPage.id: (context) {
            return AddBlogPage();
          },

          //Add Pastoral Page
          AddPastorPage.id: (context) {
            return AddPastorPage();
          },

          //main chat page
          //ConversationPageList.id: (context) {
          //return ConversationPageList();
          //},

          //chat conversation page
          //ChatConversationPage.id: (context) {
          //return ChatConversationPage();
          //},

          //admin page
          AdminPage.id: (context) {
            return AdminPage();
          },
         */
        });
  }
}
