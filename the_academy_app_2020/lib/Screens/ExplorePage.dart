import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Models/CourseCategoryModel.dart';
import 'package:the_academy_app_2020/CourseWidgets/SuggestedCourseWidget.dart'; // suggested courses
import 'package:the_academy_app_2020/CourseWidgets/StaffPicksWidget.dart'; // staff picks courses
import 'package:the_academy_app_2020/CourseWidgets/PopularCoursesWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CourseCategoryWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryMembershipCourseWidget.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Screens/ExplorePageDetail.dart';
import 'package:the_academy_app_2020/Screens/CoursePage.dart';

class ExplorePage extends StatefulWidget {
  static String id = "/explore";

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<AcademyCourse> courses = [];
  List<AcademyCategory> categories = [];

  UserModel thisCurrentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = demoTopCategories;
    courses = demoCourses;
    thisCurrentUser = demoUserOne;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Courses By Categories",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0050AC),
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCBCBC)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 150,
              child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              child: CategoryMembershipCourseWidget(
                                  category: categories[index]),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ExplorePageDetailPage(
                                    category: categories[index],
                                    thisCurrentUser: thisCurrentUser,
                                  );
                                }));
                              },
                            ),
                          ),
                          //SizedBox(width: 10,),
                        ],
                      );
                    }),
              ),
            ),
          ),

          // Suggested Courses

          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Suggested Courses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0050AC),
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCBCBC)),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: SuggestedCourseWidget(course: courses[index]),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CoursePage(
                              course: courses[index],
                              thisCurrentUser: thisCurrentUser,
                            );
                          }));
                        },
                      ),
                      //SizedBox(width: 10,),
                    ],
                  );
                }),
          ),

          SizedBox(
            height: 30,
          ),

          //Staff Picks

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Staff Picks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0050AC),
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCBCBC)),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: StaffPicksWidget(course: courses[index]),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CoursePage(
                                course: courses[index],
                                thisCurrentUser: thisCurrentUser,
                              );
                            }));
                          },
                        ),
                      ],
                    );
                  }),
            ),
          ),

          // Popular Courses

          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Popular Courses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0050AC),
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCBCBC)),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: PopularCoursesWidget(course: courses[index]),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CoursePage(
                              course: courses[index],
                              thisCurrentUser: thisCurrentUser,
                            );
                          }));
                        },
                      ),
                    ],
                  );
                }),
          ),

          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
