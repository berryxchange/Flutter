import 'package:firebase_database/firebase_database.dart';

abstract class CreditCardProtocol{
  String cardNumber;
  String expiryDate;
  int expiryMonth;
  int expiryYear;
  String cardHolderName;
  String cvvCode;
  bool showBackView;
  String firstName;
  String lastName;
  bool isSelected;
  String paymentId;

  showCardData(){
    print("firstName $firstName");
    print("lastName $lastName");
    print("card Number: $cardNumber");
    print("Expire Date: $expiryDate");
    print("Expire Month: $expiryMonth");
    print("Expire Year: $expiryYear");
    print("Card Holder Name: $cardHolderName");
    print("CVV: $cvvCode");
    print("paymentId: $paymentId");
  }
}


class CreditCardModel extends CreditCardProtocol {
  var key;
  var firstName = "Danny";
  var lastName = "Berry";
  var cardNumber = "4242424242424242";
  var expiryDate = "04/24";
  var expiryMonth = 04;
  var expiryYear = 24;
  var cardHolderName = "The Q";
  var cvvCode = "423";
  var showBackView = false;
  var isSelected = false;
  var paymentId = "something";

  CreditCardModel({
    this.firstName,
    this.lastName,
    this.cardNumber,
    this.expiryDate,
    this.expiryMonth,
    this.expiryYear,
    this.cardHolderName,
    this.cvvCode,
    this.showBackView,
    this.isSelected,
    this.paymentId
  });//true when you want to show cvv(back) view

  CreditCardModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        firstName = snapshot.value["firstName"],
        lastName = snapshot.value["lastName"],
        cardNumber = snapshot.value["cardNumber"],
        expiryDate = snapshot.value["expiryDate"],
        expiryMonth = snapshot.value["expiryMonth"],
        expiryYear = snapshot.value["expiryYear"],
        cardHolderName = snapshot.value["cardHolderName"],
        //cvvCode = snapshot.value["cvvCode"],
        showBackView = snapshot.value["showBackView"],
        isSelected = snapshot.value["isSelected"],
        paymentId = snapshot.value["paymentId"];


  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "cardNumber": cardNumber,
      "expiryDate": expiryDate,
      "expiryMonth": expiryMonth,
      "expiryYear": expiryYear,
      "cardHolderName": cardHolderName,
      //"cvvCode": cvvCode,
      "showBackView": showBackView,
      "isSelected": isSelected,
      "paymentId": paymentId
    };
  }
}



