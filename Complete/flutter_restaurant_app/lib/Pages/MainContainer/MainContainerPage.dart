import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Pages/Home/HomePage.dart';
import 'package:flutter_restaurant_app/Pages/Menu/MenuPage/MenuPage.dart';
import 'package:flutter_restaurant_app/Pages/OrderHistory/OrderHistoryPage/OrderHistoryPage.dart';
import 'package:flutter_restaurant_app/Pages/Profile/ProfilePage.dart';
import 'package:flutter_restaurant_app/Widgets/DialogueWidgets.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:flutter_restaurant_app/Pages/Cart/CartPage.dart';
import 'package:flutter_restaurant_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_restaurant_app/Pages/MainContainer/MainContainerBLOC.dart';
import 'package:flutter_restaurant_app/Firebase/FCM/FirebaseMessagingBLOC.dart';

class MainContainerPage extends StatefulWidget {
  static String id = "mainContainer";
  final pageIndex;
  final AuthCentral auth;
  final VoidCallback onSignOut;

  MainContainerPage({this.pageIndex, this.auth, this.onSignOut});

  @override
  _MainContainerPageState createState() => _MainContainerPageState();
}

class _MainContainerPageState extends State<MainContainerPage> with SingleTickerProviderStateMixin {

  FirebaseAuth _auth;
  DatabaseReference userRef;

  // Models
  MainContainerBLOC mainContainerBLOC;
  FirebaseMessagingBLOC firebaseMessagingBLOC;
  User thisCurrentUser; // used to check current user status
  UserModel thisUser; // used to retain user data

  //------------------

  //finals
  final FirebaseDatabase database = FirebaseDatabase.instance;


  //ints
  int _currentIndex;


  //Colors
  Color tabColor;


  //functions
  setPage(){
    List<Widget> _children = [
      //HomePage(),
      MenuPage(
        menuAction: onTabTapped,
      ),
      CartPage(
        menuAction: onTabTapped,
      ),
      ProfilePage(thisUser: thisUser,),
      OrderHistoryPage()
    ];
    return _children[_currentIndex];
  }


  switchIndex(int pageIndex){
    if (pageIndex == null){
      _currentIndex = 0;
    }else{
      _currentIndex = pageIndex;
    }
  }

  logOut(){
    endSignOutAnimation(context).then((value)async{
      print(isLoggingOut);
      try {
        await _auth.signOut();
        widget.onSignOut();
      } catch (error) {
        print(error);
      }
    });
  }


  //Voids
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



  checkAndSetUserData({Event event}){

    //the user data
    thisUser = mainContainerBLOC.checkAndSetUserData(event: event);
    _saveDeviceToken(thisUser);

    print("Final User data is: ${thisUser.userName}");

  }

  checkAndSetChangedUserData({Event event}){

    UserModel thisUser;
    var thisCurrentUser = UserModel.fromSnapshot(event.snapshot);

    if (thisCurrentUser.userName != null) {

      thisUser = thisCurrentUser;
      print("This logged in user uid: ${thisUser.uid}");
      //print("Admin onboarding admin: ${thisCurrentUser.isViewedProfileOnboarding}");
    }
    return thisUser;
  }




  // gets a device token
  _saveDeviceToken(UserModel userModel) async {
    setState(() {
      firebaseMessagingBLOC.saveDeviceToken(userModel);
    });
  }


  void checkLogedInUser() async {

    mainContainerBLOC.checkLogedInUser().then((thisUser) {
      thisCurrentUser = thisUser;

      //set references
      setUserRef(thisCurrentUser);
      //setNewUser to stripe
    });
  }

  setUserRef(User thisCurrentUser){

    userRef = database
        .reference()
        .child('users')
        .child(thisCurrentUser.uid);


    userRef.onChildAdded.listen((event) {
      print("Data value: ${event.snapshot.key}");
      if(event.snapshot.key == "thisUserInfo"){
        checkAndSetUserData(event: event);
      }
    });

    userRef.onChildChanged.listen(null).onData((event) {
      checkAndSetChangedUserData(event: event);
    });
  }

  //--------------- For FCM ---------------------

  //for the setup
  setupNotifications() {
    FirebaseMessagingBLOC().setupNotifications();
  }


  //to configure the FCM
  configureFCM() {
    FirebaseMessagingBLOC().configureFCM(context, thisCurrentUser);
  }

  //------------------------------




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //setup the current User
    //firebaseUserSingleton.sharedInstance.getCurrentUser();

    _auth = AuthCentral.auth;
    mainContainerBLOC = MainContainerBLOC();
    firebaseMessagingBLOC = FirebaseMessagingBLOC();

    checkLogedInUser();

    //set the page tab
    switchIndex(widget.pageIndex);

    //FCM
    setupNotifications();

    configureFCM();

    //setting the sign out animation controller
    signoutAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    );

    signoutAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        signoutAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );


    signoutAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        signoutAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose

    if (isLoggingOut == true) {
      signoutAlertAnimationController.dispose();
      print("has disposed of sign out animation Controller");
    }

    isLoggingOut = false;

    super.dispose();
  }
  
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(

        title: Text(
          "Restaurant App",
          style: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.italic
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              setState(() {
                isLoggingOut = true;
                startSignOutAnimation();
              });
            },
          ),
        ],
      ),


      body: Stack(
        children: [
          setPage(),
          //_children[_currentIndex],

          SlideTransition(
            position: signoutAlertBackgroundAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 0, 0, 0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      offset: Offset(1, 1),
                      blurRadius: 10.0,
                      spreadRadius: 0.5                          )
                ],
              ),
            ),
          ),

          SlideTransition(
            position: signoutAlertAnimation,
            child: LogoutWidget(
                title: "Logging Out",
                subtitle: "Are you sure you want to log out?",
                actionOne: (){
                  logOut();
                },
                actionTwo: (){
                  setState(() {
                    isLoggingOut = false;
                    cancelSignOutAnimation(context);
                  });
                }
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          /*
          BottomNavigationBarItem(
            icon: new Icon(Icons.home,
              color: Theme.of(context).primaryColor,),
            title: new Text('Home',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),

           */
          BottomNavigationBarItem(
            icon: new Icon(Icons.restaurant_menu,
              color: Theme.of(context).primaryColor,),
            title: new Text('Menu',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.shopping_cart,
              color: Theme.of(context).primaryColor,),
            title: new Text('Cart',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person,
              color: Theme.of(context).primaryColor,),
            title: new Text('Profile',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.history,
              color: Theme.of(context).primaryColor,),
            title: new Text('Order History',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}


