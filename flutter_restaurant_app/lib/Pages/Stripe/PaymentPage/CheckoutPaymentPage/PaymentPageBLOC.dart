import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Firebase/Database/RestaurantDB.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Pages/Stripe/Services/payment-service.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter_restaurant_app/Globals/GlobalAnimations.dart';
import 'package:flutter_restaurant_app/Models/DeliveryAddressModel.dart';

class PaymentPageBLOC {
  RestaurantDB restaurantDB;

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

  setOrderBasics(OrderModel thisOrder, UserModel thisUser, List<MealModel> orderItems, int deliveryCharges, int tax){
    OrderModel thisNewOrder = thisOrder;

    thisNewOrder.orderUserId = thisUser.uid;
    thisNewOrder.orderItems = orderItems;
    thisNewOrder.orderDeliveryCharges = deliveryCharges;
    thisNewOrder.orderTax = tax;
    thisNewOrder.orderSubtotal = thisOrder.setSubtotal();
    thisNewOrder.orderTotalCost = thisOrder.setOrderTotal();

    return thisNewOrder;
  }


  setOrderAddress(DeliveryAddressModel userDeliveryAddress, OrderModel thisOrder){
   OrderModel thisNewOrder = thisOrder;

   thisNewOrder.deliveryAddress = userDeliveryAddress.address;
   thisNewOrder.deliveryCity = userDeliveryAddress.city;
   thisNewOrder.deliveryState = userDeliveryAddress.state;
   thisNewOrder.deliveryZip = userDeliveryAddress.zip;
   thisNewOrder.deliveryApartmentNumber = userDeliveryAddress.apartmentNumber;

   return thisNewOrder;
  }


  setOrderPaymentMethod(CreditCardModel userPaymentMethod, OrderModel thisOrder){

    OrderModel thisNewOrder = thisOrder;

    thisNewOrder.paymentFirstName =  userPaymentMethod.firstName;
    thisNewOrder.paymentLastName =  userPaymentMethod.lastName;
    thisNewOrder.paymentCardNumber =  userPaymentMethod.cardNumber;
    thisNewOrder.paymentExpiryDate =  userPaymentMethod.expiryDate;
    thisNewOrder.paymentExpiryMonth =  userPaymentMethod.expiryMonth;
    thisNewOrder.paymentExpiryYear =  userPaymentMethod.expiryYear;
    thisNewOrder.paymentCardHolderName =  userPaymentMethod.cardHolderName;
    thisNewOrder.paymentCvvCode =  userPaymentMethod.cvvCode;
    thisNewOrder.paymentId = userPaymentMethod.paymentId;

    return thisNewOrder;
  }



  //--------- Payment Cards --------
  //New Card
  Future payViaNewCard({BuildContext context, UserModel thisUser, OrderModel paymentOrder}) async{
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
  Future payViaExistingCard({BuildContext context, UserModel thisUser, OrderModel paymentOrder}) async{

    //this takes after the "package" CreditCard Model
    OrderModel thisPaymentOrder = paymentOrder;

    //Pay through customerId
    var response = await StripePaymentService.chargeCustomerThroughPaymentMethodID(
        thisUser: thisUser,
        thisPaymentOrder: thisPaymentOrder
    );

    return response;
  }

  //-----------------


  setDataToUserPaymentHistory({BuildContext context, UserModel thisUser, OrderModel thisPaymentOrder, String paymentType}){
    thisUser.addPaymentToHistory(paidOrder: thisPaymentOrder);
  }


  //------------- Creating New Customer In Stripe ----------

  createNewCustomer(UserModel thisUser){
    StripePaymentService.createNewCustomer(thisUser: thisUser);
  }

  //------------- Creating A New Customer Token In Stripe ----------

  createNewCustomerToken(UserModel thisUser, OrderModel thisPaymentOrder){
    StripePaymentService.createNewCustomerToken(thisUser: thisUser, thisPaymentOrder: thisPaymentOrder);
  }

  //--------------- Futures ----------------

  PaymentPageBLOC(){
    restaurantDB = RestaurantDB();
  }
}