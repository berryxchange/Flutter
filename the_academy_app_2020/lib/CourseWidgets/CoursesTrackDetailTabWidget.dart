import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Models/LessonModel.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Screens/CoursePage.dart';

class CoursesTrackDetailTabWidget extends StatefulWidget {
  final AcademyCourse course;
  final UserModel thisCurrentUser;
  final int myCourseIndex;

  CoursesTrackDetailTabWidget(
      {this.course, this.thisCurrentUser, this.myCourseIndex});

  @override
  _CoursesTrackDetailTabWidgetState createState() =>
      _CoursesTrackDetailTabWidgetState();
}

class _CoursesTrackDetailTabWidgetState
    extends State<CoursesTrackDetailTabWidget> {
  List<Widget> checkDotColor(
      CourseProtocol course, List<LessonProtocol> courseList) {
    List<Widget> items = List();

    for (var l in courseList) {
      var index = 0;

      index = courseList.indexWhere((element) {
        return element.lessonTitle == l.lessonTitle;
      });

      Color color;
      if (widget.course.currentLesson >= index) {
        print("This course is the same index: $index");
        color = Colors.blue;
      } else {
        print("no data... index: $index");
        color = Colors.grey;
      }

      items.add(Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  //width: 10,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: color,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${course.courseName} " + "${l.lessonTitle}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(l.lessonBrief),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
    }
    return items;
  }

  List<Widget> courseLessons(BuildContext context, List<LessonProtocol> lesson,
      CourseProtocol course, int currentCourseIndex) {
    List<Widget> items = checkDotColor(course, lesson);

    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    //checkDotColor();
    print(
        "Your lesson index: ${demoUserOne.myCourses[widget.myCourseIndex].currentLesson}");
    print(
        "Your lessons count: ${demoUserOne.myCourses[widget.myCourseIndex].courseLessons.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double availableWith = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: CircularPercentIndicator(
                      radius: 80,
                      lineWidth: 9,
                      percent: widget.course.currentLesson /
                          demoUserOne.myCourses[widget.myCourseIndex]
                              .courseLessons.length
                              .toDouble(),
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.course.currentLesson / demoUserOne.myCourses[widget.myCourseIndex].courseLessons.length * 100.toDouble()}%",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "Complete",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      progressColor: Color(0xff009688),
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Text(
                      widget.course.courseName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        //color: Colors.white
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
                child: Column(
              children: courseLessons(context, widget.course.courseLessons,
                  widget.course, widget.myCourseIndex),
            )),
            /*Container(
              height: 100,
              width: 200,
              child: ListView.builder(
                  itemCount: widget.course.courseLessons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Text(widget.course.courseName),
                        Text(widget.course.courseName)
                      ],
                    );
                  }),
            ),

             */
            SizedBox(
              height: 8,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: OutlineButton(
                  onPressed: () {
                    print("continuing ${widget.course.courseName}");
                    //segue to course page or lesson page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CoursePage(
                        course: widget.course,
                        thisCurrentUser: widget.thisCurrentUser,
                        myCourseIndex: widget.myCourseIndex,
                      );
                    }));
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Icon(Icons.play_arrow), Text("Continue")],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
    /*
      Expanded(
      child: Container(
        //margin: EdgeInsets.only(bottom: 40, top: 20),
        //height: 300,
        width: 335,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 22.0),
                  blurRadius: 22.0,
                  spreadRadius: 0,
                  color: Color.fromARGB(45, 0, 65, 255)),
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Container(
            height: 200,
            color: Colors.red,
            child: Row(
              children: [
                Container(
                  height: 300,
                  color: Colors.yellow,
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    children: [Text("Yo")],
                  ),
                ),
                Container(
                  height: 300,
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.course.courseName,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 200,
                        child: ListView.builder(
                            itemCount: widget.course.courseLessons.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Text(widget.course.courseName),
                                  Text(widget.course.courseName)
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "4.6",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "K",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    */
  }
}
