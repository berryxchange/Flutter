import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Models/PrayerModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_church_app_2020/Firebase/FCM/ChurchFirebaseMessagingBLOC.dart';
import 'package:http/http.dart';

class PrayerDetailPage extends StatefulWidget {
  static String id = "prayer_detail_page";

  //instances
  final Prayer prayer;
  final ChurchUserModel thisUser;

  //-----------------------

  //initializer
  PrayerDetailPage({this.prayer, this.thisUser});
  //-----------------------

  @override
  _PrayerDetailPageState createState() => _PrayerDetailPageState();
}

class _PrayerDetailPageState extends State<PrayerDetailPage> {
  //Instances
  DatabaseReference prayerRef;
  DatabaseReference prayerAgreementRef;
  DatabaseReference userPrayersRef;
  DatabaseReference prayerPostUserRef;
  //ref listenres
  var prayerAgreementOnAddedRefListener;
  var prayerAgreementOnRemovedRefListener;
  var userPrayersOnAddedRefListener;
  var prayerPostUserOnAddedRefListener;

  String thisUserToken;
  ChurchUserModel prayerPostedUser;
  FirebaseMessagingBLOC firebaseMessagingBLOC;
  ChurchDB churchDB;

  Color agreementButtonIconColor = Colors.grey[300];

  //finals
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  //-----------------------

  //lists
  List<ChurchUserModel> prayerAgreedUsers = List();
  List<String> prayerAgreedUsersUID = List();
  //-----------------------

  //Initialization
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    churchDB = ChurchDB();
    firebaseMessagingBLOC = FirebaseMessagingBLOC();

    prayerAgreementRef = database
        .reference()
        .child('prayer-items')
        .child(widget.prayer.key)
        .child("prayerAgreedUsers");

    prayerAgreementOnAddedRefListener = prayerAgreementRef.onChildAdded.listen(_onPrayerAgreementEntryAdded);
    prayerAgreementOnRemovedRefListener = prayerAgreementRef.onChildRemoved.listen(_onPrayerAgreementChildRemoved);

    prayerPostUserRef = database.reference().child("Users");
    prayerPostUserOnAddedRefListener = prayerPostUserRef.onChildAdded.listen(_onPrayerPostUserAdded);

    print("prayer UID" + widget.prayer.byUserUID);

