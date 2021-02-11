abstract class CrediCardProtocol{
  String cardNumber;
  String expiryDate;
  int expiryMonth;
  int expiryYear;
  String cardHolderName;
  String cvvCode;
  bool showBackView;
  String firstName;
  String lastName;

  showCardData(){
    print("firstName $firstName");
    print("lastName $lastName");
      print("card Number: $cardNumber");
      print("Expire Date: $expiryDate");
      print("Expire Month: $expiryMonth");
      print("Expire Year: $expiryYear");
      print("Card Holder Name: $cardHolderName");
      print("CVV: $cvvCode");
  }
}


class CreditCardModel extends CrediCardProtocol {
  var firstName = "Danny";
  var lastName = "Berry";
  var cardNumber = "4242424242424242";
  var expiryDate = "04/24";
  var expiryMonth = 04;
  var expiryYear = 24;
  var cardHolderName = "The Q";
  var cvvCode = "423";
  var showBackView = false;

  CreditCardModel({
    this.firstName,
    this.lastName,
    this.cardNumber,
    this.expiryDate,
    this.expiryMonth,
    this.expiryYear,
    this.cardHolderName,
    this.cvvCode,
    this.showBackView
  });//true when you want to show cvv(back) view
}


// cards on hand
List<CreditCardModel> demoCardsOnFile = [
  CreditCardModel(
    firstName: "Quinton",
    lastName: "D",
    cardNumber: "4242424242424242",
    expiryDate: "04/24",
    expiryMonth: 04,
    expiryYear: 24,
    cardHolderName: "The Q",
    cvvCode: "423",
    showBackView: false,
  ),
  CreditCardModel(
    firstName: "Danny",
    lastName: "D",
    cardNumber: "5555555555554444",
    expiryDate: "04/23",
    expiryMonth: 04,
    expiryYear: 24,
    cardHolderName: "McDeath",
    cvvCode: "123",
    showBackView: false,
  ),
];
//--------------
