import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'dart:async';

class FirebaseMessagingBLOC {
  FirebaseAuth auth = AuthCentral.auth;
  FirebaseDatabase database = FirebaseDatabase.instance;

  final FirebaseMessaging _fcm = FirebaseMessaging();

//---------- BLOC Logic ------------

  // get a device token for messaging

  saveDeviceToken(UserModel thisUser) async {
    String token;

    // get the token
    String fcmToken = await _fcm.getToken();

    //Save it to the firebase Database
    setUserToken(fcmToken, thisUser);
    }

  Future setUserToken(String fcmToken, UserModel thisUser) async {

    var userTokenRef = database
        .reference()
        .child('Users')
        .child(thisUser.uid)
        .child("thisUserInfo");

    checkAndSetFCM(userTokenRef, fcmToken, thisUser);
  }

   Future checkAndSetFCM(DatabaseReference userTokenRef, String fcmToken, UserModel thisUser) async {
      if (fcmToken != null) {
        print("Getting token for : ${thisUser.uid}");
        print("User deviceId: $fcmToken");

        if (thisUser.token == null || thisUser.token != fcmToken) {
          thisUser.token = fcmToken;
          await userTokenRef.set(thisUser.toJson());
          print("token has been set");
        }
      }
    }

//--------------- For FCM ---------------------
//StreamSubscriptions
  StreamSubscription<IosNotificationSettings> iosSubsription;

  //for the setup
  //in the if(platform)
  subscribeToNotification(){
    iosSubsription = _fcm.onIosSettingsRegistered.listen((data) {
      //save the token or subscribe to a topic here
    });
    return iosSubsription;
  }

  setIOSNotificationSettings(){
    _fcm.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  listenForIOSNotificationSettingRegistration(){
    _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  listenForFCMTokenRefresh(){
    _fcm.onTokenRefresh.listen((data) {
      print('Refresh Token: $data');
    }, onDone: () {
      print('Refresh Token Done');
    });
  }


  setupNotifications() {
    if (Platform.isIOS) {
      subscribeToNotification();

      //_fcm.requestNotificationPermissions(IosNotificationSettings());

      setIOSNotificationSettings();

      listenForIOSNotificationSettingRegistration();

      listenForFCMTokenRefresh();
    }
  }



  //to configure the FCM

  //for the incoming message
  //IOS
  configureForIos(BuildContext context, User firebaseUser, Map<String, dynamic> mainMessage) {
    var thisMessage;

    thisMessage = mainMessage["sender"];
    print("onMessage conversion with aps: $thisMessage");
    print("the user senderid: ${firebaseUser.uid}");

    if (thisMessage == firebaseUser.uid) {
      //don't show notification
      print("sorry, they are the same...");
    } else if (thisMessage != firebaseUser.uid) {
      //print("sender: " + message["data"]["sender"]);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: ListTile(
                title: Text(mainMessage["aps"]["alert"]["title"]),
                subtitle: Text(mainMessage["aps"]["alert"]["body"]),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    // _notificationSender(message["aps"]["category"]);
                  },
                ),
              ],
            );
          });
    }
  }

//Android
  configureForAndroid(BuildContext context, User firebaseUser, Map<String, dynamic> mainMessage) {
    var thisMessage;

    thisMessage = mainMessage['notification']['body'];
    print("onMessage conversion with notification: $thisMessage");

    if (thisMessage["data"]["sender"] == firebaseUser.uid) {
      //don't show notification
    } else {
      print("sender: " + thisMessage["data"]["sender"]);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: ListTile(
                title: Text(mainMessage["notification"]["title"]),
                subtitle: Text(mainMessage["notification"]["body"]),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    //_notificationSender(message["data"]["click_action"]);
                  },
                ),
              ],
            );
          });
    }
  }

  onMessage(BuildContext context, User firebaseUser, Map<String, dynamic> mainMessage) {
    //for iOS Notifications
    if (Theme
        .of(context)
        .platform == TargetPlatform.iOS) {
      configureForIos(context, firebaseUser, mainMessage);

      //for android notifications
    } else {
      configureForAndroid(context, firebaseUser, mainMessage);
    }
    //print("on message: $message, notification: ${message["notification"]}, notification Title: ${message["notification"]["title"]}");
  }


  configureFCM(BuildContext context, User firebaseUser) {
    _fcm.configure(

      //onBackgroundMessage: myBackgroundMessageHandler,

        onMessage: (Map<String, dynamic> message) async {
          onMessage(context, firebaseUser, message);
        },

        //FCM Messaging

        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          //_onLaunchNotificationSender(message["data"]["click_action"]);
        }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      //_onLaunchNotificationSender(message["data"]["click_action"]);
    });
  }
//----------------- Futures ---------------

  //Voids

  //Subscriptions
  //for FCM
  void subscribeToPrayers() {
    _fcm.subscribeToTopic("prayerNotification");
    print("subsribed to prayers");
  }

  void unsubscribeToPrayers() {
    _fcm.unsubscribeFromTopic("prayerNotification");
    print("unsubsribed to prayers");
  }

  void subscribeToPastoralBlog() {
    _fcm.subscribeToTopic("pastorBlogNotification");
    print("subsribed to pastoral blog");
  }

  void unsubscribeToPastoralBlog() {
    _fcm.unsubscribeFromTopic("pastorBlogNotification");
    print("unsubsribed to pastoral blog");
  }


//---------- The Constructor ------------
  FirebaseMessagingBLOC() {}
}