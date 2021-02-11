import 'package:flutter/services.dart';
import 'package:flutter_church_app_2020/Firebase/Database/ChurchDB.dart';
import 'package:flutter_church_app_2020/Models/CreditCardModel.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Models/PaymentOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Pages/Payments/UserPaymentMethods/UserPaymentMethods/UserPaymentMethodsPage.dart';



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
  static Future createNewCustomer({ChurchUserModel thisUser}) async{
    var customerResponseId;
    try {

      Map<String, dynamic> body = {
        "email": thisUser.userEmail,
        "name": "${thisUser.userFirstName} ${thisUser.userLastName}",
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
  static addCardToCustomer({ChurchUserModel thisUser, CreditCardModel thisCard}) async{
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


  static Future addPaymentMethodToCustomer({ChurchUserModel thisUser, CreditCardModel thisCard}) async{
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
  static chargeCustomerThroughPaymentMethodID({ChurchUserModel thisUser, PaymentOrderModel thisPaymentOrder, CreditCardModel thisCard}) async{
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
            message:  "Hey ${thisUser.userFirstName}, this Transaction was successful",
            success: true
        );
      }else{
        print("something went wrong");
        return StripeTransactionResponse(
            message: "Sorry ${thisUser.userFirstName}, this transaction has failed..",
            success: false
        );
      }
    }catch(error){
      print("Charge Method error: $error");
    }
    return response;
  }


  //--------------------- chargeCustomerThroughCustomerID -------------------
  static chargeCustomerThroughPaymentId({ChurchUserModel thisUser, PaymentOrderModel thisPaymentOrder}) async{
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
            message:  "Hey ${thisUser.userFirstName}, this Transaction was successful",
            success: true
        );
      }else{
        print("something went wrong");
        return StripeTransactionResponse(
            message: "Sorry ${thisUser.userFirstName}, this transaction has failed..",
            success: false
        );
      }
    }catch(error){
      print("Creating Token error: $error");
    }
    return response;
  }


  //--------------------- Creating New Stripe Customer Token -------------------
  static createNewCustomerToken({ChurchUserModel thisUser, PaymentOrderModel thisPaymentOrder}) async{
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


  static Future chargeCustomerThroughToken({BuildContext context, ChurchUserModel thisUser, PaymentOrderModel thisPaymentOrder}) async{
    var response;
    try {

      CreditCardModel thisNewCard = await Navigator.push(context,
          MaterialPageRoute(
              builder: (context) {
                return UserPaymentMethodsPage(
                  thisUser: thisUser,
                  tabIndex: 1,
                  fromPaymentsPage: false,
                  fromPaymentPageNewCard: true,
                );
              }
          )
      );


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
        print("Yay a new TokePayment has been created! data: ${response.body}");
        return StripeTransactionResponse(
            message:  "Hey ${thisUser.userFirstName}, this Transaction was successful",
            success: true
        );
      }else{
        print("something went wrong");
        return StripeTransactionResponse(
            message: "Sorry ${thisUser.userFirstName}, this transaction has failed..",
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