import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/CourseWidgets/CourseOverviewWidget.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/CourseWidgets/CoursePageDetailWidget.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';

class CoursePage extends StatefulWidget {
  static String id = "course_page";
  final AcademyCourse course;
  final UserModel thisCurrentUser;
  final int myCourseIndex;

  CoursePage({this.course, this.thisCurrentUser, this.myCourseIndex});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String currentSection;

  bool coursePurchased = false;
  String coursePurchaseButtonTitle = "Take this course";

  var pageHeight = 600.0;

  getCurrentSection(int tabNumber) {
    switch (tabNumber) {
      case 1:
        //do something
        currentSection = "Overview";
        break;
      case 2:
        //do something
        currentSection = "Lessons";
        break;
      case 3:
        //do something
        currentSection = "Exams";
        break;
    }
  }

  getPageHeight(String pageTitle) {
    switch (pageTitle) {
      case "Overview":
        pageHeight = 800;
        print(pageHeight);
        break;
      case "Lessons":
        pageHeight = 500;
        print(pageHeight);
        break;
      case "Exams":
        pageHeight = 500;
        print(pageHeight);
        break;
    }
  }

  //making or cancelling a purchase

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coursePurchased =
        widget.thisCurrentUser.checkContainsCurrentCourse(widget.course);

    widget.course.checkPurchase(widget.thisCurrentUser);
    // sets the button title if course is purchased or not
    print("this current user: ${widget.thisCurrentUser.firstName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: Text(
                "Add to wishlist",
                //overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          )
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: ListView(
          children: <Widget>[
            CoursePageDetailWidget(
              course: widget.course,
              thisCurrentUser: widget.thisCurrentUser,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              //height: 50,
              //width: double.infinity,
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                  //onTap: getPageHeight(),
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    GestureDetector(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        //constraints: BoxConstraints.expand(width: 100),
                        //color: Colors.blue,
                        child: Text(
                          "Overview",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                      ),
                      //onTap: getPageHeight("Overview"),
                    ),
                    GestureDetector(
                      //onTap: getPageHeight("Lessons"),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        //constraints: BoxConstraints.expand(width: 100),
                        //color: Colors.blue,
                        child: Text(
                          "Lessons",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                      ),
                    ),
                    GestureDetector(
                      //onTap: getPageHeight("Exams"),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        //constraints: BoxConstraints.expand(width: 100),
                        //color: Colors.blue,
                        child: Text(
                          "Exams",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: pageHeight,
                child: TabBarView(children: [
                  Container(
                    //overview
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          widget.course.courseOverview,
                          textAlign: TextAlign.justify,
                          style: TextStyle(),
                          maxLines: 11,
                        ),

                        Spacer(),

                        Divider(
                          thickness: 2,
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          children: [
                            Text(
                              "In this course you will get: ",
                              //textAlign: TextAlign.left,
                            ),
                          ],
                        ),

                        //course
                        SizedBox(
                          height: 20,
                        ),
                        // benefits
                        Container(
                          height: 150,
                          child: ListView.builder(
                            itemCount: widget.course.courseIncentives.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(widget.course.courseIncentives[index])
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        Divider(
                          thickness: 2,
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          children: [
                            Text(
                              "More courses from this instructor: ",
                              //textAlign: TextAlign.left,
                            ),
                          ],
                        ),

                        //second tab
                        Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: demoCourses.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        child: ClipRRect(
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Stack(
                                              //alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  child: Image.asset(
                                                    "Assets/${demoCourses[index].courseImage}",
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                  height: 100,
                                                ),

                                                /* image cover
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                              stops: [0.4, 0.8],
                                                              colors: [Color.fromARGB(50, 0, 0, 0), Colors.black])
                                                      ),
                                                      //color: Color.fromARGB(90, 0, 0, 0),
                                                    ),
                                                     */

                                                Center(
                                                    child: Text(
                                                  demoCourses[index].courseName,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        onTap: () {
                                          demoCourses[index].showCourse();
                                        },
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      //shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.course.courseLessons.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: ClipRRect(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0,
                                              color: Colors.black12),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 100,
                                      //width: 100,
                                      //color: Colors.blueGrey,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            height: 90,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget
                                                      .course
                                                      .courseLessons[index]
                                                      .lessonTitle,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "${widget.course.courseLessons[index].lessonCompletionTime.toString()} Min"),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  onTap: () {
                                    widget.course.updateCourseLessonSelection(
                                        index,
                                        widget.thisCurrentUser,
                                        context,
                                        widget.myCourseIndex);
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      //shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  //width: 100,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
