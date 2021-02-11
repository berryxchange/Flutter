import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Screens/Stripe/PaymentPage.dart';
import 'package:the_academy_app_2020/Screens/Stripe/Services/payment-service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Screens/AddNewPaymentCardFormPage.dart';

class NoPaymentsTabWidget extends StatefulWidget {

  final courseTotal;
  final course;
  final thisCurrentUser;

  NoPaymentsTabWidget({
    this.courseTotal,
    this.course,
    this.thisCurrentUser
  });

  @override
  _NoPaymentsTabWidgetState createState() => _NoPaymentsTabWidgetState();
}

class _NoPaymentsTabWidgetState extends State<NoPaymentsTabWidget> {

//--------- Payment Cards --------
  payViaNewCard(BuildContext context, UserModel thisUser, AcademyCourse course, int courseTotal) async{
    //progress dialog spinner
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(
        message: "Please wait.."
    );

    await dialog.show();

    var response = await StripePaymentService.payWithNewCard(
        amount: courseTotal.toString(),
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
      course.purchaseThisCourse(thisUser);

      Navigator.pop(context);
    });
  }

  //-----------------


  //Navigate to add a card form page
  addNewCard(){
    Navigator.push(context,
      PageRouteBuilder(
        pageBuilder: (context,Animation<double> animation,Animation<double> secondaryAnimation){
          return AddNewPaymentCardFormPage(
            thisUser: widget.thisCurrentUser,
          );
        }, //transitionDuration: Duration(seconds: 0),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: MediaQuery.of(context).size.height/1.8,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      child: Text(
                        "No Payment Methods",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue
                        ),
                      ),
                      height: 30,
                    ),
                  ),
                ),

                //SizedBox(height: 20,),

                Expanded(
                  flex: 2,
                  child: Center(
                    child: Icon(Icons.credit_card,
                    size: 75,
                    color: Colors.blue,),
                  ),
                ),

                Expanded(
                  child: Text(
                    "There are no payment methods added to your account, would you like to add one?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blue
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: addNewCard,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue,
                        ),
                        child: Center(
                            child: Text("Add New Card",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),)
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      print("this current user: ${widget.thisCurrentUser.firstName}");
                      print("course amount: ${widget.courseTotal}");

                      payViaNewCard(context, widget.thisCurrentUser, widget.course, widget.courseTotal);

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PaymentsPage(
                              totalAmount: widget.courseTotal,
                              thisUser: widget.thisCurrentUser,
                              course: widget.course,
                            );
                          },
                        ),
                      );

                       */
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black12,
                        ),
                        child: Center(
                            child: Text("No Thanks",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),)
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}