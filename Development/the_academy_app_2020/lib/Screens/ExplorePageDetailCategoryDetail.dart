import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseCategoryModel.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryContestWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryMembershipCourseWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryCourseByCourseWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryClassByClassWidget.dart';
import 'package:the_academy_app_2020/CourseWidgets/CategoryCourseWidget.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Screens/CoursePage.dart';

class ExplorePageDetailCategoryDetailPage extends StatefulWidget {

  static final id = "explore_detail_category_detail_page";

  @required final CourseCategoryProtocol category;
  @required final UserModel thisCurrentUser;

  ExplorePageDetailCategoryDetailPage({this.category, this.thisCurrentUser});

  @override
  _ExplorePageDetailCategoryDetailPageState createState() => _ExplorePageDetailCategoryDetailPageState();
}


class _ExplorePageDetailCategoryDetailPageState extends State<ExplorePageDetailCategoryDetailPage> {

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
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold
            ),
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
        body:

            Container(

              padding: EdgeInsets.only(left: 10, right: 10),
              //height: 150,
              child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: widget.category.categoryCourses.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: [
                        SizedBox(height: 10,),
                        GestureDetector(
                          child: CategoryCourseWidget(
                              course: widget.category.categoryCourses[index]
                          ),
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return CoursePage(
                                        course: widget.category.categoryCourses[index],
                                        thisCurrentUser: widget.thisCurrentUser,
                                      );
                                    })
                            );
                          },
                        ),
                        SizedBox(height: 10,),
                      ],
                    );
                  }
              ),
            ),

        /*
        Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Contests",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0050AC),
                      ),
                    ),

                    Text("View All",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBCBCBC)
                      ),
                    ),
                  ],
                ),
              ),




             Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 150,
                  child:
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.category.categoryContests.length,
                      itemBuilder: (BuildContext context, int index){
                        return Row(
                          children: [
                            SizedBox(width: 10,),
                            GestureDetector(
                              child: CategoryContestWidget(
                                  contest: widget.category.categoryContests[index]
                              ),
                              onTap: (){
                                widget.category.categoryContests[index].showCourse();
                              },
                            ),
                            //SizedBox(width: 10,),
                          ],
                        );
                      }
                  ),
                ),
              ),

              // Suggested Courses
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Membership Courses",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0050AC),
                      ),
                    ),

                    Text("View All",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBCBCBC)
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                //height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    itemCount: widget.category.categoryCourses.length,
                    itemBuilder: (BuildContext context, int index){
                      return Row(
                        children: [
                          SizedBox(width: 10,),
                          GestureDetector(
                            child: CategoryCourseWidget(
                                course: widget.category.categoryCourses[index]
                            ),
                            onTap: (){
                              widget.category.categoryCourses[index].showCourse();
                            },
                          ),
                          //SizedBox(width: 10,),
                        ],
                      );
                    }
                ),
              ),

              SizedBox(height: 30,),

            ],
          ),
        )

         */
    );
  }
}
