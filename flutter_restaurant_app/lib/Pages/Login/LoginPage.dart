import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Pages/SignUp/SignupPage.dart';
import 'package:flutter_restaurant_app/Pages/MainContainer/MainContainerPage.dart';
import 'package:flutter_restaurant_app/Pages/Login/LoginBLOC.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/FloatingCardWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  static String id = "Log_In_Page";

  LoginPage({this.auth, this.onSignedIn});
  final AuthCentral auth;
  final VoidCallback onSignedIn;
  //final VoidCallback onSigningUp;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Instances
  LoginBLOC loginBLOC = LoginBLOC();
  //------------------

  //Strings
  String emailText = "";
  String passwordText = "";
  //------------------

  //form data
  final _formKey = GlobalKey<FormState>();
  //------------------

  //submittingData
  void submitUserToFB() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      print("sendingToFirebase");
      form.save();
      form.reset();

      loginBLOC.submitUserToFB(
          context: context,
          form: form,
          email: emailText,
          password: passwordText
      ).then((isSignedIn) {
        if (isSignedIn == true) {
          widget.onSignedIn();
        }else{
          print("data is: $isSignedIn");
        }
      });
    }
  }


  signup() async {
    loginBLOC.signup(context, widget.auth).then((isSignedIn) {
      if (isSignedIn == true){
        widget.onSignedIn();
      }else{
        print("Something went wrong..");
      }
    });
  }

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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      children: [
                        Text(
                          "Church App",
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
                            // Navigator.of(context).pushNamed(ForgotPasswordPage.id);
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
                      Navigator.of(context).pushNamed(MainContainerPage.id);
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
