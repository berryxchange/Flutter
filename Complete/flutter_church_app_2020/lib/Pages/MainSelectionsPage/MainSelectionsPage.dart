import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Models/SystemCheckModel.dart';
import 'package:flutter_church_app_2020/Models/bible_model.dart';
import 'package:flutter_church_app_2020/Pages/Bible/bible_page.dart';
import 'package:flutter_church_app_2020/Pages/MainSelectionsPage/MainSelctionsBLOC.dart';
import 'package:flutter_church_app_2020/Pages/Payments/TitheAndOffering/TitheAndOffering.dart';
import 'package:flutter_church_app_2020/Pages/PrayerPage/PrayerPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_church_app_2020/Pages/Profile/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_church_app_2020/Models/MinistryModel.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:flutter_church_app_2020/Pages/Onboarding/OnboardingPage.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:flutter_church_app_2020/Pages/Ministries/MinistriesBLOC.dart';
import 'package:flutter_church_app_2020/Firebase/FCM/ChurchFirebaseMessagingBLOC.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class MainSelectionsPage extends StatefulWidget {
  static String id = "main_page"; // page Id

  final AuthCentral auth;
  final VoidCallback onSignOut;

  MainSelectionsPage({this.auth, this.onSignOut}); // requirements

  @override
  _MainSelectionsPageState createState() {
    return _MainSelectionsPageState();
  }
}

class _MainSelectionsPageState extends State<MainSelectionsPage> {
  //Instances of DB References
  DatabaseReference userRef; // directory for users
  DatabaseReference prayerRef; // directory for prayer
  DatabaseReference prayerAgreementsRef; // directory for prayer agreements
  DatabaseReference ministryRef;
  DatabaseReference systemCheckRef;
  DatabaseReference bibleRef;
  //listeners
  var userOnAddedRefListener;
  var ministryOnAddedRefListener;
  var ministryOnChangedRefListener;
  var ministryOnRemovedRefListener;
  var systemCheckOnAddedRefListener;
  var systemCheckOnChangedRefListener;
  var systemCheckOnRemovedRefListener;
  
  
  //------------------

  //Auth
  FirebaseAuth _auth;
  //------------------

  // Models
  MinistryModel ministry;
  User thisCurrentUser; // used to check current user status
  ChurchUserModel thisUser; // used to retain user data
  //------------------

  //bools
  bool isAdmin = false;
  bool showSpinner = false;
  //------------------

  //Lists
  List<ChurchUserModel> listOfUsers = List();
  List<SystemCheckModel> systemChecks = List();
  List<MinistryModel> ministries = List();
  //------------------

  //finals

  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  //------------------

  //BLOCS
  MinistriesBLOC ministriesBLOC;
  MainSelectionsBLOC mainSelectionsBLOC;
  FirebaseMessagingBLOC firebaseMessagingBLOC;

  //voids

  //Check for authentic Users
  void _noAccountUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Account Error",
              textAlign: TextAlign.center,
            ),
            content: Text(
              "there is an error on your account, please re-signup",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Re-Signup"),
                onPressed: () {
                  _deleteUserData();
                  _logOut();
                },
              ),
            ],
          );
        });
  }


  _deleteUserData() {
    thisCurrentUser.delete();
  }

//----------------



  //for walkthrough
  _checkUserAccountForWalkthrough(ChurchUserModel user) {
    if (user == null) {
      print("no account found!");
      _noAccountUser();
    } else {
      print("found an account!");
      setState(() {
        showSpinner = true;
        print("Spinning!");
      });

      if (thisUser.userUID != null) {
        print("im not null!");
        if (thisUser.isViewedIntroOnboarding == true) {
          setState(() {
            showSpinner = false;
            print("done!");
          });
        } else {
          _viewIntroOnboardingPage();
          setState(() {
            showSpinner = false;
            print("done!");
          });
        }
      }
    }
  }

  //-----------



