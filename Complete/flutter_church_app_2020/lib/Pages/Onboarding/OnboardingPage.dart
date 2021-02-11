//import 'package:flutter_church_app_2020/Pages/admin.dart';
import 'package:flutter/material.dart';
//import 'package:intro_views_flutter/Models/page_view_model.dart';
//import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
//import 'package:flutter_church_app_2020/Pages/MainSelectionsPage/MainSelectionsPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:flutter_church_app_2020/Pages/profile_page.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';

class Walkthrough {
  String walkthroughTitle;
  String walkthroughBody;
  String walkthroughBackgroundImage;
  String walkthroughImage;
  String walkthroughTabImage;
  bool hasOnboardingIcon = false;
  bool hasDoneButton = false;
  bool hasCloseButton = true;
  Color pageColor;
  TextStyle textStyle;
  Walkthrough({
    this.walkthroughTitle,
    this.walkthroughBody,
    this.walkthroughImage,
    this.walkthroughBackgroundImage,
    this.textStyle,
    this.pageColor,
    this.hasDoneButton,
    this.walkthroughTabImage,
    this.hasOnboardingIcon,
    this.hasCloseButton,
  });
}

class OnboardingPage extends StatefulWidget {
  static String id = "onboarding_page";

  final String kindOfOnboardingString;

  bool isViewedIntroOnboarding = false;

  final AuthCentral auth;
  final VoidCallback onSignedIn;

  OnboardingPage(
      {this.isViewedIntroOnboarding,
      this.kindOfOnboardingString,
      this.onSignedIn,
      this.auth});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //Instances
  DatabaseReference userRef;
  DatabaseReference membersRef;
  User thisCurrentUser;
  ChurchUserModel thisUser;
  bool hasCloseButton = false;

  List<Walkthrough> pages = List();

  //------------------

  //finals
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final _auth = FirebaseAuth.instance;

  //------------------

  //voids
  void getCurrentUser() async {
    try {
      final thisUser = _auth.currentUser;
      if (thisUser != null) {
        thisCurrentUser = thisUser;
        print(thisCurrentUser.email);
        print(thisCurrentUser.uid);
        print("all good to go!");

        userRef =
            database.reference().child('users').child("${thisCurrentUser.uid}");
        membersRef = database
            .reference()
            .child('members')
            .child("${thisCurrentUser.uid}");
        userRef.onChildAdded.listen(_onUserEntryAdded);
      } else {
        print("this user is not in the database...");
      }
    } catch (error) {
      print("something went wrong: $error");
    }
  }

  //listeners
  _onUserEntryAdded(Event event) {
    //thisUserInfo
    var trueUser = ChurchUserModel.fromSnapshot(event.snapshot);
    print(event.snapshot.toString());
    if (trueUser.userName != null) {
      print("this Current User! ${trueUser.userName}");
      thisUser = trueUser;
    }
  }

  //------------------

  //onboarding

