import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseCategoryModel.dart';
//import 'package:the_academy_app_2020/Models/CourseCategoryModel.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';

class CategoryClassByClassWidget extends StatelessWidget {
  const CategoryClassByClassWidget({
    Key key,

    @required this.category

  }) : super(key: key);

  final CourseCategoryProtocol category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
          width: 167,
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
          child: Column(
            children: <Widget>[
              Container(
                width: 167,
                height: 82 ,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 0,
                          color: Colors.white
                      ),
                    ]
                ),
                child: Image.asset(
                  "Assets/${category.courseCategoryImage}",
                  fit: BoxFit.fitWidth,)
                ,
              ),

              SizedBox(
                height: 20,
              ),

              Text(
                category.courseCategoryName,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),

            ],
          )
      ),
    );
  }
}