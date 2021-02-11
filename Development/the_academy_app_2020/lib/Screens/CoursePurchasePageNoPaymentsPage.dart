import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseCostPackage.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/CourseWidgets/CoursePageDetailWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CoursePaymentCardPremiumWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/NoPaymentsTabWidget.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'dart:ui';

class CoursePurchasePageNoPaymentsPage extends StatefulWidget {
  final CourseProtocol course;
  final UserModel thisUser;
  final int totalAmount;

  CoursePurchasePageNoPaymentsPage(
      {this.course, this.thisUser, this.totalAmount});

  @override
  _CoursePurchasePageNoPaymentsPageState createState() =>
      _CoursePurchasePageNoPaymentsPageState();
}

class _CoursePurchasePageNoPaymentsPageState
    extends State<CoursePurchasePageNoPaymentsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("this current user: ${widget.thisUser.firstName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Page"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blue, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
              color: Colors.white),
        ]),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // the image
            Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: Image.asset(
                  "Assets/${widget.course.courseImage}",
                  fit: BoxFit.fitHeight,
                )),

            /*image cover
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.4, 0.6],
                      colors: [Color.fromARGB(20, 0, 0, 0), Colors.black])
              ),
              //color: Color.fromARGB(90, 0, 0, 0),
            ),
             */

            Container(
              height: 1000,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.course.courseName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  flex: 3,
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      child: Center(
                                        child: Text(
                                          widget.course.getPurchase(
                                              widget.course.purchased),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(),
                            SizedBox(height: 10),
                            Text(
                              widget.course.courseDescription,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 920,
                              //color: Colors.red,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      widget.course.courseCostPackages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CoursePaymentCardPremiumWidget(
                                          coursePayment: widget
                                              .course.courseCostPackages[index],
                                          thisCurrentUser: widget.thisUser,
                                          course: widget.course,
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //the blur background element
            Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.1), // the no payments tab
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 0),
              child: Hero(
                tag: "No Card Tab",
                child: Center(
                  child: NoPaymentsTabWidget(
                    courseTotal: widget.totalAmount,
                    thisCurrentUser: widget.thisUser,
                    course: widget.course,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
