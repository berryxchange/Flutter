import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Firebase/FCM/ChurchFirebaseMessagingBLOC.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';

class VideoMediaPage extends StatefulWidget {
  static String id = "media_video_page";
  final ChurchUserModel thisAdmin;

  VideoMediaPage({this.thisAdmin});

  @override
  _VideoMediaPageState createState() => _VideoMediaPageState();
}

class _VideoMediaPageState extends State<VideoMediaPage> {
  bool isStreaming = false;
  ChurchUserModel thisAdmin;

  FirebaseMessagingBLOC firebaseMessagingBLOC;

  sendIsStreamingNotification() {
    //notification
    firebaseMessagingBLOC.callOnFcmApiSendPushNotifications(
        "${thisAdmin.userUID}",
        "/topics/liveStreamNotification",
        "Live Streaming",
        "Church is now Live Streaming",
        "liveStream");
    //--------------------
  }

  sendIsNotStreamingNotification() {
    //notification
    firebaseMessagingBLOC.callOnFcmApiSendPushNotifications(
        "${thisAdmin.userUID}",
        "/topics/liveStreamNotification",
        "Live Streaming",
        "Church Live Stream has ended",
        "liveStream");
    //--------------------
  }




  @override
  void initState() {
    // TODO: implement initState
    thisAdmin = widget.thisAdmin;

    firebaseMessagingBLOC = FirebaseMessagingBLOC();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only( left: 20.0, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/LiveStreamImage.png"),
              
              SizedBox(
                height: 20,
              ),

              Text("Live stream Channel!\n" "Coming Soon", 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24
                
              ),),
            ],
          ),
        )
      )
    );
  }
}
