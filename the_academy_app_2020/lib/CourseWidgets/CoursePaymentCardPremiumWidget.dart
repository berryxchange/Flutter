import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseCostPackage.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Screens/Stripe/PaymentPage.dart';
import 'package:the_academy_app_2020/Screens/CoursePurchasePageNoPaymentsPage.dart';

class CoursePaymentCardPremiumWidget extends StatelessWidget {
  final CourseCostPackage coursePayment;
  final UserModel thisCurrentUser;
  final AcademyCourse course;

  const CoursePaymentCardPremiumWidget({
    this.coursePayment,
    this.thisCurrentUser,
    this.course
  });


  @override
  Widget build(BuildContext context) {

    checkCardsOnFile(){
      if (thisCurrentUser.finance.cOF.isNotEmpty){
        print("Not empty ${thisCurrentUser.finance.cOF}");
        print("this current user: ${thisCurrentUser.firstName}");
        print("course amount: ${coursePayment.packageCost.toInt()}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              print("this current user: ${thisCurrentUser.firstName}");
              print("course amount: ${coursePayment.packageCost.toInt()}");
              return PaymentsPage(
                totalAmount: coursePayment.packageCost.toInt(),
                thisUser: thisCurrentUser,
                course: course,
                paymentSelection: coursePayment,
              );
            },
          ),
        );
      }else{
        print("Its empty dude");
        // show add card tab


        Navigator.push(context,
          PageRouteBuilder(
            pageBuilder: (context,Animation<double> animation,Animation<double> secondaryAnimation){
              print("this current user: ${thisCurrentUser.firstName}");
              print("course amount: ${coursePayment.packageCost.toInt()}");
              return CoursePurchasePageNoPaymentsPage(
                totalAmount: coursePayment.packageCost.toInt(),
                thisUser: thisCurrentUser,
                course: course,
              );
            }, //transitionDuration: Duration(seconds: 0),
          ),
        );
      }
    }

    return Container(
      height: 300,
      //width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              child: Text(
                coursePayment.packageTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue
                ),
              ),
              height: 50,
            ),

            //SizedBox(height: 20,),

            Container(
              height: 100,
              child: Text(
                coursePayment.packageDescription,
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue
                ),
              ),
            ),

            SizedBox(height: 20,),

            Container(
              height: 30,
              child: Text(
                "\$${coursePayment.packageCost / 100}/ ${coursePayment.packageTerm}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                checkCardsOnFile();
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.amber,
                ),
                child: Center(
                    child: Text("Purchase",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}