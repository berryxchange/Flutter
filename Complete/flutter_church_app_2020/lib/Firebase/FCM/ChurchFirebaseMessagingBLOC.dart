import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'dart:async';
import 'package:flutter_church_app_2020/Pages/PrayerPage/PrayerPage.dart';
import 'package:flutter_church_app_2020/Pages/Media/Video/VideoMediaPage.dart';


class FirebaseMessagingBLOC {
  FirebaseAuth auth = AuthCentral.auth;
  FirebaseDatabase database = FirebaseDatabase.instance;

  final FirebaseMessaging _fcm = FirebaseMessaging();

//---------- BLOC Logic ------------

  // get a device token for messaging

  saveDeviceToken(ChurchUserModel thisUser) async {
    String token;

    // get the token
    String fcmToken = await _fcm.getToken();

    //Save it to the firebase Database
    setUserToken(fcmToken, thisUser);
    }

  Future setUserToken(String fcmToken, ChurchUserModel thisUser) async {

    var userTokenRef = database
        .reference()
        .child('Users')
        .child(thisUser.userUID)
        .child("thisUserInfo");

    checkAndSetFCM(userTokenRef, fcmToken, thisUser);
  }

   Future checkAndSetFCM(DatabaseReference userTokenRef, String fcmToken, ChurchUserModel thisUser) async {
      if (fcmToken != null) {
        print("Getting token for : ${thisUser.userUID}");
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
  configureForIos(BuildContext context, ChurchUserModel thisUser, Map<String, dynamic> mainMessage) async {
    var messageSender;
    messageSender = mainMessage["sender"];

    //the message transformed just in case the iOS uses different data
    //print("onMessage conversion with aps: $messageSender");
    //print("the user senderid: ${thisUser.userUID}");
    //print("the user Category: ${mainMessage["notification"]["click_action"]}");
    //print("the user alert: ${mainMessage["notification"]["sound2"]}");
    //print("the user title: ${mainMessage["notification"]["title"]}");
    //print("the user body: ${mainMessage["notification"]["body"]}");


    newMessage(){
      if (mainMessage["notification"] != null){
        if (messageSender == thisUser.userUID) {
          //don't show notification
          print("sorry, they are the same...");
        } else if (messageSender != thisUser.userUID) {
          //print("sender: " + message["data"]["sender"]);
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

                        _notificationSender(context, thisUser, mainMessage["notification"]["click_action"]);
                      },
                    ),
                  ],
                );
              });
        }
      }else if (mainMessage["aps"] != null){
        if (messageSender == thisUser.userUID) {
          //don't show notification
          print("sorry, they are the same...");
        } else if (messageSender != thisUser.userUID) {
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

                        _notificationSender(context, thisUser, mainMessage["aps"]["category"]);
                      },
                    ),
                  ],
                );
              });
        }
      }
    }

    newMessage();
  }

//Android
  configureForAndroid(BuildContext context, ChurchUserModel thisUser, var mainMessage) async {
    var thisMessage;

    thisMessage = mainMessage['notification']['body'];
    print("onMessage conversion with notification: $thisMessage");

    if (thisMessage["data"]["sender"] == thisUser.userUID) {
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
                    _notificationSender(context, thisUser, mainMessage["data"]["click_action"]);
                  },
                ),
              ],
            );
          });
    }
  }

  onMessage(BuildContext context, ChurchUserModel thisUser, var mainMessage) async{

    print("incoming!!!!!!");
    //for iOS Notifications
    if (Theme
        .of(context)
        .platform == TargetPlatform.iOS) {
      configureForIos(context, thisUser, mainMessage);

      //for android notifications
    } else {
      configureForAndroid(context, thisUser, mainMessage);
    }
    //print("on message: $message, notification: ${message["notification"]}, notification Title: ${message["notification"]["title"]}");
  }


  configureFCM(BuildContext context, ChurchUserModel thisUser) {
    _fcm.configure(

      //onBackgroundMessage: myBackgroundMessageHandler,

        onMessage: (Map<String, dynamic> message) async {
          print("incoming!!!!!! $message");
          onMessage(context, thisUser, message);
        },

        //FCM Messaging

        onLaunch: (Map<String, dynamic> message) async {
          print("incoming!!!!!!");
          print("onLaunch: $message");
          _onLaunchNotificationSender(context, thisUser, message["notification"]["click_action"]);
        }, onResume: (Map<String, dynamic> message) async {
      print("incoming!!!!!!");
      print("onResume: $message");
      _onLaunchNotificationSender(context, thisUser, message["notification"]["click_action"]);
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

  void subscribeToLiveStream() {
    _fcm.subscribeToTopic("liveStreamNotification");
    print("subsribed to live stream ministry");
  }

  void unsubscribeToLiveStream() {
    _fcm.unsubscribeFromTopic("liveStreamNotification");
    print("unsubsribed to live stream ministry");
  }





  //sending to device
  _notificationSender(BuildContext context, ChurchUserModel thisUser, String destination,) {
    switch (destination) {
      case "FLUTTER_NOTIFICATION_CLICK":
        return Navigator.of(context).pop();
        break;
      case "none":
        return Navigator.of(context).pop();
        break;
      case "prayer":
        Navigator.of(context).pop();
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return PrayerPage(thisUser: thisUser,);
          },
        ));
      case "liveStream":
      //Navigator.of(context).pop();
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return VideoMediaPage(thisAdmin: thisUser);
          },
        ));//Navigator.popAndPushNamed(context, PrayerPage.id, );
    }
  }

  _onLaunchNotificationSender(BuildContext context, ChurchUserModel thisUser, String destination) {
    switch (destination) {
      case "none":
        return Navigator.of(context).pop();
        break;
      case "prayer":
        //Navigator.of(context).pop();
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return PrayerPage(thisUser: thisUser,);
          },
        ));
      case "liveStream":
      //Navigator.of(context).pop();
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return VideoMediaPage(thisAdmin: thisUser);
          },
        ));//Navigator.pushNamed(context, PrayerPage.id);
    }
  }




  //Prayer Page
  Future<bool> callOnFcmApiSendPushNotifications(String sender, String receiver, String title, String body, String destination) async {

    String FCMDestination;

    switch(destination){
      case "FLUTTER_NOTIFICATION_CLICK":
        FCMDestination = 'FLUTTER_NOTIFICATION_CLICK';
        break;
      case "none":
        FCMDestination = 'none';
        break;
      case "prayer":
        FCMDestination = 'prayer';
        break;
      case "liveStream":
        FCMDestination = 'liveStream';
        break;
    }

    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "notification": {

        "body": body,
        "title": title,
        "content_available": true,
        "click_action": FCMDestination,
        //"click_action": "$destination",
        "sound": "assets/sounds/item_dropped.mp3",
        "sender": "$sender",
      },
      "priority": "high",
      "data": {
        "sender": "$sender",
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
        //"click_action": "$destination",
        "id": "1",
        "status": "done"
      },
      "to": "$receiver"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAqvL3Fnk:APA91bGforznGq0V952tZx66O8Q78qdBNCv8EbTZSSzi8Sb8qXTBXV_C6oyuT3-DgeOl9W83L2R7vslOvcCFlJBJqWVJDPfhmHhE0kdUFp4Edtja4M1YbEI6wKHkjIWo-xYA6MF7msfU'
    };


    final response = await http.post(
        postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers
    );

    print("response code: ${response.statusCode}");

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      // on failure do sth
      return false;
    }
  }




//---------- The Constructor ------------
  FirebaseMessagingBLOC() {}
}