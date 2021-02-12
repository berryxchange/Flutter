import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_church_app_2020/Models/PrayerModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Pages/PrayerPage/AddPrayerPage.dart';
import 'package:flutter_church_app_2020/Pages/PrayerPage/PrayerDetailPage.dart';
import 'package:flutter_church_app_2020/Pages/Onboarding/OnboardingPage.dart';

class PrayerPage extends StatefulWidget {
  static String id = "prayer_page";
  final ChurchUserModel thisUser;

  PrayerPage({this.thisUser});

  @override
  _PrayerPageState createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  //instances
  DatabaseReference prayerRef;
  DatabaseReference userRef;
  //listeners
  var prayerRefLisener;
  var userRefLisener;


  //User thisCurrentUser;
  ChurchUserModel thisUser;

  final FirebaseDatabase database =
      FirebaseDatabase.instance; //FirebaseDatabase.instance;
  final _auth = FirebaseAuth.instance;
  //------------------

  //Statics
  static bool showSpinner = false;
  //------------------

  //variables
  Prayer prayer;
  List<Prayer> prayers = List();
  //------------------

  /*voids
  void getCurrentUser() async {
    try {
      final thisUser = await _auth.currentUser;
      if (thisUser != null) {
        thisCurrentUser = thisUser;
        print(thisCurrentUser.email);
        print(thisCurrentUser.uid);
        print("all good to go!");

        userRef =
            database.reference().child('users').child("${thisCurrentUser.uid}");
        userRef.onChildAdded.listen(_onUserEntryAdded);

        print("the userRef: $userRef");
      } else {
        print("this user is not in the database...");
      }
    } catch (error) {
      print("something went wrong: $error");
    }
  }
   */
  //------------------

  //initialization
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //getCurrentUser();
    thisUser = widget.thisUser;
    prayerRef = database.reference().child('prayer-items');
    prayerRefLisener = prayerRef.onChildAdded.listen(_onPrayerEntryAdded);
    //prayerRef.onChildChanged.listen(_onPrayerEntryChanged);
    //prayerRef.onChildRemoved.listen(_onPrayerChildRemoved);
  }
  //------------------

  //Listeners

  _onPrayerEntryAdded(Event event) {
    setState(() {
      prayers.add(Prayer.fromSnapshot(event.snapshot));
      print("${event.snapshot.value["prayerPostMessage"]}");
    });
  }

  _viewOnboardingPage() {
    //Navigator.pushNamed(context, OnboardingPage.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return OnboardingPage(
            kindOfOnboardingString: "prayer_page",
          );
        },
      ),
    );
  }

  _checkOnboarding() {
    print("checking onboarding");
    if (thisUser.isViewedPrayerOnboarding == null ||
        thisUser.isViewedPrayerOnboarding == false) {
      _viewOnboardingPage();
    } else {}
  }
  //------------------


  @override
  void dispose() {
    // TODO: implement dispose
    prayerRefLisener?.cancel();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer Wall"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.pages,
                size: 32.0,
              ),
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                  print("Spinning!");
                });

                _viewOnboardingPage();

                setState(() {
                  showSpinner = false;
                  print("done!");
                });
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print("adding prayer");
                Navigator.pushNamed(context, AddPrayerPage.id);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, top: 8.0),
        child: FirebaseAnimatedList(
          reverse: true,
          query: prayerRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            //int total = prayers[index].prayerPostAgreements;
            return PrayerTab(
              //total: total,
              prayer: prayers[index],
              thisUser: thisUser,
            );
          },
        ),
      ),
    );
  }
}

class PrayerTab extends StatelessWidget {
  final int total;
  final Function onTap;
  final Prayer prayer;

  final ChurchUserModel thisUser;

  PrayerTab({this.prayer, this.total, this.onTap, this.thisUser});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PrayerDetailPage(
            prayer: prayer,
            thisUser: thisUser,
          );
        }));
      },
      child: Card(
        child: Container(
          height: 75.0,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        prayer.prayerPostMonth,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: Text(
                        prayer.prayerPostDay,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        prayer.prayerTitle,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(prayer.byUserName),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
