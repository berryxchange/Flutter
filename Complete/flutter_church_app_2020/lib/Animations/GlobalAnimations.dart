import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Pages/MainSelectionsPage/MainSelectionsPage.dart';
import 'package:flutter_church_app_2020/Pages/Root/RootPage.dart';

//Required controllers and animation items Universal
AnimationController alertController({Duration duration, thisClass}) {
  return AnimationController(vsync: thisClass, duration: duration);
}

Animation alertAnimation(
    {double beginningPositionX,
    double beginningPositionY,
    double endingPositionX,
    double endingPositionY,
    AnimationController parentAnimationController,
    Curve styleOfAnimationCurve}) {
  return Tween<Offset>(
    begin: Offset(beginningPositionX, beginningPositionY),
    end: Offset(endingPositionX, endingPositionY),
  ).animate(CurvedAnimation(
    parent: parentAnimationController,
    curve: styleOfAnimationCurve,
  ));
}

//-----------------------------------

//# profile Image GlobalsAnimations
Animation<Offset> signupImageAlertAnimation;
Animation<Offset> signupImageAlertBackgroundAnimation;
AnimationController signupImageAlertAnimationController;

//functions
startSignupImageAnimation() {
  signupImageAlertAnimationController.forward();
}

endSignupImageAnimation() {
  signupImageAlertAnimationController.reverse();
}

//# Edit Profile GlobalsAnimations
Animation<Offset> profileUpdatedAlertAnimation;
Animation<Offset> profileUpdatedAlertBackgroundAnimation;
AnimationController profileUpdatedAlertAnimationController;

//functions
startProfileUpdatedAnimation() {
  profileUpdatedAlertAnimationController.forward();
}

endProfileUpdatedAnimation(BuildContext context) async {
  await profileUpdatedAlertAnimationController.reverse();
  Navigator.pop(context, "reload");
}

//# Delete User GlobalsAnimations
Animation<Offset> deleteUserAlertAnimation;
Animation<Offset> deleteUserAlertBackgroundAnimation;
AnimationController deleteUserAlertAnimationController;

//functions
startDeleteUserAnimation() {
  deleteUserAlertAnimationController.forward();
}

endDeleteUserAnimation(BuildContext context, VoidCallback onSignOut) async {
  await deleteUserAlertAnimationController.reverse();
  //Navigator.popUntil(context, ModalRoute.withName("/main_page"));



}

cancelDeleteUserAnimation() {
  deleteUserAlertAnimationController.reverse();
}

//# profile Image GlobalsAnimations
Animation<Offset> profileImageAlertAnimation;
Animation<Offset> profileImageAlertBackgroundAnimation;
AnimationController profileImageAlertAnimationController;

//functions
startProfileImageAnimation() {
  profileImageAlertAnimationController.forward();
}

endProfileImageAnimation() {
  profileImageAlertAnimationController.reverse();
}

//# delivery address GlobalsAnimations
Animation<Offset> deliveryUpdatedAlertAnimation;
Animation<Offset> deliveryUpdatedAlertBackgroundAnimation;
AnimationController deliveryUpdatedAlertAnimationController;

//functions
startDeliveryUpdatedAnimation() {
  deliveryUpdatedAlertAnimationController.forward();
}

endDeliveryUpdatedAnimation() {
  deliveryUpdatedAlertAnimationController.reverse();
}

//# delivery address GlobalsAnimations
Animation<Offset> deleteAddressAlertAnimation;
Animation<Offset> deleteAddressAlertBackgroundAnimation;
AnimationController deleteAddressAlertAnimationController;

//functions
startDeleteAddressAnimation() {
  deleteAddressAlertAnimationController.forward();
}

endDeleteAddressAnimation() {
  deleteAddressAlertAnimationController.reverse();
}


//# Card GlobalsAnimations
Animation<Offset> addCardAlertAnimation;
Animation<Offset> addCardAlertBackgroundAnimation;
AnimationController addCardAlertAnimationController;

//functions
startAddCardAnimation() {
  addCardAlertAnimationController.forward();
}

Future endAddCardAnimation() async{
  addCardAlertAnimationController.reverse();
}



//#  Item Added to cart GlobalsAnimations
Animation<Offset> paymentCompleteAlertAnimation;
Animation<Offset> paymentCompleteAlertBackgroundAnimation;
AnimationController paymentCompleteAlertAnimationController;

//functions
startPaymentCompleteAnimation(){
  paymentCompleteAlertAnimationController.forward();
  // clearing data
  //currentOrder.orderItems = [];
  //thisOrder.clearDuplicates();

}

Future endPaymentCompleteAnimation(BuildContext context)async{

  await paymentCompleteAlertAnimationController.reverse();

}


//# No CardCard Animations
Animation<Offset> noCardAlertAnimation;
Animation<Offset> noCardAlertBackgroundAnimation;
AnimationController noCardAlertAnimationController;

//functions
startNoCardAnimation() {
  noCardAlertAnimationController.forward();
}

Future endNoCardAnimation() async{
  noCardAlertAnimationController.reverse();
}
