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
      prayers.insert(0, Prayer.fromSnapshot(event.snapshot));
      //prayers.add(Prayer.fromSnapshot(event.snapshot));
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
              icon: Icon(Icons.add),
              onPressed: () {
                print("adding prayer");
                Navigator.pushNamed(context, AddPrayerPage.id);
              })
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, top: 8.0),
            child: FirebaseAnimatedList(
              reverse: false,
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
        ],
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(30, 0, 0, 0),
                    offset: Offset(1, 1),
                    blurRadius: 10.0,
                    spreadRadius: 0.5)
              ],
            ),
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                color: Colors.white,
                height: 75.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                prayer.prayerPostMonth,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              Text(prayer.prayerPostDay),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              prayer.prayerTitle,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [Text("By: ${prayer.byUserName}")],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