//preparing to setup
  Future checkLogedInUser() async {

    mainSelectionsBLOC.checkLogedInUser().then((thisUser) {
      thisCurrentUser = thisUser;

      //set references for the user  not for prayer page
      setUserRef(thisCurrentUser);
      setPrayerRef(thisCurrentUser);
      setPrayerAgreementRef(thisCurrentUser);
      //setNewUser to stripe
    });
    return thisCurrentUser;
  }

  setPrayerRef(User thisCurrentUser){
    prayerRef = database
        .reference()
        .child("Users")
        .child("${thisCurrentUser.uid}")
        .child("prayers");

  }

  setPrayerAgreementRef(User thisCurrentUser){
    prayerAgreementsRef = database
        .reference()
        .child("Users")
        .child("${thisCurrentUser.uid}")
        .child("prayerAgreements");

  }

  //------------------


  setUserRef(User thisCurrentUser){

    userRef = database
        .reference()
        .child('Users')
        .child(thisCurrentUser.uid);


    userOnAddedRefListener = userRef.onChildAdded.listen((event) {
      print("Data value: ${event.snapshot.key}");
      if(event.snapshot.key == "thisUserInfo"){
        checkAndSetUserData(event: event);
      }
    });

   userRef.onChildChanged.listen(null).onData((event) {
      checkAndSetChangedUserData(event: event);
    });
  }


  checkAndSetUserData({Event event}){

    //the user data
      thisUser = mainSelectionsBLOC.checkAndSetUserData(event: event);

     //gets a token for this device and stores it for the user
     // when the user logs in.
     isAdmin = thisUser.isAdmin;

     if (thisUser.isAdmin != null || thisUser.isAdmin != false){
       print("Setting up user admin data");
       isAdmin = thisUser.isAdmin;

       runSystemChecks();

       _saveDeviceToken(thisUser);

       print("This user notifications: ${thisUser.mainNotification}");

     }else{
       _saveDeviceToken(thisUser);
       print("no admin present");
       FirebaseMessagingBLOC().configureFCM(context, thisUser);
     }
     print("Final User data is: ${thisUser.userName}");
     setListeners();
  }

  setListeners(){
    //systemChecks
    systemCheckOnAddedRefListener = systemCheckRef.onChildAdded.listen(_onSystemChecksAdded);
    systemCheckOnChangedRefListener = systemCheckRef.onChildChanged.listen(_onSystemChecksChanged);
    systemCheckOnRemovedRefListener = systemCheckRef.onChildRemoved.listen(_onSystemChecksRemoved);
    //Ministries
    ministryOnAddedRefListener = ministryRef.onChildAdded.listen(_onMinistryEntryAdded);
    ministryOnChangedRefListener = ministryRef.onChildChanged.listen(_onMinistryEntryChanged);
    ministryOnRemovedRefListener = ministryRef.onChildRemoved.listen(_onMinistryChildRemoved);
  }




  checkAndSetChangedUserData({Event event}){

    ChurchUserModel thisUser;
    var thisCurrentUser = ChurchUserModel.fromSnapshot(event.snapshot);

    if (thisCurrentUser.userName != null) {

      checkIfDataIsDifferent(thisCurrentUser);
      thisUser = thisCurrentUser;
      print("Admin onboarding admin: ${thisCurrentUser.isViewedProfileOnboarding}");
    }
    return thisUser;
  }


  checkIfDataIsDifferent(ChurchUserModel thisCurrentUser){
    if (isAdmin != thisCurrentUser.isAdmin) {
      print("something important in data has changed, will sign out for security");
      //sign out
      requestUserReset();
    } else {
      print("data is no different");
    }
  }


  requestUserReset() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return setAlertDialogue();
        });
  }

  AlertDialog setAlertDialogue(){
    return AlertDialog(
      title: Text(
        "Church App Dialog",
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Your administrative clearance has changed, please re-login",
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
            _logOutForAdminChanges();
          },
        )
      ],
    );
  }
  //----------------



  //Selecting a tab
  _checkUserAccountForList(ChurchUserModel user, index) {
    if (user == null) {
      print("no account found!");
      _noAccountUser();
    } else {
      print("found an account!");
      switch (ministries[index].ministryName) {
        case "Pastoral Page":
          print(thisUser.userEmail);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Container();
            },
          ));
          break;
        case "Tithes And Offering":
          print("is Tithes and offering");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return
                TitheAndOffering(
                  thisUser: thisUser,
                );
            },
          ));
          break;
        case "Prayer":
          print("is Prayer");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return
                PrayerPage(
                  thisUser: thisUser,
                );
            },
          ));
          break;
        case "Bible":
          print("is Bible");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return
                BiblePage();
            },
          ));

          break;
        default:
          Navigator.pushNamed(context, ministries[index].ministryDestination);
      }
    }
  }
  //----------------


  //When selecting profile button
  _checkUserAccountForProfile(ChurchUserModel user, VoidCallback onSignOut) async {
    if (user == null) {
      print("no account found!");
      _noAccountUser();
    } else {
      print("found an account!");
      if (user.userUID != null) {
        print("im not null!");

        var unwind = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProfilePage(
                  thisUser: thisUser
              );
            },
          ),
        );

        if (unwind == true){
          widget.onSignOut();
        }
      }
    }
  }
