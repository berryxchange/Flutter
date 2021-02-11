import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Models/CreditCardModel.dart';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/Services/payment-service.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Models/PaymentOrderModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter_church_app_2020/Animations/GlobalAnimations.dart';

class PaymentPageBLOC {
  ChurchDB churchDB;

  //--------------- BLOC Logic ----------------


  //---------- Colors -----------
  Color paymentMethodTabColor({int index, int paymentMethodIndex}) {
    if (paymentMethodIndex == index) {
      return ThemeData().primaryColor;
    } else {
      return Colors.white;
    }
  }


  Color paymentMethodTabMainTextColor({int index, int paymentMethodIndex}) {
    if (paymentMethodIndex == index) {
      return Colors.white;
    } else {
      return Colors.black54;
    }
  }


  Color paymentMethodTabSubtextColor({int index, int paymentMethodIndex}) {
    if (paymentMethodIndex == index) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }


  //---------- Animation Setters -----------
  //animations
  // set the controller from GlobalAnimations chart
  /*getDeleteAddressAlertAnimationController (){
    return alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    );
  } //required

  getPaymentCompleteAlertAnimationController(){
    return alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    );
  } //require

  getNoCardAlertAnimationController(){
    return alertController(
        duration: Duration(seconds: 1),
        thisClass: this
    );
  } //require//

   */



  // set the profile update alertAnimation from GlobalAnimations chart
  getPaymentCompleteAlertAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        paymentCompleteAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  getPaymentCompleteAlertBackgroundAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        paymentCompleteAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  // set the profile update alertAnimation from GlobalAnimations chart
  getDeleteAddressAlertAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        deleteAddressAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  getDeleteAddressAlertBackgroundAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        deleteAddressAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  // set the no Card alertAnimation from GlobalAnimations chart
  getNoCardAlertAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: 5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        noCardAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }

  getNoCardAlertBackgroundAnimation(){
    return alertAnimation(
        beginningPositionX: 0.0,
        beginningPositionY: -5.0,
        endingPositionX: 0.0,
        endingPositionY: 0.0,
        parentAnimationController:
        noCardAlertAnimationController,
        styleOfAnimationCurve: Curves.fastLinearToSlowEaseIn
    );
  }




  //--------- Payment Cards --------
  //New Card
  Future payViaNewCard({BuildContext context, ChurchUserModel thisUser, PaymentOrderModel paymentOrder}) async{
    //progress dialog spinner

    //first create form with user card data.
    //then function data with token
    var response = await StripePaymentService.chargeCustomerThroughToken(
        context: context,
        thisUser: thisUser,
        thisPaymentOrder: paymentOrder
    );//chargeCustomerThroughToken(context, thisUser, paymentOrder);

    return response;
  }



     //Existing Cards
  //payment function
  Future payViaExistingCard({BuildContext context, ChurchUserModel thisUser, PaymentOrderModel paymentOrder, String paymentType
  }) async{

    //this takes after the "package" CreditCard Model
    PaymentOrderModel thisPaymentOrder = paymentOrder;

    //Pay through customerId
    var response = await StripePaymentService.chargeCustomerThroughPaymentMethodID(
        thisUser: thisUser,
        thisPaymentOrder: thisPaymentOrder
    );

    return response;
  }

  //-----------------


  setDataToUserPaymentHistory({BuildContext context, ChurchUserModel thisUser, PaymentOrderModel thisPaymentOrder, String paymentType}){
    thisUser.addPaymentToHistory(
        context: context,
        paidOrder: thisPaymentOrder,
        thisUser: thisUser,
        paymentType: paymentType
    );
  }


  //------------- Creating New Customer In Stripe ----------

  createNewCustomer(ChurchUserModel thisUser){
    StripePaymentService.createNewCustomer(thisUser: thisUser);
  }

  //------------- Creating A New Customer Token In Stripe ----------

  createNewCustomerToken(ChurchUserModel thisUser, PaymentOrderModel thisPaymentOrder){
    StripePaymentService.createNewCustomerToken(thisUser: thisUser, thisPaymentOrder: thisPaymentOrder);
  }

  //--------------- Futures ----------------

  PaymentPageBLOC(){
    churchDB = ChurchDB();
  }
}