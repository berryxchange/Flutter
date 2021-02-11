import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:flutter_restaurant_app/Models/DeliveryAddressModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/DialogueWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/AddressWidget.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:secure_random/secure_random.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';

class DeliveryAddressPage extends StatefulWidget {

  final UserModel thisUser;

  static String id = "/deliveryAddress";

  DeliveryAddressPage({this.thisUser});
  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}



class _DeliveryAddressPageState extends State<DeliveryAddressPage> with TickerProviderStateMixin{

  //UserModel thisUser;
  DatabaseReference addressesRef;
  DatabaseReference userRef;
  List<DeliveryAddressModel> deliveryAddresses = List();

  var firebase = FirebaseDatabase.instance;
  User firebaseUser = AuthCentral.auth.currentUser;

  DeliveryAddressModel thisDeliveryAddress = DeliveryAddressModel(
    address: "",
    city: "",
    state: "",
    zip: "",
    apartmentNumber: "",
  );

  // for the form
  final _formKey = GlobalKey<FormState>();

  void handleSubmit(){
    final FormState form = _formKey.currentState;

    // Validate will return true if the form is valid, or false if
    // the form is invalid.

    if (form.validate()) {
      form.save();
      form.reset();
      // put data below form.save()

      //widget.thisUser.addAddressToList(thisDeliveryAddress);
      //widget.thisUser.showUserDetails();
      var secureRandom = SecureRandom();
      var randomId = secureRandom.nextString(length: 6);
      userRef.child("${firebaseUser.uid}").child("Addresses").child(randomId).set(thisDeliveryAddress.toJson());
      startDeliveryUpdatedAnimation();
    }
  }
  //-------------


  double listSpace(List addresses, int currentItemIndex){
    double spaceAmount = 0;
    if (currentItemIndex != addresses.length){
      spaceAmount = 0;

    }else if (currentItemIndex == addresses.length){
      spaceAmount = 12;
      print("current index: $spaceAmount");
    }
    return spaceAmount;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //thisUser = widget.thisUser;
    userRef = firebase.reference().child('users');
    addressesRef = firebase.reference().child('users').child("${firebaseUser.uid}").child("Addresses");
    addressesRef.onChildAdded.listen(_currentUsersAddressesEvent);
    addressesRef.onChildChanged.listen(_currentUsersAddressesEvent);
    // set the controller from GlobalAnimations chart
    deliveryUpdatedAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //required

    // set the controller from GlobalAnimations chart
    deleteAddressAlertAnimationController = alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    ); //required

    // set the profile update alertAnimation from GlobalAnimations chart
    deliveryUpdatedAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        deliveryUpdatedAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );

    deliveryUpdatedAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        deliveryUpdatedAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );

    // set the profile update alertAnimation from GlobalAnimations chart
    deleteAddressAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        deleteAddressAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );

    deleteAddressAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        deleteAddressAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  _currentUsersAddressesEvent(Event event) {
    //thisUserInfo
    var thisAddress = DeliveryAddressModel.fromSnapshot(event.snapshot);
    print(event.snapshot.toString());
    if (thisAddress.address != null) {
      setState(() {
        print("getting addresses");
        deliveryAddresses.add(thisAddress);
      });
      //thisAddress = thisAddress;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    deliveryUpdatedAlertAnimationController.dispose();
    deleteAddressAlertAnimationController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
      ),
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12, top: 30),
                        //padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Row(
                          children: [
                            Text("Delivery Address",
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        ),
                      ),


                      Container(
                        height: 120,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: deliveryAddresses.length,
                            itemBuilder: (BuildContext context, int index){
                              return Row(
                                children: [
                                  SizedBox(width: 12,),
                                  AddressWidget(
                                    deliveryAddresses: deliveryAddresses,
                                    subtextColor: Colors.grey,
                                    mainColor: Colors.black,
                                    tabColor: Colors.white,
                                    //thisUser: widget.thisUser,
                                    index: index,
                                    deleteAction: startDeleteAddressAnimation,
                                  ),
                                  SizedBox(width: listSpace(deliveryAddresses, index)),
                                ],
                              );
                            }),
                      ),

                      SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                        child: Row(
                          children: [
                            Text("Add New Address",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12, top: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(1, 1),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.5
                              )
                            ],
                          ),
                          //height: 300,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "New Address",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey
                                      ) ,
                                    ),
                                    onSaved: (value){
                                      //thisDeliveryAddress.address = value;
                                      setState(() {
                                        thisDeliveryAddress.address = value;
                                      });
                                      return null;

                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your new Address';
                                      }
                                      return null;
                                    },
                                  ),

                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "City",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey
                                      ) ,
                                    ),
                                    onSaved: (value){
                                      setState(() {
                                        thisDeliveryAddress.city = value;
                                      });
                                      //print(thisCard.lastName);
                                      return null;

                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your new city';
                                      }
                                      return null;
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "State",
                                            labelStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                            ) ,
                                          ),
                                          onSaved: (value){
                                            setState(() {
                                              thisDeliveryAddress.state = value;
                                            });
                                            //print(thisCard.lastName);
                                            return null;

                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter your new state';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      SizedBox(width: 10,),

                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: "Zip",
                                            labelStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                            ) ,
                                          ),
                                          onSaved: (value){
                                            setState(() {
                                              thisDeliveryAddress.zip = value;
                                            });
                                            //print(thisCard.lastName);
                                            return null;

                                          },
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter your new zip code';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Apartment#",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey
                                      ) ,
                                    ),
                                    onSaved: (value){
                                      setState(() {
                                        if (value != ""){
                                          thisDeliveryAddress.apartmentNumber = value;
                                        }
                                      });
                                      //print(thisCard.lastName);
                                      return null;

                                    },
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
                        text: "Update Address",
                        onPressed: (){
                         handleSubmit();
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      CancelButton(
                        text:  "Cancel", onPressed: (){
                        Navigator.pop(context);
                      },
                      ),


                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
            SlideTransition(
              position: deliveryUpdatedAlertBackgroundAnimation,
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
              position: deliveryUpdatedAlertAnimation,
              child: DeliveryAddressUpdatedWidget(
                title: "Address Updated",
                subtitle: "Your address has been updated!",
                actionOne: (){
                  endDeliveryUpdatedAnimation();
                },
              ),
            ),


            //## set object to "SlideTransition" and set position to AlertAnimation from GlobalAnimations chart
            SlideTransition(
              position: deleteAddressAlertBackgroundAnimation,
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
              position: deleteAddressAlertAnimation,
              child: DeleteAddressWidget(
                title: "Delete Address",
                subtitle: "Are you sure you want to delete this address?",
                actionOne: (){
                  print("deleting ${deliveryAddresses[addressIndex]}");
                  widget.thisUser.removeAddressFromList(deliveryAddresses[addressIndex]);
                  endDeleteAddressAnimation();
                },
                actionTwo: (){
                  endDeleteAddressAnimation();
                },
              ),
            )
          ],
        ),
    );
  }
}



