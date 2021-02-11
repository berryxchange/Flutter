import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Screens/CoursePurchasePage.dart';

class CoursePageDetailWidget extends StatefulWidget {
  final CourseProtocol course;
  final UserModel thisCurrentUser;

  CoursePageDetailWidget({this.course, this.thisCurrentUser});

  @override
  _CoursePageDetailWidgetState createState() => _CoursePageDetailWidgetState();
}

class _CoursePageDetailWidgetState extends State<CoursePageDetailWidget> {
  handleCourse() {
    switch (widget.thisCurrentUser.checkContainsCurrentCourse(widget.course)) {
      case false:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return CoursePurchasePage(
                course: widget.course,
                thisCurrentUser: widget.thisCurrentUser,
              );
            },
            transitionDuration: Duration(seconds: 0),
          ),
          /* MaterialPageRoute(
                builder: (context) {
                  return CoursePurchasePage(
                    course: widget.course,
                    thisCurrentUser: widget.thisCurrentUser,
                  );
                })

            */
        );
        break;
      case true:
        widget.course.cancelThisPackage(widget.thisCurrentUser);
        print("Nothing to cancel");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      child: Hero(
        tag: 'CourseDetailWidget',
        child: Container(
          decoration: BoxDecoration(color: Colors.blue, boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
                color: Colors.white),
          ]),
          height: 350,
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

              /* image cover
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.4, 0.8],
                        colors: [Color.fromARGB(90, 0, 0, 0), Colors.black])
                ),
                //color: Color.fromARGB(90, 0, 0, 0),
              ),
               */

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                                  //checks to see if this user contains this course
                                  // (will return a bool) to all purchase to return the proper text
                                  widget.course.getPurchase(widget
                                      .thisCurrentUser
                                      .checkContainsCurrentCourse(
                                          widget.course)),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
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
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          //widget.course.purchaseThisCourse();
                          handleCourse();
                        });

                        //widget.course.purchaseThisCourse();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0)),
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              widget.course.updatePurchaseButtonText(
                                  widget.thisCurrentUser),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
