import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Firebase/Authentication/auth.dart';
import 'package:flutter_church_app_2020/Pages/SignupPage/SignupPage.dart';
import 'package:flutter_church_app_2020/Pages/MainSelectionsPage/MainSelectionsPage.dart';
import 'package:flutter_church_app_2020/Pages/LoginPage/LoginBLOC.dart';
import 'package:flutter_church_app_2020/Widget/MainButtonWidgets.dart';
import 'package:flutter_church_app_2020/Widget/FloatingCardWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LogInPage extends StatefulWidget {
  static String id = "Log_In_Page";

  LogInPage({this.auth, this.onSignedIn});
  final AuthCentral auth;
  final VoidCallback onSignedIn;
  //final VoidCallback onSigningUp;

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //Instances
  LoginBLOC loginBLOC = LoginBLOC();
  //------------------

  //Strings
  String emailText = "";
  String passwordText = "";
  String resetPasswordText = "";
  //------------------

  //form data
  final _formKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  //------------------

  //submittingData
  void submitUserToFB() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      print("sendingToFirebase");
      form.save();
      form.reset();

      loginBLOC
          .submitUserToFB(
              context: context,
              form: form,
              email: emailText,
              password: passwordText)
          .then((isSignedIn) {
        if (isSignedIn == true) {
          widget.onSignedIn();
        } else {
          print("data is: $isSignedIn");
        }
      });
    }
  }

  signup() async {
    loginBLOC.signup(context, widget.auth).then((isSignedIn) {
      if (isSignedIn == true) {
        widget.onSignedIn();
      } else {
        print("Something went wrong..");
      }
    });
  }

  // forgotten Password
  _forgottenPasswordDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Forgotten Password",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: _forgotPaswordContent(),
          );
        });
  }

  _forgotPaswordContent() {
    return Container(
      height: 250,
      child: Column(
        children: <Widget>[
          Text(
            "please type your username for this account",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Form(
            key: _passwordformKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      labelText: "Username",
                      labelStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onSaved: (value) {
                      resetPasswordText = value;
                      return resetPasswordText;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ]),
          ),
          SizedBox(
            height: 15,
          ),
          FlatButton(
            child: Text("Done"),
            onPressed: () {
              submitPasswordInfo();
              Navigator.of(context).pop();
              _showThankyouDialog();
            },
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void submitPasswordInfo() async {
    final FormState form = _passwordformKey.currentState;

    if (form.validate()) {
      print("confirming data");
      form.save();
      form.reset();
      widget.auth.sendPasswordResetEmail(resetPasswordText);
    }
  }

  _showThankyouDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Thank You",
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Your password recovery has been sent to your email address.",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      "Assets/LoginImage.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Church App",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: FloatingCardWidget(
                      color: Colors.white,
                      widget: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                onSaved: (value) {
                                  //Do something with the user input.
                                  emailText = value;
                                  return emailText = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter correct email';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                textAlign: TextAlign.left,
                                onSaved: (value) {
                                  passwordText = value;
                                  return passwordText = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: Icon(Icons.vpn_key),
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
                    text: "Sign In",
                    onPressed: () {
                      submitUserToFB();
                      //Navigator.of(context).pushNamed(MainContainerPage.id);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            _forgottenPasswordDialog();
                          },
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      FlatButton(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          signup();
                          //widget.onSigningUp();
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
                      Navigator.of(context).pushNamed(MainSelectionsPage.id);
                    },
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
