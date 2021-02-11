import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';

class StaffPicksWidget extends StatelessWidget {
  const StaffPicksWidget({
    Key key,
    @required this.course,
  }) : super(key: key);

  final AcademyCourse course;

  String checkCoursePurchasesText(int coursePurchases){

    if (coursePurchases <= 999){
      // do nothing
    }else if (coursePurchases == 1000 || course.coursePurchases <= 999999){
      return "K";
    }else if (coursePurchases > 999999){
      return "M";
    }
    return "";
  }

  int checkCoursePurchasesNumber(int coursePurchases){

    if (coursePurchases <= 999){
      // do nothing
    }else if (coursePurchases == 1000 || course.coursePurchases <= 999999){
      return (coursePurchases / 1000).floor();
    }else if (coursePurchases > 999999){
      return (coursePurchases / 1000000).floor();
    }
    return coursePurchases;
  }

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
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                      "Assets/${course.courseImage}",
                  fit: BoxFit.fitWidth,)
              ),

              // image cover
              Container(
                color: Color.fromARGB(90, 0, 0, 0),
              ),

              Row(
                children: [

                  //Container for image?
                  Container(
                    width: 335 / 2.5,
                  ),

                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[


                        Text(course.courseName,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),

                        /*Text(course.courseDescription,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),

                 */
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye, color: Colors.white,),
                            SizedBox(width: 8,),
                            Text("${checkCoursePurchasesNumber(course.coursePurchases)}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                            Text(checkCoursePurchasesText(course.coursePurchases),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),

                            SizedBox(width: 16,),

                            Icon(Icons.star, color: Colors.white,),

                            SizedBox(width: 8,),

                            Text("4.6",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}