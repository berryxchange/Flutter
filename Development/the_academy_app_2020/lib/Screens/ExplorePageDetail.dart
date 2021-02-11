import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseCategoryModel.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryContestWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryMembershipCourseWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryCourseByCourseWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryClassByClassWidget.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Screens/ExplorePageDetailCategoryDetail.dart';
import 'package:the_academy_app_2020/Screens/CoursePage.dart';

class ExplorePageDetailPage extends StatefulWidget {
  static final id = "explore_detail";

  @required
  final CourseCategoryProtocol category;
  @required
  final UserModel thisCurrentUser;

  ExplorePageDetailPage({this.category, this.thisCurrentUser});

  @override
  _ExplorePageDetailPageState createState() => _ExplorePageDetailPageState();
}

class _ExplorePageDetailPageState extends State<ExplorePageDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("this current user: ${widget.thisCurrentUser.firstName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          /*
          leading: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),

           */
          title: Text(
            "${widget.category.courseCategoryName}",
            //overflow: TextOverflow.fade,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_none),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
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
                      "Contests",
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
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.category.categoryContests.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: CategoryContestWidget(
                                  contest:
                                      widget.category.categoryContests[index]),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CoursePage(
                                    course:
                                        widget.category.categoryContests[index],
                                    thisCurrentUser: widget.thisCurrentUser,
                                  );
                                }));
                              },
                            ),
                            //SizedBox(width: 10,),
                          ],
                        );
                      }),
                ),
              ),

              // Membership Courses

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Membership Courses",
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
                    itemCount: widget.category.categoryMembershipCourses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: CategoryMembershipCourseWidget(
                                category: widget
                                    .category.categoryMembershipCourses[index]),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExplorePageDetailCategoryDetailPage(
                                  category: widget.category
                                      .categoryMembershipCourses[index],
                                  thisCurrentUser: widget.thisCurrentUser,
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

              //Course by course
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Course By Course",
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
                      itemCount: widget.category.categoryCourseByCourse.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: CategoryMembershipCourseWidget(
                                  category: widget
                                      .category.categoryCourseByCourse[index]),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ExplorePageDetailCategoryDetailPage(
                                    category: widget
                                        .category.categoryCourseByCourse[index],
                                    thisCurrentUser: widget.thisCurrentUser,
                                  );
                                }));
                              },
                            ),
                          ],
                        );
                      }),
                ),
              ),

              // Class by Class

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Class By Class",
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
                    itemCount: widget.category.categoryClassByClass.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: CategoryMembershipCourseWidget(
                                category: widget
                                    .category.categoryClassByClass[index]),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExplorePageDetailCategoryDetailPage(
                                  category: widget
                                      .category.categoryClassByClass[index],
                                  thisCurrentUser: widget.thisCurrentUser,
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
        ));
  }
}
