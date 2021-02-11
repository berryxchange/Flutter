//for photo
import 'dart:io';
/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

 */
//--------
import 'package:flutter_restaurant_app/Pages/MainContainer/MainContainerPage.dart';
import 'package:flutter_restaurant_app/Pages/PrivacyPolicy.dart';
import 'package:flutter_restaurant_app/Pages/Root/RootPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Pages/Signup/SignupBLOC.dart';
import 'package:flutter_restaurant_app/Pages/TermsOfUsePage.dart';
import 'package:image_picker/image_picker.dart';

//firebase
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';

//Visuals
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:flutter_restaurant_app/Widgets/ImageDialogueWidget.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/FloatingCardWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class SignupPage extends StatefulWidget {
  static String id = "registration_screen";

  final AuthCentral auth;
  //final VoidCallback onSignedUp;
  //final VoidCallback onSignIn;

  SignupPage({this.auth});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with TickerProviderStateMixin {
  //Instances
  UserModel thisUser;
  SignupBLOC signupBLOC;

//------------------

  //Working With Image
  File _image;
  //final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  bool imageHasChanged = false;

  checkImage(File image, UserModel thisImageUser) {

    return signupBLOC.checkImage(image, thisImageUser);
  }


  //Futures
  takePicture() async {
    var image = await signupBLOC.takePicture();

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        // Here you can write your code for open new view
        _image = File(image.path);
        thisUser.imageUrl = image.path;
        imageHasChanged = true;
        endSignupImageAnimation();
      });
    });
  }


  getPictureFromGallery() async {
   var image = await signupBLOC.getPictureFromGallery();

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        //set location for image
        //#1
        _image = File(image.path);
        //#2
        thisUser.imageUrl = image.path;

        print("Final image: $_image, userImage: ${thisUser.imageUrl}");
        imageHasChanged = true;
        endSignupImageAnimation();
      });
    });
  }

  //------------------


  //Working With Form
  final _formKey = GlobalKey<FormState>();
  //------------------

  //Commands
  submitToFB() async{
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      print("sendingToFirebase");
      form.save();
      form.reset();

      signupBLOC.submitToFB(context: context, thisUser: thisUser, imageHasChanged: imageHasChanged).then((isSignedIn) {
        if (isSignedIn == true){
          Navigator.pop(context, true);
          //widget.onSignedUp();
        }
      });
    }
  }

  signIn(){
    Navigator.pop(context);
  }
  //------------------

  //functions
  _launchPrivacyURL() async {
    const url = 'https://www.berryxchange.org/privacy-policy/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  //------------------

  //initialization
  @override
  void initState() {
    thisUser = UserModel();
    signupBLOC = SignupBLOC();

    final FirebaseDatabase database = FirebaseDatabase.instance;

    //Animation
    // set the controller from GlobalAnimations chart
    signupImageAlertAnimationController = alertController(
        duration: Duration(seconds: 1), thisClass: this); //required

    // set the profile image alertAnimation from GlobalAnimations chart
    signupImageAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: signupImageAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    signupImageAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: signupImageAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    signupImageAlertAnimationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  //------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey),
      ),

       */
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
            child: ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12.0, bottom: 30, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                          child: checkImage(_image, thisUser)
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
                                startSignupImageAnimation();
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10),
                        child: FloatingCardWidget(
                          color: Colors.white,
                          widget: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      //prefixIcon: Icon(
                                      //Icons.border_color,
                                      //),
                                      labelText: "First Name",
                                      labelStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onSaved: (value) {
                                      thisUser.firstName = value;
                                      return thisUser.firstName = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        //prefixIcon: Icon(
                                        //Icons.border_color,
                                        //),
                                        labelText: "Last Name",
                                        labelStyle: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      onSaved: (value) {
                                        thisUser.lastName = value;
                                        return thisUser.lastName = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        //prefixIcon: Icon(
                                        //Icons.border_color,
                                        //),
                                        labelText: "Email",
                                        labelStyle: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      onSaved: (value) {
                                        thisUser.email = value;
                                        thisUser.userName = value;
                                        return thisUser.email = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        //prefixIcon: Icon(
                                        //Icons.border_color,
                                        //),
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      onSaved: (value) {
                                        thisUser.password = value;
                                        return thisUser.password = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MainButtonWidget(
                        text: "Sign Up",
                        onPressed: () {
                          submitToFB();
                          //Navigator.of(context).pushNamed(MainContainerPage.id);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do you have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          FlatButton(
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              signIn();
                              //Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlatSecondaryMainButton(
                        text: "Sign In with Google",
                        icon: MdiIcons.google,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(MainContainerPage.id);
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Container(
                          child: Column(
                            children: [
                              Text("By signing up, you agree to the"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                FlatButton(
                                    onPressed: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return TermsOfUsePage();
                                            },
                                          )
                                      );
                                    },
                                    child: Text("Terms of Use",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                                  FlatButton(
                                      onPressed: (){
                                        _launchPrivacyURL();
                                        /*Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return PrivacyPolicyPage();
                                              },
                                            )
                                        );

                                         */
                                      },
                                      child: Text("Privacy Policy",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                  )
                              ],)
                            ],
                          ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // for profile Image
          SlideTransition(
            position: signupImageAlertBackgroundAnimation,
            child: GestureDetector(
              onTap: () {
                endSignupImageAnimation();
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
            position: signupImageAlertAnimation,
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
                                endSignupImageAnimation();
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
