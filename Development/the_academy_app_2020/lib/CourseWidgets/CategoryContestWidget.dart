import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseCategoryModel.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';

class CategoryContestWidget extends StatelessWidget {
  const CategoryContestWidget({
    Key key,

    @required this.contest

  }) : super(key: key);

  final CourseProtocol contest;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          //margin: EdgeInsets.only(bottom: 40, top: 20),
          height: 150,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 22.0),
                    blurRadius: 22.0,
                    spreadRadius: 0,
                    color: Color.fromARGB(45, 0, 65, 255)
                ),
              ]
          ),
          child: Stack(
            children: [

              // the image
              Container(
                  width: 334,// MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "Assets/${contest.courseImage}",
                    fit: BoxFit.fitWidth,)
              ),

              // image cover
              Container(
                color: Color.fromARGB(90, 0, 0, 0),
              ),


              Row(
                children: <Widget>[

                  SizedBox(
                    width: 20,
                  ),

                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[


                        Text("${contest.courseName}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        /* Text(course.courseOverview,
                //overflow: TextOverflow,
                softWrap: false,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),

              */
                      ],
                    ),
                  ),

                  // container object for an image??
                  Container(
                    width: 335 / 2,
                    //child: Image.asset("Assets/${course.courseImage}"),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}