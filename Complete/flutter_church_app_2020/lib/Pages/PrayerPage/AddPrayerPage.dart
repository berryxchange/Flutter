import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Models/PrayerModel.dart';
import 'package:flutter_church_app_2020/Widget/MainButtonWidgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_church_app_2020/Firebase/FCM/ChurchFirebaseMessagingBLOC.dart';

class AddPrayerPage extends StatefulWidget {
  static String id = "add_prayer_page";

  @override
  _AddPrayerPageState createState() => _AddPrayerPageState();
}

class _AddPrayerPageState extends State<AddPrayerPage> {
  //Instances
  Prayer prayer;
  DatabaseReference prayerRef;
  DatabaseReference userPrayerRef;
  User thisCurrentUser;
  FirebaseMessagingBLOC firebaseMessagingBLOC;
  String thisUserToken;
  //-----------------------

  //Finals
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  //-----------------------

  //Strings
  var now = DateTime.now();
  var fullDateFormatter = DateFormat("yyyy-MM-dd");
  var dayFormatter = DateFormat("dd");
  var monthFormatter = DateFormat("MMM");
  var day;
  var month;

  //-----------------------

  //Strings
  String formattedTime;
  String todaysDate;
  String todaysDay;
  String todaysMonth;
  //-----------------------

  //Initialization
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
    firebaseMessagingBLOC = FirebaseMessagingBLOC();

    formattedTime = fullDateFormatter.format(now);
    todaysDate = formattedTime;
    todaysDay = dayFormatter.format(now);
    todaysMonth = monthFormatter.format(now);
//object container - used for containing sendable data to the server
    prayer = Prayer("", "", todaysDay, todaysMonth, todaysDate, "", "");
  }
  //-----------------------

  //voids
  void getCurrentUser() async {
    try {
      final thisUser = await _auth.currentUser;
      if (thisUser != null) {
        thisCurrentUser = thisUser;
        print(thisCurrentUser.email);
        final FirebaseDatabase database = FirebaseDatabase.instance;
        prayerRef = database.reference().child('prayer-items');
        userPrayerRef = database
            .reference()
            .child('Users')
            .child("${thisCurrentUser.uid}")
            .child("prayers");
        print("all good to go!");
      } else {
        print("this user is not in the database...");
      }
    } catch (error) {
      print(error);
    }
  }

  void handleSubmit() {
    final FormState form = _formKey.currentState;

    // Validate will return true if the form is valid, or false if
    // the form is invalid.

    if (form.validate()) {
      print("sendingToFirebase");
      form.save();
      form.reset();
      prayer.byUserName = thisCurrentUser.email;
      prayer.byUserUID = thisCurrentUser.uid;
      prayerRef.push().set(prayer.toJson());
      prayer.prayerPostDay = todaysDay;
      prayer.prayerPostMonth = todaysMonth;
      userPrayerRef.child("${prayer.prayerTitle}").set(prayer.toJson());
      print(thisUserToken);

      //notification
      firebaseMessagingBLOC.callOnFcmApiSendPushNotifications(
          "${thisCurrentUser.uid}",
          "/topics/prayerNotification",
          "TCI Prayer",
          "${thisCurrentUser.email} is in need of prayer.",
          "prayer");
      //--------------------

      Navigator.pop(context);
    }
  }

  void handleUpdate() {
    prayerRef.push().update((prayer.toJson()));
  }
  //-----------------------

  /*
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
   */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Container(
                    child: Image.asset(
                      "Assets/PrayerImage.png",
                      fit: BoxFit.fill,
                    ),
                  ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Submit A Prayer Request",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.border_color,
                            ),
                            labelText: "Title",
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onSaved: (value) {
                            prayer.key = value;
                            return prayer.prayerTitle = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.border_color,
                              ),
                              labelText: "Message",
                              labelStyle: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            onSaved: (value) {
                              return prayer.prayerMessage = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                      height: 20,
                    ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: FlatSecondaryMainButton(
                              text: "Submit",
                              onPressed: (){
                                handleSubmit();
                              },
                              
                            ),
                          )
                          
                          /*OutlineButton(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                            onPressed: () {
                              handleSubmit();
                            },

                            child: Center(child: Text('Submit')),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          */
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
