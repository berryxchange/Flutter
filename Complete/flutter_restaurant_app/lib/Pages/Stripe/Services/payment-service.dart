import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Pages/UserPaymentMethods/UserPayment/UserPaymentMethodsPage.dart';
import 'package:secure_random/secure_random.dart';

class StripeTransactionResponse{
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}


class StripePaymentService{
  //new data (erasable)
  static String backendBaseUrl = "https://shielded-refuge-23728.herokuapp.com";
  //------------------

  // the header for the url call
  static Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
  };




  //------ Transaction Responses from Stripe --------

  //--------------------- Creating New Stripe Customer -------------------
  static Future createNewCustomer({UserModel thisUser}) async{
    var customerResponseId;
    try {

      Map<String, dynamic> body = {
        "email": thisUser.email,
        "name": "${thisUser.firstName} ${thisUser.lastName}",
        "description": "paying with Church App",
      };

      var createCustomerURL = "$backendBaseUrl/createCustomer";

      var response = await http.post(
          createCustomerURL,
          body: body,
          headers: null//StripePaymentService.headers
      );

      //print("Creating User Response: ${body.toString()}");

      if (response.statusCode == 200){

        print("Yay a new Customer has been created! data: ${response.body}");
        customerResponseId = response.body;

      }else{
        print("something went wrong");
      }
      return customerResponseId;
    }catch(error){
      print("Creating User error: $error");
    }
    return customerResponseId;
  }



  //--------------------- addCardToCustomer -------------------
  static addCardToCustomer({UserModel thisUser, CreditCardModel thisCard}) async{
    try {
      Map<String, dynamic> body = {
        "number": thisCard.cardNumber,
        "exp_month": "${thisCard.expiryMonth}",
        "exp_year": "${thisCard.expiryYear}",
        "cvc": thisCard.cvvCode,
        "customerId": thisUser.paymentId
      };


      var customerURL = "$backendBaseUrl/addCardToCustomer";

      var response = await http.post(
          customerURL,
          body: body,
          headers: null//StripePaymentService.headers
      );

      //print("Creating User Response: ${body.toString()}");

      if (response.statusCode == 200){
        //gets the Stripe Customer data body
        print("Yay a new Token has been created! data: ${response.body}");
      }else{
        print("something went wrong");
      }

    }catch(error){
      print("Creating Token error: $error");
    }
  }


  static Future addPaymentMethodToCustomer({UserModel thisUser, CreditCardModel thisCard}) async{
    var paymentId;
    try {

      Map<String, dynamic> body = {
        "number": thisCard.cardNumber,
        "exp_month": "${thisCard.expiryMonth}",
        "exp_year": "${thisCard.expiryYear}",
        "cvc": thisCard.cvvCode,
        "customerId": thisUser.paymentId
      };


      var customerURL = "$backendBaseUrl/addPaymentMethodToCustomer";

      var response = await http.post(
          customerURL,
          body: body,
          headers: null//StripePaymentService.headers
      );

      //print("Creating User Response: ${body.toString()}");

      if (response.statusCode == 200){
        //gets the Stripe Customer data body
        paymentId = "${response.body}";
        print("Yay a new Payment Method has been made! data: ${response.body}");

      }else{
        print("something went wrong");
      }

    }catch(error){
      print("Creating Token error: $error");
    }
    return paymentId;
  }



