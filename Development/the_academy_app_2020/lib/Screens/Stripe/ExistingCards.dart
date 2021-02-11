import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Models/CreditCardModel.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
//import 'package:the_academy_app_2020/Screens/Stripe/Services/StripeSubscriptionService.dart';
import 'package:the_academy_app_2020/Screens/Stripe/Services/payment-service.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:the_academy_app_2020/Models/paymentModel.dart';

class ExistingCardsPage extends StatefulWidget {
  static String id = "existing-cards";

  final int totalAmount;
  final UserModel thisUser;
  final AcademyCourse course;
  final paymentSelection;
  ExistingCardsPage(
      {@required this.totalAmount,
      @required this.thisUser,
      this.course,
      this.paymentSelection});

  @override
  _ExistingCardsPageState createState() => _ExistingCardsPageState();
}

class _ExistingCardsPageState extends State<ExistingCardsPage> {
  //payment function
  payViaExistingCard(BuildContext context, CreditCardModel card,
      UserModel thisUser, AcademyCourse course) async {
    //purchaseItem
    var thisProduct = PaymentModel(
        productName: course.courseName,
        productTotalCost: widget.totalAmount.toString(),
        purchaseDate: DateTime.now().toString(),
        productSellingCategory:
            widget.paymentSelection.packageTitle, // Premium, AllAccess, Regular
        productTerm: widget.paymentSelection.packageTerm);

    //progress dialog spinner
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: "Please wait..");

    await dialog.show();

    //this takes after the "package" CreditCard Model

    CreditCard stripeCard = CreditCard(
      number: card
          .cardNumber, //card["cardNumber"], // created Model data from CreditCardModel
      expMonth: card.expiryMonth, // created Model data from CreditCardModel
      expYear: card.expiryYear, // created Model data from CreditCardModel
    );
    //var response = await StripePaymentService.payViaExistingCard(
    var response = await StripePaymentService.payViaExistingCard(
        amount: widget.totalAmount.toString(),
        currency: "USD",
        card:
            stripeCard, // takes the "package Card Model" instead of created Card(card)
        thisUser: thisUser);

    //end of dialog spinner
    await dialog.hide();

    Scaffold.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration:
              Duration(milliseconds: response.success == true ? 1200 : 3000),
        ))
        .closed
        .then((_) {
      thisUser.addPaymentToHistory(thisProduct);
      course.purchaseThisCourse(widget.thisUser);
      thisUser.addCourseToList(course);
      print(thisUser.finance.previousPayments.length);

      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Existing Card"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: widget.thisUser.finance.cOF.length,
            itemBuilder: (BuildContext context, int index) {
              var thisCard = widget.thisUser.finance.cOF[index];
              return InkWell(
                onTap: () {
                  payViaExistingCard(context, thisCard, widget.thisUser,
                      widget.course); // when tapped, pay with the card
                },
                child: CreditCardWidget(
                  cardNumber: thisCard.cardNumber,
                  expiryDate: thisCard.expiryDate,
                  cardHolderName: thisCard.cardHolderName,
                  cvvCode: thisCard.cvvCode,
                  showBackView: thisCard
                      .showBackView, //true when you want to show cvv(back) view
                ),
              );
            }),
      ),
    );
  }
}
