import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
//import 'package:flutter_restaurant_backend_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Widgets/FloatingCardWidget.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
//import 'flutter_church_app_2020/Widgets/GetPictureWidget.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:flutter_church_app_2020/Globals/GlobalVariables.dart';
//import 'package:flutter_church_app_2020/Widgets/DialogueWidgets.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
import 'package:flutter_restaurant_app/Widgets/DialogueWidgets.dart';
import 'package:flutter_restaurant_app/Pages/Signup/SignupBLOC.dart';
import 'package:flutter_restaurant_app/Widgets/GetPictureWidget.dart';


class EditProfilePage extends StatefulWidget {
  static String id = "/editprofile";

  final UserModel thisUser;
  final VoidCallback onSignOut;
  EditProfilePage({this.thisUser, this.onSignOut});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with TickerProviderStateMixin {

  RestaurantDB restaurantDB;
  SignupBLOC signupBLOC;

  UserModel thisUser;

  bool appNotificationsBool = false;
  bool locationTrackingBool = false;

  bool profilePictureSelected = false;
  Color pictureDialogueColor = Color.fromARGB(100, 0, 0, 0);

  //Files
  File pictureImage;

  bool imageHasChanged = false;

// for the form
  final _formKey = GlobalKey<FormState>();

  void handleSubmit() async {
    final FormState form = _formKey.currentState;

    // Validate will return true if the form is valid, or false if
    // the form is invalid.

    if (form.validate()) {
      form.save();
      form.reset();
      // put data below form.save


      await restaurantDB.launchUsersPath(
          context: context,
          userModel: thisUser,
          imageHasChanged: imageHasChanged,
          actionToDo: "update"
      );

      //churchDB.launchUserImagePath(context, thisUser, "update");


      startProfileUpdatedAnimation();
    }
  }
  //-------------


  checkImage(File image, UserModel thisImageUser) {

    return signupBLOC.checkNewImage(image, thisImageUser);
  }

  //Futures
  takePicture() async {
    var image = await signupBLOC.takePicture();

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        // Here you can write your code for open new view
        pictureImage = File(image.path);
        thisUser.imageUrl = image.path;

        imageHasChanged = true;

        endProfileImageAnimation();
      });
    });
  }


  getPictureFromGallery() async {
    var image = await signupBLOC.getPictureFromGallery();

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        //set location for image
        //#1
        pictureImage = File(image.path);
        //#2
        thisUser.imageUrl = image.path;

        print("Final image: $pictureImage, userImage: ${thisUser.imageUrl}");

        imageHasChanged = true;

        endProfileImageAnimation();
      });
    });
  }

  //------------------


  removeUser(VoidCallback onSignOut) {
    setState(() {
      print("This user is : ${thisUser.email}");
      Navigator.pop(context, true);
    });
  }




  //Animations

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    restaurantDB = RestaurantDB();
    signupBLOC = SignupBLOC();
    thisUser = widget.thisUser;



    print("This user image: ${thisUser.imageUrl}");



    // set the controller from GlobalAnimations chart
    profileUpdatedAlertAnimationController = alertController(
        duration: Duration(seconds: 1), thisClass: this); //required

    // set the controller from GlobalAnimations chart
    deleteUserAlertAnimationController = alertController(
        duration: Duration(seconds: 1), thisClass: this); //required

    // set the controller from GlobalAnimations chart
    profileImageAlertAnimationController = alertController(
        duration: Duration(seconds: 1), thisClass: this); //required

    // set the profile update alertAnimation from GlobalAnimations chart
    profileUpdatedAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: profileUpdatedAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    profileUpdatedAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: profileUpdatedAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    // set the delete alertAnimation from GlobalAnimations chart
    deleteUserAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: deleteUserAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    deleteUserAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: deleteUserAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    // set the profile image alertAnimation from GlobalAnimations chart
    profileImageAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: profileImageAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    profileImageAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: profileImageAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

  }





  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    profileUpdatedAlertAnimationController.dispose();
    deleteUserAlertAnimationController.dispose();
    profileImageAlertAnimationController.dispose();
  }





  //------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListView(
              children: [
                Container(
                  //color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 12),
                        child: Row(
                          children: [
                            Text(
                              "Edit Profile",
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
                            GestureDetector(
                              child: Container(
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
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                          radius: 75,
                                          backgroundColor: Colors.white,
                                          child: checkImage(pictureImage, thisUser)
                                        //backgroundImage: Image.asset(thisUser.imageUrl),
                                      ),
                                      Container(
                                        height: 150,
                                        width: 150,
                                        color: Color.fromARGB(100, 0, 0, 0),
                                        child: Center(
                                          child: Text(
                                            "Click to Edit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  profilePictureSelected = true;
                                });
                                startProfileImageAnimation();
                              },
                            ),

                            SizedBox(
                              width: 20,
                            ),
                            //profile quick actions

                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // put icons here to use in action
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 12, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter New User Info",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: FloatingCardWidget(
                                color: Colors.white,
                                widget: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 20,
                                      right: 20,
                                      bottom: 20),
                                  child: Container(
                                    //height: 200,
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText:
                                              "First Name: ${thisUser.firstName}",
                                              labelStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            onSaved: (value) {
                                              setState(() {
                                                if (value.isNotEmpty) {
                                                  thisUser.firstName = value;
                                                }
                                              });
                                              //print(thisUser.firstName);
                                              return null;
                                            },
                                            /*validator: (value) {
                                              if (value.isEmpty) {
                                                value = thisUser.firstName;
                                                thisUser.firstName = value;
                                              }
                                              return null;
                                            },
                                             */
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText:
                                              "Last Name: ${thisUser.lastName}",
                                              labelStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            onSaved: (value) {
                                              setState(() {
                                                if (value.isNotEmpty) {
                                                  thisUser.lastName = value;
                                                }
                                              });
                                              //print(thisCard.lastName);
                                              return null;
                                            },
                                            /*validator: (value) {
                                              if (value.isEmpty) {
                                                value = thisUser.lastName;
                                                thisUser.lastName = value;
                                              }
                                              return null;
                                            },
                                             */
                                          ),
                                          /*TextFormField(
                                            decoration: InputDecoration(
                                              labelText:
                                              "Phone: ${thisUser.phone}",
                                              labelStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            onSaved: (value) {
                                              setState(() {
                                                if (value.isNotEmpty) {
                                                  thisUser.phone = value;
                                                }
                                              });
                                              //print(thisCard.lastName);
                                              return null;
                                            },
                                            /*validator: (value) {
                                              if (value.isEmpty) {
                                                value = thisUser.phone;
                                                thisUser.phone = value;
                                              }
                                              return null;
                                            },
                                             */
                                          ),

                                           */


                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText:
                                              "Email: ${thisUser.email}",
                                              labelStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            onSaved: (value) {
                                              setState(() {
                                                if (value.isNotEmpty) {
                                                  thisUser.email = value;
                                                }
                                              });
                                              //print(thisCard.lastName);
                                              return null;
                                            },
                                            /*validator: (value) {
                                              if (value.isEmpty) {
                                                value = thisUser.email;
                                                thisUser.email = value;
                                              }
                                              return null;
                                            },
                                             */
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            Center(
                              child: MainButtonWidget(
                                text: "Confirm",
                                onPressed: () {
                                  setState(() {
                                    print("profile updated!");
                                    handleSubmit();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: DeleteButton(
                                text: "Delete This User",
                                icon: Icons.delete,
                                onPressed: () {
                                  print("Im Deleting!");
                                  setState(() {
                                    //isRemovingUser = true;
                                  });
                                  //print(isRemovingUser);
                                  startDeleteUserAnimation();
                                },
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

          //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
          SlideTransition(
            position: profileUpdatedAlertBackgroundAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 0, 0, 0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      offset: Offset(1, 1),
                      blurRadius: 10.0,
                      spreadRadius: 0.5)
                ],
              ),
            ),
          ),

          SlideTransition(
            position: profileUpdatedAlertAnimation,
            child: ProfileUpdatedWidget(
              title: "Profile Updated",
              subtitle: "Your profile has been updated!",
              actionOne: () {
                endProfileUpdatedAnimation(context);
              },
            ),
          ),

          // for deleting a user profile
          SlideTransition(
            position: deleteUserAlertBackgroundAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 0, 0, 0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      offset: Offset(1, 1),
                      blurRadius: 10.0,
                      spreadRadius: 0.5)
                ],
              ),
            ),
          ),

          SlideTransition(
            position: deleteUserAlertAnimation,
            child: DeleteUserWidget(
              title: "Remove Account",
              subtitle: "Are you sure you want to remove this account?",
              actionOne: () {
                endDeleteUserAnimation(context);
                setState(() {
                  //isRemovingUser = false;
                });
                removeUser(widget.onSignOut);
              },
              actionTwo: () {
                setState(() {
                  //isRemovingUser = false;
                });
                cancelDeleteUserAnimation();
              },
            ),
          ),

          // for profile Image
          SlideTransition(
            position: profileImageAlertBackgroundAnimation,
            child: GestureDetector(
              onTap: () {
                endProfileImageAnimation();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 0, 0, 0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(30, 0, 0, 0),
                        offset: Offset(1, 1),
                        blurRadius: 10.0,
                        spreadRadius: 0.5)
                  ],
                ),
              ),
            ),
          ),

          SlideTransition(
            position: profileImageAlertAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(30, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 10.0,
                          spreadRadius: 0.5)
                    ],
                  ),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetPictureWidget(
                                text: "Take A Picture",
                                icon: Icons.camera_alt,
                                action: () {
                                  // use camera to take the picture
                                  print("Take A Picture");
                                  takePicture();
                                },
                              ),
                              GetPictureWidget(
                                text: "From Gallery",
                                icon: Icons.photo_size_select_actual,
                                action: () {
                                  // use camera to get picture from gallery
                                  print("Choose A Photo");
                                  getPictureFromGallery();
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CancelButton(
                              text: "Cancel",
                              onPressed: () {
                                setState(() {
                                  profilePictureSelected = false;
                                });
                                endProfileImageAnimation();
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