  //Intro
  List<Walkthrough> introPages = [
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'Welcome to Church App! We are glad you are connected with us, lets begin…',
      walkthroughTitle: 'Welcome!',
      textStyle: TextStyle(fontFamily: 'Futura', color: Colors.white),
      walkthroughImage: '',
      walkthroughBackgroundImage: 'images/welcome.jpg',
      walkthroughTabImage: 'images/welcome.jpg',
      hasOnboardingIcon: false,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'There are a few areas we should review before you get started.',
      walkthroughTitle: 'Introduction',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: '',
      walkthroughBackgroundImage: 'images/Introduction.jpg',
      walkthroughTabImage: 'images/Introduction.jpg',
      hasOnboardingIcon: false,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'This is the place to view your church\'s upcoming events, parties, practices, plays, classes, etc.',
      walkthroughTitle: 'Events',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/EventsIcon.png',
      walkthroughBackgroundImage: 'images/EventsImage.jpeg',
      walkthroughTabImage: 'images/EventsImage.jpeg',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'Here, you can view your church\'s live-stream service, pre-recorded sermons, and other hosted media.',
      walkthroughTitle: 'Media',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/MediaIcon.png',
      walkthroughBackgroundImage: 'images/MediaImage.jpg',
      walkthroughTabImage: 'images/MediaImage.jpg',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'This is the place all members can share their life’s important events, for everyone to enjoy.',
      walkthroughTitle: 'Social',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/SocialIcon.png',
      walkthroughBackgroundImage: 'images/SocialImage.png',
      walkthroughTabImage: 'images/SocialImage.png',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'A delicate place that members can confidently post prayers in faith, while others can agree with them.',
      walkthroughTitle: 'Prayer',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/PrayerIcon.png',
      walkthroughBackgroundImage: 'images/PrayerImage.jpeg',
      walkthroughTabImage: 'images/PrayerImage.jpeg',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'A place where members can stay up to date with their pastor(s) for encouragement and enjoyment.',
      walkthroughTitle: 'Pastoral',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/PastoralIcon.png',
      walkthroughBackgroundImage: 'images/PastoralImage.png',
      walkthroughTabImage: 'images/PastoralImage.png',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'Connects to Pages.Bible.com, where members can fully utilize and get the most out of their bible.',
      walkthroughTitle: 'Pages.Bible',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/BibleIcon.png',
      walkthroughBackgroundImage: 'images/BibleImage.png',
      walkthroughTabImage: 'images/BibleImage.png',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'A feature that allows members to communicate with one another and stay connected.',
      walkthroughTitle: 'Chat',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/ChatIcon.png',
      walkthroughBackgroundImage: 'images/ChatImage.png',
      walkthroughTabImage: 'images/ChatImage.png',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'An administrative feature that allows admins to mass email or text their members as well as regulate them.',
      walkthroughTitle: 'Admin Dashboard',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/AdminIcon.png',
      walkthroughBackgroundImage: 'images/DashboardImage.png',
      walkthroughTabImage: 'images/DashboardImage.png',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody:
          'Your personal dashboard to your data, tithing, saved content and more!',
      walkthroughTitle: 'Profile',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/ProfileIcon.png',
      walkthroughBackgroundImage: 'images/ProfileImage.png',
      walkthroughTabImage: 'images/ProfileImage.png',
      hasOnboardingIcon: true,
      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody: 'Lets get into the app.',
      walkthroughTitle: 'All Set!',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/profileIcon.png',
      walkthroughBackgroundImage: 'images/partyImage.jpg',
      walkthroughTabImage: 'images/partyImage.jpg',
      hasOnboardingIcon: false,
      hasCloseButton: false,
      hasDoneButton: true,
    ),
  ];

  //Admin
  List<Walkthrough> adminPages = [
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'A place to send out important information, notifications and updates about things in your church, to every member, at the same time.',

      walkthroughTitle: 'Mass Messaging',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: '',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'By clicking the complaints tab, you are able to handle all complaints from users.',

      walkthroughTitle: 'Complaints',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: '',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'In the detail of each complaint, you can view each plaintiff and defendant and hopefully resolve their issues',

      walkthroughTitle: 'Complaint Detail',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: '',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'If you need to get clarity or send a resolvement to the plaintiff, you can click the "Message Plaintiff" button',

      walkthroughTitle: 'Message Plaintiff',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: '',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'If you need to get clarity or send a resolvement to the defendant, you can click the "Message Defendant" button',

      walkthroughTitle: 'Message Defendant',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: '',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'To mark as resolved, you can click the "Mark As Resolved" button and the main page will mark the message in green.',

      walkthroughTitle: 'Mark As Resolved',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: '',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'To clear the queue from resolved complaints, swipe left on the complaint you want to delete and click delete.',

      walkthroughTitle: 'Delete A Complaint',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: '',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'By Clicking the "Roles" tab, you are able to regulate any user and give that user an administrative role.',

      walkthroughTitle: 'User Roles',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: 'images/User Roles.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody: 'Lets get into the admin section.',
      walkthroughTitle: 'All Set!',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/profileIcon.png',
      walkthroughBackgroundImage: 'images/partyImage.jpg',
      walkthroughTabImage: 'images/partyImage.jpg',
      hasOnboardingIcon: false,
      hasCloseButton: false,
      hasDoneButton: true,
    ),
  ];

  //Prayer
  List<Walkthrough> prayerPages = [
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'To add your prayer, click the "plus sign" at the top right.',

      walkthroughTitle: 'Add',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: 'images/Prayer Page.png',

      walkthroughTabImage: "",

      hasOnboardingIcon: false,

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'To show someone that you are standing in agreement with their prayer, click their prayer, then click the praying hands.',

      walkthroughTitle: 'Agree',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: 'images/Prayer Detail Page.png',

      walkthroughTabImage: "",

      hasOnboardingIcon: false,

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody: 'Lets get into the prayer section.',
      walkthroughTitle: 'All Set!',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/profileIcon.png',
      walkthroughBackgroundImage: 'images/partyImage.jpg',
      walkthroughTabImage: 'images/partyImage.jpg',
      hasOnboardingIcon: false,
      hasCloseButton: false,
      hasDoneButton: true,
    ),
  ];

  //Profile
  List<Walkthrough> profilePages = [
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'To edit your profile information, simply goto your profile from the main page and click the edit button in the top right.',

      walkthroughTitle: 'Edit',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/Edit Profile.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'To send in your tithe, goto your profile, scroll to the bottom of the page and click tithe.',

      walkthroughTitle: 'Tithe',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/Tithe.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'Once you have joined a group /class or event in Events section, that group will show up here.',

      walkthroughTitle: 'Interested Events',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/Interested Events.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'Once you have posted a social post, that post will also be stored here in “Social”.',

      walkthroughTitle: 'Social Posts',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/Social Posts.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'If you have posted a prayer, that prayer will also be stored here in “Prayer”.',

      walkthroughTitle: 'Prayers',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/Prayers.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'If you are supporting someone in their prayer, that prayer will also be stored here in “Agreements”.',

      walkthroughTitle: 'Prayer Agreements',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/Prayer Agreements.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'If you have liked someones social post, that post will be stored here in “Social Likes".',

      walkthroughTitle: 'Liked Social Posts',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/Liked Social Posts.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'If you have liked your pastor’s post, that post will be stored here in “Pastoral Likes”.',

      walkthroughTitle: 'Liked Pastoral Posts',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/Liked Pastoral Posts.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'This notification allows you to receive main app notifications, such as updates, changes and news about the app.',

      walkthroughTitle: 'Main Notifications',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/MainNotifications.png',

      walkthroughTabImage: '',

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'This notification allows you to receive media notifications, for when a new church video or audio has been uploaded.',

      walkthroughTitle: 'Media Notifications',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/MediaNotifications.png',

      walkthroughTabImage: '',

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'This notification allows you to receive social notifications, for when a social post has been posted.',

      walkthroughTitle: 'Social Notifications',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: 'images/SocialNotifications.png',

      walkthroughTabImage: '',

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'This notification allows you to receive prayer notifications, for when someone is in need of prayer.',

      walkthroughTitle: 'Prayer Notifications',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: "",

      walkthroughBackgroundImage: 'images/PrayerNotifications.png',

      walkthroughTabImage: '',

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'This notification allows you to receive pastoral notifications, for when your pastor(s) makes a post.',

      walkthroughTitle: 'Pastoral Notifications',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: '',

      walkthroughBackgroundImage: 'images/PastoralNotifications.png',

      walkthroughTabImage: '',

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',

      walkthroughBody:
          'To delete your account and all your data and information, goto your profile, and scroll to the bottom, then click delete.',

      walkthroughTitle: 'Delete Account',

      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),

      walkthroughImage: 'images/ProfileIcon.png',

      walkthroughBackgroundImage: 'images/Delete Account.png',

      walkthroughTabImage: "",

      hasCloseButton: true,
    ),
    Walkthrough(
      pageColor: Colors.white,
      walkthroughBody: 'Lets get into the profile section.',
      walkthroughTitle: 'All Set!',
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      walkthroughImage: 'images/profileIcon.png',
      walkthroughBackgroundImage: 'images/partyImage.jpg',
      walkthroughTabImage: 'images/partyImage.jpg',
      hasOnboardingIcon: false,
      hasCloseButton: false,
      hasDoneButton: true,
    ),
  ];

  //------------------

  //functions
  _setIntroOnboardingToUser() {
    thisUser.isViewedIntroOnboarding = true;
    userRef.child("thisUserInfo").update((thisUser.toJson()));
    membersRef.update((thisUser.toJson()));
  }

  _setAdminOnboardingToUser() {
    thisUser.isViewedAdminOnboarding = true;
    userRef.child("thisUserInfo").update((thisUser.toJson()));
    membersRef.update((thisUser.toJson()));
  }

  _setPrayerOnboardingToUser() {
    thisUser.isViewedPrayerOnboarding = true;
    userRef.child("thisUserInfo").update((thisUser.toJson()));
    membersRef.update((thisUser.toJson()));
  }

  _setProfileOnboardingToUser() {
    thisUser.isViewedProfileOnboarding = true;
    userRef.child("thisUserInfo").update((thisUser.toJson()));
    membersRef.update((thisUser.toJson()));
  }

  _kindOfOnboarding(String type) {
    //# 1 for setting data to user account
    // and loading the correct pages for view
    switch (type) {
      case "intro_page":
        print("yay! intro page!!");
        setState(() {
          pages = introPages;
        });
        break;
      case "main_page":
        print("yay! intro page!!");
        setState(() {
          pages = introPages;
        });
        break;
      case "admin_page":
        print("yay! admin page!!");
        setState(() {
          pages = adminPages;
        });
        break;
      case "prayer_page":
        print("yay! prayer page!!");
        setState(() {
          pages = prayerPages;
        });
        break;
      case "profile_page":
        print("yay! profile page!!");
        setState(() {
          pages = profilePages;
        });
        break;
      default:
        break;
    }
  }

  _checkCloseButton(bool hasButton) {
    if (hasButton == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, right: 10),
            child: MaterialButton(
                color: Colors.blueAccent[100],
                child: Text(
                  "Close",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  _segueHome();
                }),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  _checkDoneButton(bool hasButton) {
    if (hasButton == true) {
      return Container(
        child: Center(
          child: MaterialButton(
              color: Colors.blueAccent[100],
              child: Text(
                "Close",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _segueHome();
              }),
        ),
      );
    } else {
      return Container();
    }
  }

  Center _checkIcon(bool hasIcon, index) {
    if (hasIcon == true) {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Center(
            child: Image.asset(
              pages[index].walkthroughImage,
              width: 75,
              height: 75,
              alignment: Alignment.center,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 8, offset: Offset(0, 3), color: Colors.black38),
            ],
          ),
          height: 100,
          width: 100,
        ),
      );
    } else {
      return Center();
    }
  }

  _segueHome() {
    //# 2 for segue back to parent main pages

    switch (widget.kindOfOnboardingString) {
      case "intro_page":
        print("yay! intro page!!");

        _setIntroOnboardingToUser();

        widget.onSignedIn();

        setState(() {
          //Navigator.of(context).pushReplacementNamed(MainSelectionsPage.id);
        });

        break;
      case "main_page":
        print("yay! intro page!!");

        _setIntroOnboardingToUser();
        setState(() {
          Navigator.pop(context);
        });

        break;
      case "admin_page":
        print("yay! admin page!!");

        _setAdminOnboardingToUser();
        setState(() {
          Navigator.pop(context);
        });

        break;
      case "prayer_page":
        print("yay! prayer page!!");

        _setPrayerOnboardingToUser();
        setState(() {
          Navigator.pop(context);
        });

        break;
      case "profile_page":
        print("yay! prayer page!!");

        _setProfileOnboardingToUser();
        setState(() {
          Navigator.pop(context);
          /*
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProfilePage(
                  thisUser: thisUser,
                  thisAdmin: thisUser,
                  isCurrentUser: true,
                  thisAuthUser: thisCurrentUser,
                  //currentUserUid: "$thisCurrentUser",

                );
              },
            ),
          );
          */
        });

        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    _kindOfOnboarding(widget.kindOfOnboardingString);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ListView(
                children: <Widget>[
                  Container(
                      color: pages[index].pageColor,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            pages[index].walkthroughTabImage,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Container(
                            color: Colors.black.withAlpha(150),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                          _checkCloseButton(pages[index].hasCloseButton),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 75, left: 20, right: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 1.33,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                      color: Colors.black38),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                child: Align(
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          //start of inside box
                                          Image.asset(
                                            pages[index]
                                                .walkthroughBackgroundImage,
                                            fit: BoxFit.cover,
                                            height: 250,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          //Container(
                                          //decoration: BoxDecoration(
                                          //color: Colors.indigo[200],
                                          //borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                          //),
                                          //height: 250,
                                          //width: MediaQuery.of(context).size.width,
                                          //child: Image.asset(pages[index].walkthroughBackgroundImage,
                                          //fit: BoxFit.cover,
                                          //),
                                          //),
                                          _checkIcon(
                                              pages[index].hasOnboardingIcon,
                                              index),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text(
                                            pages[index].walkthroughTitle,
                                            style: TextStyle(
                                              fontSize: 30,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              fontFamily: "Futura",
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Container(
                                          child: Text(
                                              pages[index].walkthroughBody,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                  fontFamily: "Futura")),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      _checkDoneButton(
                                          pages[index].hasDoneButton),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              );
            },
            itemCount: pages.length,
            controller: SwiperController(),
            //containerHeight: 500,
            pagination: SwiperPagination(builder: SwiperPagination.dots),
            loop: false,
          ),
        ],
      ),
    );
  }
}
