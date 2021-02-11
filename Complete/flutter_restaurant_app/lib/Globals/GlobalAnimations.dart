import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Pages/MainContainer/MainContainerPage.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';

  FirebaseAuth _auth = AuthCentral.auth;

//Required controllers and animation items Universal
AnimationController alertController ({Duration duration, thisClass}){
  return AnimationController(
      vsync: thisClass,
      duration: duration
  );
}

Animation alertAnimation ({double beginningPositionX, double beginningPositionY, double endingPositionX, double endingPositionY, AnimationController parentAnimationController, Curve styleOfAnimationCurve}){
  return Tween<Offset>(
    begin: Offset(beginningPositionX, beginningPositionY),
    end: Offset(endingPositionX, endingPositionY),
  ).animate(CurvedAnimation(
    parent: parentAnimationController,
    curve: styleOfAnimationCurve,
  ));
}
//----------------



//# Forgotton Password GlobalsAnimations
Animation<Offset> forgottenPasswordSentAlertAnimation;
Animation<Offset> forgottenPasswordSentAlertBackgroundAnimation;
AnimationController forgottenPasswordSentAlertAnimationController;

//functions
startAnimation(){
  forgottenPasswordSentAlertAnimationController.forward();
}
endAnimation(){
  forgottenPasswordSentAlertAnimationController.reverse();
}

//-------------

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
//-------------

//# MainContainer GlobalsAnimations
Animation<Offset> signoutAlertAnimation;
Animation<Offset> signoutAlertBackgroundAnimation;
AnimationController signoutAlertAnimationController;

//functions
startSignOutAnimation(){
  signoutAlertAnimationController.forward();
}

Future endSignOutAnimation(BuildContext context)async{
  await signoutAlertAnimationController.reverse();
  _auth.signOut();
}

cancelSignOutAnimation(BuildContext context){
  signoutAlertAnimationController.reverse();
}



//# Edit Profile GlobalsAnimations
Animation<Offset> profileUpdatedAlertAnimation;
Animation<Offset> profileUpdatedAlertBackgroundAnimation;
AnimationController profileUpdatedAlertAnimationController;

//functions
startProfileUpdatedAnimation(){
  profileUpdatedAlertAnimationController.forward();
}

endProfileUpdatedAnimation(BuildContext context)async{
  await profileUpdatedAlertAnimationController.reverse();
  Navigator.pop(context);
}


//# Delete User GlobalsAnimations
Animation<Offset> deleteUserAlertAnimation;
Animation<Offset> deleteUserAlertBackgroundAnimation;
AnimationController deleteUserAlertAnimationController;

//functions
startDeleteUserAnimation(){
  deleteUserAlertAnimationController.forward();
}

endDeleteUserAnimation(BuildContext context)async{
  await deleteUserAlertAnimationController.reverse();
  Navigator.popUntil(context, ModalRoute.withName("/") );
}

cancelDeleteUserAnimation(){
  deleteUserAlertAnimationController.reverse();
}



//# profile Image GlobalsAnimations
Animation<Offset> profileImageAlertAnimation;
Animation<Offset> profileImageAlertBackgroundAnimation;
AnimationController profileImageAlertAnimationController;

//functions
startProfileImageAnimation(){
  profileImageAlertAnimationController.forward();
}

endProfileImageAnimation(){
  profileImageAlertAnimationController.reverse();
}



//# password changed GlobalsAnimations
Animation<Offset> passwordChangedAlertAnimation;
Animation<Offset> passwordChangedAlertBackgroundAnimation;
AnimationController passwordChangedAlertAnimationController;

//functions
startPasswordChangedAnimation(){
  passwordChangedAlertAnimationController.forward();
}

endPasswordChangedAnimation(){
  passwordChangedAlertAnimationController.reverse();
}



//# delivery address GlobalsAnimations
Animation<Offset> deliveryUpdatedAlertAnimation;
Animation<Offset> deliveryUpdatedAlertBackgroundAnimation;
AnimationController deliveryUpdatedAlertAnimationController;

//functions
startDeliveryUpdatedAnimation(){
  deliveryUpdatedAlertAnimationController.forward();
}

endDeliveryUpdatedAnimation(){
  deliveryUpdatedAlertAnimationController.reverse();
}


//# delivery address GlobalsAnimations
Animation<Offset> deleteAddressAlertAnimation;
Animation<Offset> deleteAddressAlertBackgroundAnimation;
AnimationController deleteAddressAlertAnimationController;

//functions
startDeleteAddressAnimation(){
  deleteAddressAlertAnimationController.forward();
}

endDeleteAddressAnimation(){
  deleteAddressAlertAnimationController.reverse();
}



//#  Item Added to cart GlobalsAnimations
Animation<Offset> addedToCartAlertAnimation;
Animation<Offset> addedToCartAlertBackgroundAnimation;
AnimationController addedToCartAlertAnimationController;

//functions
startAddedToCartAnimation(){
  addedToCartAlertAnimationController.forward();
}

Future endAddedToCartAnimation()async{
  await addedToCartAlertAnimationController.reverse();
}


endAddedToCartAndPushToCartAnimation(BuildContext context) async{
  await addedToCartAlertAnimationController.reverse();
  //Navigator.popAndPushNamed(context, pageId);
  Navigator.pop(context);
  /*Navigator.push(
    context,
    MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Cart Page"),
        ),
        body: CartPage(
        ),
      );
    }),
  );

   */
}


//#  Item Added to cart from cart page GlobalsAnimations
Animation<Offset> addedToCartAlertFromCartAlertAnimation;
Animation<Offset> addedToCartAlertFromCartAlertBackgroundAnimation;
AnimationController addedToCartAlertFromCartAlertAnimationController;

//functions
startAddedToCartAlertFromCartAnimation(){
  addedToCartAlertFromCartAlertAnimationController.forward();
}

Future endAddedToCartAlertFromCartAnimation()async{
  await addedToCartAlertFromCartAlertAnimationController.reverse();
}

endAddedToCartAlertFromCartAndPushToCartAnimation(BuildContext context) async{
  await addedToCartAlertFromCartAlertAnimationController.reverse();
  //Navigator.popAndPushNamed(context, pageId);
  Navigator.pop(context);
  /*Navigator.push(
    context,
    MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Cart Page"),
        ),
        body: CartPage(
        ),
      );
    }),
  );

   */
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
  //currentOrder.orderItems = [];
  /*Navigator.pushReplacement(context,
      MaterialPageRoute(
          builder: (context) {
            return MainContainerPage(
              pageIndex: 4,
              //thisUser: demoUserOne,
            );
          })
  );
   */
   //Navigator.popUntil(context, ModalRoute.withName("/mainContainer"));
  Navigator.pop(context, true);
}

//# Card GlobalsAnimations
Animation<Offset> addCardAlertAnimation;
Animation<Offset> addCardAlertBackgroundAnimation;
AnimationController addCardAlertAnimationController;

//functions
startAddCardAnimation(){
  addCardAlertAnimationController.forward();
}

endAddCardAnimation(){
  addCardAlertAnimationController.reverse();
}


//# Delete Item from list GlobalsAnimations
Animation<Offset> deleteItemFromListAlertAnimation;
Animation<Offset> deleteItemFromListAlertBackgroundAnimation;
AnimationController deleteItemFromListAlertAnimationController;

//functions
startDeleteItemFromListAnimation(){
  deleteItemFromListAlertAnimationController.forward();
}

endDeleteItemFromListAnimation(){
  deleteItemFromListAlertAnimationController.reverse();
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