    prayerRef =
        database.reference().child('prayer-items').child(widget.prayer.key);
    userPrayersRef = database
        .reference()
        .child('Users')
        .child("${widget.thisUser.userUID}")
        .child("prayerAgreements");
  }
  //-----------------------

   Future getPrayerPostedUser() async{

    await churchDB.launchUsersPath(context: null, userModel: null, imageHasChanged: null, actionToDo: "read", userUIDToCheck: widget.prayer.byUserUID).then((value) {
      ChurchUserModel postedUser = value;
      setState(() {
        prayerPostedUser = postedUser;
        print("PostedUser Token: ${prayerPostedUser.token}");
      });
    });
    return prayerPostedUser;
  }



  _onPrayerPostUserAdded(Event event) {
    //setState(() {
    //thisUserToken = event.snapshot.value["token"];
    if (ChurchUserModel.fromSnapshot(event.snapshot).userUID ==
        widget.prayer.byUserUID) {
      print("prayer user" +
          ChurchUserModel.fromSnapshot(event.snapshot).userUID.toString());
      //thisUserToken = event.snapshot.value["token"];
    }else{
      print("user not the same");
    }

    if (ChurchUserModel.fromSnapshot(event.snapshot).userUID ==
        widget.prayer.byUserUID) {
      prayerPostedUser = ChurchUserModel.fromSnapshot(event.snapshot);
      print("Added Post User token: " + prayerPostedUser.token);
    }else{
      print("user not the same");
    }
  }


  //Listeners
  _onPrayerAgreementEntryAdded(Event event) {
    setState(() {
      prayerAgreedUsers.add(ChurchUserModel.fromSnapshot(event.snapshot));
      prayerAgreedUsersUID.add(ChurchUserModel.fromSnapshot(event.snapshot).userUID);
      print(ChurchUserModel.fromSnapshot(event.snapshot).userUID +
          "added to the list");
    });

    for (var i in prayerAgreedUsersUID) {
      print(i);
    }
    checkButtonStatus();
    prayerAgreedUsersUID.contains(widget.thisUser.userUID)
        ? print("This user is an agreed user")
        : print("this user is not an agreed user!");
  }

  _onPrayerAgreementChildRemoved(Event event) {
    var oldUID = prayerAgreedUsersUID.singleWhere((entry) {
      print("event ${ChurchUserModel.fromSnapshot(event.snapshot).userUID}");
      print("entry $entry");

      return entry == ChurchUserModel.fromSnapshot(event.snapshot).userUID;
    });

    var old = prayerAgreedUsers.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    //ministries[ministries.indexOf(old)] = Ministry.fromSnapshot(event.snapshot);
    prayerAgreedUsersUID.removeAt(prayerAgreedUsersUID.indexOf(oldUID));
    prayerAgreedUsers.removeAt(prayerAgreedUsers.indexOf(old));
    print(ChurchUserModel.fromSnapshot(event.snapshot).userUID +
        "removed from the list");

    checkButtonStatus();
  }
  //-----------------------

  //voids
  void checkButtonStatus() {
    bool buttonStatus = false;

    prayerAgreedUsersUID.contains(widget.thisUser.userUID)
        ? print("The user resides!")
        : print("nothing bro..");

    if (prayerAgreedUsersUID.contains(widget.thisUser.userUID)) {
      buttonStatus = true;
      setState(() {
        agreementButtonIconColor = Colors.blueAccent;
      });
    } else {
      buttonStatus = false;
      setState(() {
        agreementButtonIconColor = Colors.grey[300];
      });
    }
    print("Button status is: $buttonStatus");
  }


  void handleUpdate() async {
    print("agreement count: $prayerAgreedUsers");
    // add user to the list

    if (prayerAgreedUsers.length == 0 || prayerAgreedUsers == []) {
      print("array is empty");

      prayerAgreementRef
          .child(widget.thisUser.userUID)
          .set(widget.thisUser.toJson());

      //sets in user profile
      userPrayersRef.child("${widget.prayer.key}").set(widget.prayer.toJson());
      print(prayerAgreedUsers);

      //notification
      getPrayerPostedUser().then((user) {
        ChurchUserModel postingUser = user;
        print(postingUser.token);
        firebaseMessagingBLOC.callOnFcmApiSendPushNotifications(
            "${widget.thisUser.userUID}",
            "${postingUser.token}",
            "TCI Prayer",
            "${widget.thisUser.userEmail} is in agreement with your prayer: ${widget.prayer.prayerTitle}",
            "prayer"
        );
      });
    } else {
      ChurchUserModel presentUser;

      if (prayerAgreedUsersUID.contains(widget.thisUser.userUID)) {
        for (ChurchUserModel user in prayerAgreedUsers) {
          if (widget.thisUser.userUID == user.userUID) {
            print("this user is here");

            removePrayerFromUser(widget.prayer);
            // remove this user

            removeUserAgreement(user);

            //checkButtonStatus();
          }
        }
      } else {
        ChurchUserModel presentUser = ChurchUserModel();

        if (presentUser.userUID == null || presentUser.userUID == "") {
          print("pushing new user..");
          prayerAgreementRef
              .child(widget.thisUser.userUID)
              .set(widget.thisUser.toJson());
          userPrayersRef
              .child("${widget.prayer.key}")
              .set(widget.prayer.toJson());
          //notification
          print(thisUserToken);
          //checkButtonStatus();
          getPrayerPostedUser().then((user) {
            ChurchUserModel postingUser = user;
            print(postingUser.token);
            firebaseMessagingBLOC.callOnFcmApiSendPushNotifications(
                "${widget.thisUser.userUID}",
                "${postingUser.token}",
                "TCI Prayer",
                "${widget.thisUser.userEmail} is in agreement with your prayer: ${widget.prayer.prayerTitle}",
                "prayer"
            );
          });
        }
      }
    }
  }



  void removeUserAgreement(ChurchUserModel userToRemove) {
    prayerAgreementRef.child("${userToRemove.userUID}").remove();
  }

  void removePrayerFromUser(Prayer prayerToRemove) {
    userPrayersRef.child("${prayerToRemove.key}").remove();
  }
  //-----------------------


  @override
  void dispose() {
    // TODO: implement dispose
    prayerAgreementOnAddedRefListener?.cancel();
    prayerAgreementOnRemovedRefListener?.cancel();
    userPrayersOnAddedRefListener?.cancel();
    prayerPostUserOnAddedRefListener?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer Wall"),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 40, bottom: 50, left: 8, right: 8),
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                widget.prayer.prayerTitle,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Center(
              child: Text(
                widget.prayer.prayerFullDate,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.prayer.prayerMessage,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Column(
            children: <Widget>[
              Center(
                child: Text(
                  prayerAgreedUsers.length.toString(),
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w500,
                    color: agreementButtonIconColor,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "People are in Agreement \nwith this prayer",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w200,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () {
              //setState(() {
              handleUpdate();
              checkButtonStatus();
              //});
            },
            child: Center(
              child: Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: agreementButtonIconColor, width: 2)),
                child: Image.asset(
                  "Assets/prayingHands@2x.png",
                  color: agreementButtonIconColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
