//import 'package:flutter_restaurant_backend_app/Globals/FirebaseSingleton.dart';
//import 'package:flutter_restaurant_backend_app/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Pages/Addresses/userAddressPage.dart';
//import 'package:flutter_restaurant_backend_app/Pages/Editors/ChangePasswordPage.dart';
//import 'package:flutter_restaurant_backend_app/Pages/Editors/PaymentsCardsPage.dart';
//import 'package:flutter_restaurant_backend_app/Widgets/MainButtonWidgets.dart';
//import 'package:flutter_restaurant_backend_app/Pages/Editors/EditProfilePage.dart';
//import 'package:flutter_restaurant_backend_app/Firebase/RestaurantDB.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Pages/Payments/UserPaymentMethods/UserPaymentMethods/UserPaymentMethodsPage.dart';
import 'package:flutter_church_app_2020/Widget/MainButtonWidgets.dart';
import 'package:flutter_church_app_2020/Pages/Profile/edit_profile_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_church_app_2020/Firebase/FCM/ChurchFirebaseMessagingBLOC.dart';

class ProfilePage extends StatefulWidget {
  static String id = "/profile";
  final ChurchUserModel thisUser;


  ProfilePage({this.thisUser});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ChurchDB churchDB;
  FirebaseAuth auth = AuthCentral.auth;
  FirebaseMessagingBLOC firebaseMessagingBLOC;

  //DatabaseReference userRef;
  ChurchUserModel thisUser;
  DatabaseReference userRef;

  bool appNotificationsBool = false;
  bool locationTrackingBool = false;

  /*
  checkPhone() {
    if (thisUser.phone != "") {
      return Column(
        children: [
          Text(
            "${thisUser.phone} ",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
   */

  handleUpdate(){

  }

  //for FCM Subscriptions
  void subscribeToPrayers() {
   firebaseMessagingBLOC.subscribeToPrayers();
  }

  void unsubscribeToPrayers() {
    firebaseMessagingBLOC.unsubscribeToPrayers();
  }

  void subscribeToPastoralBlog() {
    firebaseMessagingBLOC.subscribeToPastoralBlog();
  }

  void unsubscribeToPastoralBlog() {
    firebaseMessagingBLOC.unsubscribeToPastoralBlog();
  }


  checkImage() {

    if (thisUser.userImageUrl != "" && thisUser.userImageUrl != null) {
      return Image.network(
        "${thisUser.userImageUrl}",
        height: 175,
        width: 175,
        fit: BoxFit.cover,
      );
    } else {
      print("No image bub!");
      return Image.asset(
        "Assets/${"blankUserImage.png"}",
        height: 175,
        width: 175,
        fit: BoxFit.cover,
      );
    }
  }

   setupListeners() async {

    userRef.onChildChanged.listen(null).onData((event) {
      print("Data value: ${event.snapshot.key}");
      if(event.snapshot.key == "thisUserInfo"){
        checkAndSetChangedUserData(event: event).then((value) {
          ChurchUserModel thisNewUser = value;
          print("Final New User data: ${thisNewUser.userLastName}");
          setState(() {
            thisUser = thisNewUser;
          });
        });
      }
    });
  }


  Future checkAndSetChangedUserData({Event event}) async{

    print("getting new data..");

    ChurchUserModel thisUser;

    var thisCurrentUser = ChurchUserModel.fromSnapshot(event.snapshot);

    print(thisCurrentUser.userLastName);
    if (thisCurrentUser.userName != null) {
      thisUser = thisCurrentUser;
      print("user is not null");
    }else{
      print("There is no data");
    }
    print("This user is: ${thisUser.userLastName}");
    return thisUser;
  }


  @override
  void initState() {
    // TODO: implement initState

    thisUser = widget.thisUser;
    firebaseMessagingBLOC = FirebaseMessagingBLOC();

    userRef = FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(thisUser.userUID);//.child("thisUserInfo");

    setupListeners();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(30, 0, 0, 0),
                                    offset: Offset(1, 1),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.5)
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: CircleAvatar(
                                radius: 75,
                                backgroundColor: Colors.white,
                                child: checkImage(),
                              //backgroundImage: Image.asset(thisUser.imageUrl),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 20,
                        ),
                        //profile quick actions

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${thisUser.userFirstName} ${thisUser.userLastName}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${thisUser.userEmail}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10,),
                              //checkPhone(),
                              EditButton(
                                text: "Edit",
                                onPressed: () async{
                                  print("Im editing!");
                                  var unwind = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EditProfilePage(
                                          thisUser: thisUser,
                                        );
                                      },
                                    ),
                                  );
                                  if (unwind == true){
                                    Navigator.pop(context, true);
                                  }
                                  if (unwind == "reload"){
                                    setState(() {
                                      thisUser = thisUser;
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 40.0, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, left: 20, right: 20, bottom: 20),
                              child: Container(
                                height: 150,
                                child: Column(
                                  children: [

                                    GestureDetector(
                                      onTap: () {
                                        print("Push to Change Password");
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return Container();//ChangePasswordPage();
                                              },
                                            ));

                                        //Navigator.pushNamed(context, ChangePasswordPage.id);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text("Change Password")),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("Push to User Address");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return UserAddressPage(
                                                thisUser: thisUser
                                                );
                                            },
                                          ),
                                        );
                                        //Navigator.pushNamed(context, DeliveryAddressPage.id);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text("Delivery Address")),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("Push to Payment");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return UserPaymentMethodsPage(
                                              thisUser: thisUser,
                                              );
                                            }
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text("Payments")),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Notifications Section
                        SizedBox(height: 40),

                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 20, right: 20, bottom: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("App Notifications"),
                                      CupertinoSwitch(
                                        value: thisUser.mainNotification,//set userNotifications thisInternalUser.mainNotification,
                                        onChanged: (bool newValue) {
                                          //setState(() {
                                            //thisInternalUser.mainNotification = newValue;
                                            //print(thisInternalUser.mainNotification);
                                            //handleUpdate();
                                          //});
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Divider(
                                    height: 1,
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Social Notifications"),
                                      CupertinoSwitch(
                                        value: thisUser.socialNotification,
                                        onChanged: (bool newValue) {
                                          //setState(() {
                                            //thisInternalUser.socialNotification = newValue;
                                            //print(thisInternalUser.socialNotification);
                                            //handleUpdate();
                                          //});
                                        },
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Divider(
                                    height: 1,
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Prayer Notifications"),
                                      CupertinoSwitch(
                                        value: thisUser.prayerNotification,
                                        onChanged: (bool newValue) {

                                          setState(() {
                                            thisUser.prayerNotification = newValue;
                                            print(thisUser.prayerNotification);
                                            if (thisUser.prayerNotification ==
                                                true) {
                                              this.subscribeToPrayers();
                                            } else {
                                              this.unsubscribeToPrayers();
                                            }

                                            handleUpdate();
                                          });
                                        },
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Other Section
                        SizedBox(height: 40),

                        Text(
                          "Other",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 20, right: 20, bottom: 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Push to Terms of Service");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text("Terms of Service")),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Push to Privacy Policy");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text("Privacy Policy")),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Push to Language");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text("Language")),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Push to Currency");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text("Currency")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
