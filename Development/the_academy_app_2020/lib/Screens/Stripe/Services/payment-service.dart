import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_academy_app_2020/Models/UserModel.dart';

class StripeTransactionResponse{
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripePaymentService{
  static String apiBase = "https://api.stripe.com/v1";
  static String paymentApiUrl = "${StripePaymentService.apiBase}/payment_intents";
  static String secret = ""; // your secret key goes here

  // the header for the url call
  static Map<String, String> headers = {
    "Authorization": "Bearer ${StripePaymentService.secret}",
    "Content-Type": "application/x-www-form-urlencoded"
  };

  //------ init --------
  static init(){
    // starts the transaction response with needed data
    StripePayment.setOptions(
        StripeOptions(
            publishableKey: "",// your publishable key goes here
            merchantId: "Test",
            androidPayMode: 'test'
        )
    );
  }

  //------ Transation Responses from Stripe --------

  //------ paying with existing card --------
  static Future <StripeTransactionResponse> payViaExistingCard({String amount, String currency, CreditCard card, UserModel thisUser}) async {

      // to show a form for a new card entry
      try {

        //#1.4
        var paymentMethod = await StripePayment.createPaymentMethod( //from package import file
            PaymentMethodRequest(card: card)//from package import file
        );

        //#1.3
        // the payment intent on return
        var paymentIntent = await StripePaymentService.createPaymentIntent( //self created
            amount: amount,
            currency: currency,
            thisUser: thisUser
        );

        //#1.2
        var response = await StripePayment.confirmPaymentIntent( //from package import file

            PaymentIntent(
                clientSecret: paymentIntent["client_secret"],
                paymentMethodId: paymentMethod.id
            )
        );

        //#1
        // on success
        if (response.status == "succeeded") {
          return StripeTransactionResponse(
              message: "Hey ${thisUser.firstName}, this Transaction was successful",
              success: true
          );
        }else{
          return StripeTransactionResponse(
              message: "Sorry ${thisUser.firstName}, this transaction has failed..",
              success: false
          );
        }

        // if it fails
      } on PlatformException catch (error){
        return StripePaymentService.getPlatformExceptionErrorResult(error);
      }catch(error){
        return StripeTransactionResponse(
            message: "Sorry ${thisUser.firstName}, this transaction has failed.. ${error.toString()}",
            success: false
        );
      }
  }

  //------ pay with a new card ------

  // create a future with a try/ catch to catch any potential errors in the response
  static Future <StripeTransactionResponse> payWithNewCard({
    String amount, String currency, UserModel thisUser
  }) async {

    // to show a form for a new card entry
    try {

      //#1.4
      var paymentMethod = await StripePayment.paymentRequestWithCardForm( //from package import file
          CardFormPaymentRequest()//from package import file
      );

      //#1.3
      // the payment intent on return
      var paymentIntent = await StripePaymentService.createPaymentIntent( //self created
          amount: amount,
          currency: currency,
          thisUser: thisUser
      );

      //#1.2
      var response = await StripePayment.confirmPaymentIntent( //from package import file

          PaymentIntent(
            clientSecret: paymentIntent["client_secret"],
            paymentMethodId: paymentMethod.id

          )
      );

      //#1
      // on success
      if (response.status == "succeeded") {
        return StripeTransactionResponse(
            message:  "Hey ${thisUser.firstName}, this Transaction was successful",
            success: true
        );
      }else{
        return StripeTransactionResponse(
            message: "Sorry ${thisUser.firstName}, this transaction has failed..",
            success: false
        );
      }

      // if it fails
    } on PlatformException catch (error){
      print("platform, WHat the hell??");
      return StripePaymentService.getPlatformExceptionErrorResult(error);
    }catch(error){
      return StripeTransactionResponse(
        message: "Sorry ${thisUser.firstName}, this transaction has failed.. ${error.toString()}",
        success: false
      );
    }
  }

  static getPlatformExceptionErrorResult(error){
    String message = "Something went wrong";
    if (error.code == "cancelled") {
      message = "Transaction cancelled";
    }
    return StripeTransactionResponse(
        message: message,
        success: false
    );
  }


  //#1.3.2
  //------ Payment Intents given to Stripe to return an Ephemeral Key --------
  // the payment intent: after the payment method has been sent to stripe
  // you must send over a payment intent(Confirmation Charge)

  // here you can specifically make a (POST/ GET etc) calls to a network
  static Future<Map<String, dynamic>> createPaymentIntent({String amount, String currency, UserModel thisUser}) async{
    try{
      Map<String, dynamic> body = {
        "amount": amount,
        "currency": currency,
        "payment_method_types[]": "card"
      };

      // posts to the server
      var response = await http.post(
        StripePaymentService.paymentApiUrl,
        body: body,
        headers: StripePaymentService.headers
      );

      //returns a decoded JSON body
      print("intent ${response.body}");
      return jsonDecode(response.body);

    } catch (error){
      print("error charging user: ${error.toString()}");
    }
    return null;
  }

}