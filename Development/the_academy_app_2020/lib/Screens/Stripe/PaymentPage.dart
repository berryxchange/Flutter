import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseCostPackage.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Screens/Stripe/ExistingCards.dart';
import 'package:the_academy_app_2020/Screens/Stripe/Services/payment-service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Models/paymentModel.dart';

class PaymentsPage extends StatefulWidget {

  static String id = "payments";
  final int totalAmount;
  final UserModel thisUser;
  final AcademyCourse course;
  CourseCostPackage paymentSelection;

  PaymentsPage({
    @required this.totalAmount,
    @required this.thisUser,
    this.course,
    this.paymentSelection,
  });

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {


  //--------- Payment Cards --------
  payViaNewCard(BuildContext context, UserModel thisUser, AcademyCourse course) async{

    //purchaseItem
    var thisProduct = PaymentModel(
        productName: course.courseName,
        productTotalCost: widget.totalAmount.toString(),
        purchaseDate: DateTime.now().toString(),
        productSellingCategory: widget.paymentSelection.packageTitle,// Premium, AllAccess, Regular
        productTerm: widget.paymentSelection.packageTerm
    );

    //progress dialog spinner
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(
        message: "Please wait.."
    );

    await dialog.show();

    var response = await StripePaymentService.payWithNewCard(
        amount: widget.totalAmount.toString(),
        currency: "USD",
        thisUser: thisUser
    );

    await dialog.hide();

    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          duration: Duration(milliseconds: response.success == true ? 1200: 3000),
        )
    ).closed.then((_){

      //sets the purchased local to true for this user
      // by adding this course ID to the users mycourses list
      course.purchaseThisCourse(widget.thisUser);

      // apends to the users purchase history
      thisUser.addPaymentToHistory(thisProduct);
      print(thisUser.finance.previousPayments.length);

      Navigator.pop(context);
    });
  }


  // used when clicking a card to pay for amount this must await for the response
  onItemPressed(BuildContext context, int index, AcademyCourse course) async{

    switch(index){
      case 0:
      // pay via new card
      payViaNewCard(context, widget.thisUser, course);

    break;
      case 1:
        Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return ExistingCardsPage(
              totalAmount: widget.totalAmount,
              thisUser: widget.thisUser,
              course: widget.course,
              paymentSelection: widget.paymentSelection,
            );
          }),
        );
        break;
    }
  }

  //-----------------


  // override the init state to call the services init state
  // to authorize a payment function
  @override
  void initState(){
    super.initState();
    StripePaymentService.init();
  }


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Payments"),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: ListView.separated(
              itemBuilder: (context, index){
                Icon icon;
                Text text;

                switch(index){
                  case 0:
                    icon = Icon(Icons.add_circle, color:  theme.primaryColor,);
                    text = Text("Pay via new card");
                    break;
                  case 1:
                    icon = Icon(Icons.credit_card, color:  theme.primaryColor,);
                    text = Text("Pay via existing card");
                }

                return InkWell(
                  onTap: (){
                    onItemPressed(context, index, widget.course);
                  },
                  child: ListTile(
                    title: text,
                    leading: icon,
                  ),
                );
              },
              separatorBuilder: (context, index){
                return Divider(
                  color: theme.primaryColor,
                );
              },
              itemCount: 2
          ),
      )
    );
  }
}