//--------------------- chargeCustomerThroughPaymentMethodID -------------------
  static chargeCustomerThroughPaymentMethodID({UserModel thisUser, OrderModel thisPaymentOrder, CreditCardModel thisCard}) async{
    var response;
    try {
      Map<String, dynamic> body = {
        "amount": "${thisPaymentOrder.orderTotalCost}",
        "currency": "usd",
        "payment_method": "${thisPaymentOrder.paymentId}",
        "description": "Paying for product on ChurchApp",
        "customer": thisUser.paymentId
      };

      var paymentURL = "$backendBaseUrl/chargeCustomerThroughPaymentMethodID";

      response = await http.post(
          paymentURL,
          body: body,
          headers: null//StripePaymentService.headers
      );

      //print("Creating User Response: ${body.toString()}");

      if (response.statusCode == 200){
        //gets the Stripe Customer data body
        print("Yay a new Payment has been made! data: ${response.body}");
        return StripeTransactionResponse(
            message:  "Hey ${thisUser.firstName}, this Transaction was successful",
            success: true
        );
      }else{
        print("something went wrong");
        return StripeTransactionResponse(
            message: "Sorry ${thisUser.firstName}, this transaction has failed..",
            success: false
        );
      }
    }catch(error){
      print("Charge Method error: $error");
    }
    return response;
  }


  //--------------------- chargeCustomerThroughCustomerID -------------------
  static chargeCustomerThroughPaymentId({UserModel thisUser, OrderModel thisPaymentOrder}) async{
    var response;
    try {
      Map<String, dynamic> body = {
        "amount": "${thisPaymentOrder.orderTotalCost}",
        "currency": "usd",
        "description": "Paying for product on ChurchApp",
        "customer": thisUser.paymentId
      };

      var paymentURL = "$backendBaseUrl/chargeCustomerThroughCustomerID";

      response = await http.post(
          paymentURL,
          body: body,
          headers: null//StripePaymentService.headers
      );

      //print("Creating User Response: ${body.toString()}");

      if (response.statusCode == 200){
        //gets the Stripe Customer data body
        print("Yay a new Payment has been made! data: ${response.body}");
        return StripeTransactionResponse(
            message:  "Hey ${thisUser.firstName}, this Transaction was successful",
            success: true
        );
      }else{
        print("something went wrong");
        return StripeTransactionResponse(
            message: "Sorry ${thisUser.lastName}, this transaction has failed..",
            success: false
        );
      }
    }catch(error){
      print("Creating Token error: $error");
    }
    return response;
  }


  //--------------------- Creating New Stripe Customer Token -------------------
  static createNewCustomerToken({UserModel thisUser, OrderModel thisPaymentOrder}) async{
    try {


      Map<String, dynamic> body = {
        "number": thisPaymentOrder.paymentCardNumber,
        "exp_month": "${thisPaymentOrder.paymentExpiryMonth}",
        "exp_year": "${thisPaymentOrder.paymentExpiryYear}",
        "cvc": thisPaymentOrder.paymentCvvCode
      };


      var tokenURL = "$backendBaseUrl/createCustomerToken";

      var response = await http.post(
          tokenURL,
          body: body,
          headers: null//StripePaymentService.headers
      );

      //print("Creating User Response: ${body.toString()}");

      if (response.statusCode == 200){
        //gets the Stripe Customer data body
        print("Yay a new Token has been created! data: ${response.body}");
      }else{
        print("something went wrong");
      }

    }catch(error){
      print("Creating Token error: $error");
    }
  }


  static Future chargeCustomerThroughToken({BuildContext context, UserModel thisUser, OrderModel thisPaymentOrder, CreditCardModel thisNewCard}) async{
    var response;
    try {

      Map<String, dynamic> body = {
        "number": thisNewCard.cardNumber,
        "exp_month": "${thisNewCard.expiryMonth}",
        "exp_year": "${thisNewCard.expiryYear}",
        "cvc": thisNewCard.cvvCode,
        "amount": "${thisPaymentOrder.orderTotalCost}",
        "currency": "usd",
        "description": "Paying for product on ChurchApp"
      };

      var tokenURL = "$backendBaseUrl/chargeCustomerThroughToken";

      response = await http.post(
          tokenURL,
          body: body,
          headers: null//StripePaymentService.headers
      );


      //print("Creating User Response: ${body.toString()}");

      if (response.statusCode == 200){
        //gets the Stripe Customer data body
        //print("Yay a new TokePayment has been created! data: ${response.body}");

        OrderModel newOrder = thisPaymentOrder;

        newOrder.paymentFirstName =  thisNewCard.firstName;
        newOrder.paymentLastName =  thisNewCard.lastName;
        newOrder.paymentCardNumber =  thisNewCard.cardNumber;
        newOrder.paymentExpiryDate =  thisNewCard.expiryDate;
        newOrder.paymentExpiryMonth =  thisNewCard.expiryMonth;
        newOrder.paymentExpiryYear =  thisNewCard.expiryYear;
        newOrder.paymentCardHolderName =  thisNewCard.cardHolderName;
        newOrder.paymentCvvCode =  thisNewCard.cvvCode;
        newOrder.paymentId = thisNewCard.paymentId;
        newOrder.orderUserId = thisUser.uid;

        if (newOrder.deliveryAddress == ""){
          newOrder.deliveryAddress = "N/A";
          newOrder.deliveryApartmentNumber = "N/A";
          newOrder.deliveryCity = "N/A";
          newOrder.deliveryState = "N/A";
          newOrder.deliveryZip = "N/A";
        }


        var secureRandom = SecureRandom();
        newOrder.orderName = secureRandom.nextString(length: 6);
        newOrder.orderStatus = "Waiting for processing";

        thisUser.addPaymentToHistory(paidOrder: newOrder);

        return StripeTransactionResponse(
            message:  "Hey ${thisUser.firstName}, this Transaction was successful",
            success: true
        );
      }else{
        print("something went wrong");
        return StripeTransactionResponse(
            message: "Sorry ${thisUser.firstName}, this transaction has failed..",
            success: false
        );
      }
    }catch(error){
      print("Creating Token error: $error");
    }
    print("response code1: ${response.statusCode}");
    return response;
  }




  //---------------------- For failures during the process ---------------
  static getPlatformExceptionErrorResult(error){
    String message = "Something went wrong from Stripe";

    if (error.code == "cancelled") {
      print("This was cancelled by you..");

      message = "Transaction cancelled";
    }

    return StripeTransactionResponse(
        message: message,
        success: false
    );
  }
}