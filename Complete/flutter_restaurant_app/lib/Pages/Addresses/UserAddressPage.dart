import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:flutter_restaurant_app/Models/DeliveryAddressModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Pages/DeliveryAddress/DeliveryAddressPage.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/DialogueWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/AddressWidget.dart';
//import 'package:flutter_restaurant_backend_app/Globals/GlobalVariables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:secure_random/secure_random.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
//import 'package:flutter_restaurant_backend_app/Globals/GlobalLists.dart';

class UserAddressPage extends StatefulWidget {
  final UserModel thisUser;

  static String id = "/deliveryAddress";

  UserAddressPage({this.thisUser});
  @override
  _UserAddressPageState createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage>
    with TickerProviderStateMixin {
  RestaurantDB restaurantDB;
  UserModel thisUser;
  DatabaseReference userAddressRef;


  List<DeliveryAddressModel> addresses = List();
  DeliveryAddressModel thisUserAddress;
  int addressIndex = 0;

  // for the form
  final _formKey = GlobalKey<FormState>();

  void handleSubmit() {
    final FormState form = _formKey.currentState;

    // Validate will return true if the form is valid, or false if
    // the form is invalid.

    if (form.validate()) {
      form.save();
      form.reset();
      // put data below form.save()

      restaurantDB.launchUserAddressesPath(thisUser, thisUserAddress, "create");
      startDeliveryUpdatedAnimation();
    }
  }
  //-------------


  double listSpace(List addresses, int currentItemIndex) {
    double spaceAmount = 0;
    if (currentItemIndex != addresses.length) {
      spaceAmount = 0;
    } else if (currentItemIndex == addresses.length) {
      spaceAmount = 12;
      print("current index: $spaceAmount");
    }
    return spaceAmount;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    restaurantDB = RestaurantDB();
    thisUserAddress = DeliveryAddressModel();
    thisUser = widget.thisUser;

    userAddressRef =  FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child("${thisUser.uid}")
        .child("Addresses");



    // set the controller from GlobalAnimations chart
    deliveryUpdatedAlertAnimationController = alertController(
        duration: Duration(seconds: 1), thisClass: this); //required

    // set the controller from GlobalAnimations chart
    deleteAddressAlertAnimationController = alertController(
        duration: Duration(seconds: 1), thisClass: this); //required

    // set the profile update alertAnimation from GlobalAnimations chart
    deliveryUpdatedAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: deliveryUpdatedAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    deliveryUpdatedAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: deliveryUpdatedAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    // set the profile update alertAnimation from GlobalAnimations chart
    deleteAddressAlertAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: deleteAddressAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);

    deleteAddressAlertBackgroundAnimation = alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController: deleteAddressAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn);




    setListeners();


  }


  setListeners(){
    userAddressRef.onChildAdded.listen(_getCurrentUsersAddressesEvent);
    userAddressRef.onChildChanged.listen(_onAddressChanged);
    userAddressRef.onChildRemoved.listen(_onAddressRemoved);
  }

  _getCurrentUsersAddressesEvent(Event event) {
    //thisUserInfo
    var thisAddress = DeliveryAddressModel.fromSnapshot(event.snapshot);
    print(event.snapshot.toString());
    if (thisAddress.address != null) {
      setState(() {
        addresses.add(thisAddress);
      });
    }
  }

  _onAddressChanged(Event event) {
    var old = addresses.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      addresses[addresses.indexOf(old)] = DeliveryAddressModel.fromSnapshot(event.snapshot);
    });

  }


  _onAddressRemoved(Event event) {
    var old = addresses.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    //ministries[ministries.indexOf(old)] = Ministry.fromSnapshot(event.snapshot);
    setState(() {
      addresses.removeAt(addresses.indexOf(old));
    });

  }


  callDeleteActions(int index){
    startDeleteAddressAnimation();
    addressIndex = index;
    print("the address index is: $index");
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
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12, bottom: 12, top: 30),
                      //padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        children: [
                          Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      child: ListView.builder(
                          padding: const EdgeInsets.only(right: 12.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: addresses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                AddressWidget(
                                  deliveryAddresses: addresses,
                                  subtextColor: Colors.grey,
                                  mainColor: Colors.black,
                                  tabColor: Colors.white,
                                  //thisUser: widget.thisUser,
                                  index: index,
                                  deleteAction: (){
                                    setState(() {
                                      callDeleteActions(index);
                                    });
                                  },
                                ),
                                SizedBox(
                                    width: listSpace(addresses, index)),
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                      child: Row(
                        children: [
                          Text(
                            "Add New Address",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12, bottom: 12, top: 12),
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
                        //height: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "New Address",
                                    labelStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  onSaved: (value) {
                                    //thisDeliveryAddress.address = value;
                                    setState(() {
                                      thisUserAddress.address = value;
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
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      thisUserAddress.city = value;
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
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        onSaved: (value) {
                                          setState(() {
                                            thisUserAddress.state = value;
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "Zip",
                                          labelStyle: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        onSaved: (value) {
                                          setState(() {
                                            thisUserAddress.zip = value;
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
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      if (value != "") {
                                        thisUserAddress.apartmentNumber =
                                            value;
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
                      onPressed: () {
                        handleSubmit();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CancelButton(
                      text: "Cancel",
                      onPressed: () {
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
                      spreadRadius: 0.5)
                ],
              ),
            ),
          ),

          SlideTransition(
            position: deliveryUpdatedAlertAnimation,
            child: DeliveryAddressUpdatedWidget(
              title: "Address Updated",
              subtitle: "Your address has been updated!",
              actionOne: () {
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
                      spreadRadius: 0.5)
                ],
              ),
            ),
          ),

          SlideTransition(
            position: deleteAddressAlertAnimation,
            child: DeleteAddressWidget(
              title: "Delete Address",
              subtitle: "Are you sure you want to delete this address?",
              actionOne: () {
                //thisUser.removeAddressFromList(addresses[addressIndex]);
                restaurantDB.launchUserAddressesPath(thisUser, addresses[addressIndex], "delete");
                endDeleteAddressAnimation();
              },
              actionTwo: () {
                endDeleteAddressAnimation();
              },
            ),
          )
        ],
      ),
    );
  }
}