//-----------------


  //--------------- For FCM ---------------------

  //for the setup
  setupNotifications() {
    FirebaseMessagingBLOC().setupNotifications();
  }


  //to configure the FCM
  configureFCM() {
    checkLogedInUser();
  }

  //------------------------------



  //Initializer
  @override
  void initState() {
    //print(myPrayerAgreements.length);
    super.initState();

    //Admin
    //get all system checks

    //ministriesBLOC.setAllMinistries(context);
    //ministriesBLOC.setAllMinistryChecks(context);


    ministriesBLOC = MinistriesBLOC();
    mainSelectionsBLOC = MainSelectionsBLOC();
    _auth = AuthCentral.auth;
    firebaseMessagingBLOC = FirebaseMessagingBLOC();


    //Listeners
    //systemCheck
    systemCheckRef = FirebaseDatabase.instance.reference()
        .child('SystemChecks')
        .child("AllMinistriesToCheck");

    ministryRef = FirebaseDatabase.instance.reference()
        .child('SystemChecks')
        .child("AllMinistriesToLoad");
    
    bibleRef = FirebaseDatabase.instance.reference()
        .child("Bibles");


    //presetups
    //set specific ministries(ministriesBLOC.setAllMinistries or ministriesBLOC.setAdminMinistry )
    //ministriesBLOC.setAllMinistryChecks(context);

    /*setup Bibles
    var amplified = bibleRef.child("AMP");
    var amplifiedBible = Bible("Amplified Bible", "https://www.bible.com/bible/1588/GEN.1.AMP");
    amplified.update(amplifiedBible.toJson());

    var kingJames = bibleRef.child("KJV");
    var kingJamesBible = Bible("King James Version", "https://www.bible.com/bible/1/GEN.1.KJV");
    kingJames.update(kingJamesBible.toJson());

    var kingJamesWithApocrypha = bibleRef.child("KJVA");
    var kingJamesBibleWithApocrypha = Bible("King James Version With Apocrypha", "https://www.bible.com/bible/546/GEN.1.KJVA");
    kingJamesWithApocrypha.update(kingJamesBibleWithApocrypha.toJson());
     */

    //guard app from unwanted users or old users

    //FCM
    setupNotifications();

    configureFCM();

  }
  //------------------

  //functions

  runSystemChecks(){
    mainSelectionsBLOC.runSystemChecks(context, systemChecks);
  }





  //functions

  //for loging out
  void _showThisDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Church App Dialog",
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Are sure you want to log out?",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  _logOut();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _logOut() async {
    try {
      await _auth.signOut();
      widget.onSignOut();
    } catch (error) {
      print(error);
    }
  }

  _logOutForAdminChanges() async {
    try {
      await _auth.signOut();
      widget.onSignOut();
    } catch (error) {
      print(error);
    }
  }


  // gets a device token
  _saveDeviceToken(ChurchUserModel userModel) async {
    setState(() {
      firebaseMessagingBLOC.saveDeviceToken(userModel);
    });
  }



  _viewIntroOnboardingPage() {
    //Navigator.pushNamed(context, OnboardingPage.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return OnboardingPage(
            kindOfOnboardingString: "main_page",
          );
        },
      ),
    );
  }

  //listeners

  //SystemChecks
  _onMinistryEntryAdded(Event event) {
    print("the current user from ministry: $thisUser.userUID");

    if (isAdmin == true) {
      print("setting ministries for admin");
      setState(() {
        ministries.add(MinistryModel.fromSnapshot(event.snapshot));
      });
      print(ministries);
    }

    if (isAdmin == false) {
      //not an admin
      print("setting ministries for non-admin");
      if (event.snapshot.key == "Administrator") {
        print("this is an administrator item and cannot be used here");
      } else {
        setState(() {
          ministries.add(MinistryModel.fromSnapshot(event.snapshot));
        });
        print(ministries);
      }
    }
  }


  _onMinistryEntryChanged(Event event) {
    var old = ministries.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      ministries[ministries.indexOf(old)] = MinistryModel.fromSnapshot(event.snapshot);
    });

  }


  _onMinistryChildRemoved(Event event) {
    var old = ministries.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    //ministries[ministries.indexOf(old)] = Ministry.fromSnapshot(event.snapshot);
    setState(() {
      ministries.removeAt(ministries.indexOf(old));
    });

  }


  //Ministries

  _onSystemChecksAdded(Event event) {
    print("setting getting checks for User");
    setState(() {
      systemChecks.add(SystemCheckModel.fromSnapshot(event.snapshot));
    });
  }


  _onSystemChecksChanged(Event event) {
    var old = systemChecks.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      systemChecks[systemChecks.indexOf(old)] = SystemCheckModel.fromSnapshot(event.snapshot);
    });
    runSystemChecks();
  }


  _onSystemChecksRemoved(Event event) {
    var old = systemChecks.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    //ministries[ministries.indexOf(old)] = Ministry.fromSnapshot(event.snapshot);
    setState(() {
      systemChecks.removeAt(systemChecks.indexOf(old));
    });
    runSystemChecks();
  }

  //------------------


  
  @override
  void dispose() {
    // TODO: implement dispose
    userOnAddedRefListener?.cancel();
    ministryOnAddedRefListener?.cancel();
    ministryOnChangedRefListener?.cancel();
    ministryOnRemovedRefListener?.cancel();
    systemCheckOnAddedRefListener?.cancel();
    systemCheckOnChangedRefListener?.cancel();
    systemCheckOnRemovedRefListener?.cancel();
    super.dispose();
  }
   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Church Name"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.pages,
                size: 32.0,
              ),
              onPressed: () async {
                //_viewIntroOnboardingPage();
              }),
          Center(
            child: IconButton(
                icon: Icon(
                  Icons.person,
                  size: 32.0,
                ),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                    print("Spinning!");
                  });

                  _checkUserAccountForProfile(thisUser, widget.onSignOut);
                  setState(() {
                    showSpinner = false;
                    print("done!");
                  });
                }),
          ),
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 32.0,
              ),
              onPressed: () {
                _showThisDialog();
              }),
        ],
      ),
      body: SafeArea(
          child: Container(
              color: Colors.grey[200],
              //height: 200.0,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      //width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: MediaQuery.of(context).size.height / 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 15.0),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            showSpinner = true;

                            _checkUserAccountForList(thisUser, index);

                            showSpinner = false;
                          },
                          child: Card(
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      child: Image.asset(
                                        ministries[index].ministryImage,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Text(
                                    ministries[index].ministryName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 32.0, fontFamily: "Futura"),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    ministries[index].ministrySubtitle,
                                    style: TextStyle(
                                        fontSize: 18.0, fontFamily: "Futura"),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )));
                },
                itemCount: ministries.length,
                viewportFraction: 0.8,
                scale: 0.9,
                controller: SwiperController(),
                containerHeight: 400,
                pagination: SwiperPagination(),
                loop: false,
              )
          )
      ),
    );
  }
}
