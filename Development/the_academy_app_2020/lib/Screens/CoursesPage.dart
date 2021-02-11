import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:the_academy_app_2020/Models/CourseCategoryModel.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/CourseWidgets/CourseCategoryWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CoursesTrackDetailTabWidget.dart';

class MyCoursesPage extends StatefulWidget {
  static String id = "courses";

  @override
  _MyCoursesPageState createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  var thisUser = demoUserOne;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                width: 175,
                height: 175,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(87.5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 22.0),
                          blurRadius: 22.0,
                          spreadRadius: 0,
                          color: Color.fromARGB(45, 0, 65, 255)),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                      radius: 75,
                      //backgroundColor: Colors.blueGrey,
                      child: Image.asset(
                        "Assets/${demoUserOne.imageUrl}",
                        height: 175,
                        fit: BoxFit.fitHeight,
                      )
                      //backgroundImage: Image.asset(thisUser.imageUrl),
                      ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Finished",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                OutlineButton(
                  //shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Studying",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
                  ),
                ),
                OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Wishlist",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 170,
              child: ListView.builder(
                  itemCount: demoTopCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            child: CategoryCourseWidget(
                                category: demoTopCategories[index])),
                      ],
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
                height: 380,
                child: ListView.builder(
                    itemCount: thisUser.myCourses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(40, 0, 0, 0),
                                offset: Offset(
                                  3,
                                  3,
                                ),
                                spreadRadius: 4,
                                blurRadius: 7,
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: CoursesTrackDetailTabWidget(
                            course: thisUser.myCourses[index],
                            thisCurrentUser: thisUser,
                            myCourseIndex: index,
                          ),
                        ),
                      );

                      /*
                        Container(
                        height: 200,
                        child: Column(
                          children: [
                            CoursesTrackDetailTabWidget(
                              course: demoCourses[index],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                      */
                    })),
          ),
        ],
      ),
    );
  }
}
