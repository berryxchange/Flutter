import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Models/LessonModel.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';

class LessonPage extends StatefulWidget {
  final AcademyCourse course;
  final int currentLessonIndex;
  final int myCourseIndex;

  LessonPage(
      {@required this.course,
      @required this.currentLessonIndex,
      this.myCourseIndex});

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  AcademyLesson currentLesson;
  AcademyCourse course;
  int currentLessonIndex = 0;
  bool isFirst = false;
  bool isLast = false;
  List<int> ratingIndex = [];
  int myCourseIndex = 0;
  UserModel thisCurrentUser = demoUserOne;

  //------------- Rating --------------

  ratingAction(int index) {
    switch (index) {
      case 0:
        ratingIndex = [];
        ratingIndex = [0];
        print(ratingIndex);
        break;
      case 1:
        ratingIndex = [];
        ratingIndex = [0, 1];
        print(ratingIndex);
        break;
      case 2:
        ratingIndex = [];
        ratingIndex = [0, 1, 2];
        print(ratingIndex);
        break;
      case 3:
        ratingIndex = [];
        ratingIndex = [0, 1, 2, 3];
        print(ratingIndex);
        break;
      case 4:
        ratingIndex = [];
        ratingIndex = [0, 1, 2, 3, 4];
        print(ratingIndex);
    }
  }

  Color ratingStarColor(index) {
    if (ratingIndex.contains(index)) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  //------------- Set Lessons --------------

  setCurrentLesson(int currentLessonIndex) {
    currentLesson = course.courseLessons[currentLessonIndex];
    print(currentLessonIndex);
  }

  previousLesson() {
    isFirst = checkIfFirstLesson();
    (isFirst)
        ? print("Is the first lesson")
        : setState(() {
            currentLessonIndex = currentLessonIndex - 1;
            demoUserOne.myCourses[widget.myCourseIndex].currentLesson =
                currentLessonIndex;
          });
  }

  nextLesson() {
    isLast = checkIfLastLesson();
    (isLast)
        ? setState(() {
            print("is the end...");
          })
        : setState(() {
            currentLessonIndex = currentLessonIndex + 1;
            setCurrentLesson(currentLessonIndex);
            print("Current Index: $currentLessonIndex");
            demoUserOne.myCourses[widget.myCourseIndex].currentLesson =
                currentLessonIndex;
            print(
                "Your lesson index: ${demoUserOne.myCourses[widget.myCourseIndex].currentLesson}");
          });
  }

  //------------- Set Buttons --------------
  setPreviousButton() {
    if (currentLessonIndex == 0) {
      return MaterialButton();
    } else {
      return MaterialButton(
          child: Text(
            "Previous",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            previousLesson();
            print("Previous");
          });
    }
  }

  setNextButton() {
    if (currentLessonIndex == course.courseLessons.length - 1) {
      return MaterialButton(
          child: Text(
            "Complete",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          onPressed: () {
            nextLesson();
            print("Course has been completed!");
            currentLessonIndex = currentLessonIndex + 1;
            demoUserOne.myCourses[widget.myCourseIndex].currentLesson =
                currentLessonIndex;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("How would you rate this course?"),
                    content: Container(
                      height: 50,
                      width: 240, //MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return IconButton(
                            icon: Icon(
                              Icons.star,
                              size: 40,
                            ),
                            color: ratingStarColor(index),
                            onPressed: () {
                              setState(() {
                                ratingAction(index);
                              });
                            },
                          );
                        },
                      ),
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  );
                });
          });
    } else {
      return MaterialButton(
          child: Text(
            "Next",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            nextLesson();
            print("Next");
          });
    }
  }

  //------------- Check Lesson Count --------------
  bool checkIfFirstLesson() {
    if (currentLessonIndex != 0) {
      print("Not first");
      return false;
    } else {
      print("is the first");
      return true;
    }
  }

  bool checkIfLastLesson() {
    if (currentLessonIndex != course.courseLessons.length - 1) {
      print("Not last");
      return false;
    } else {
      print("is the last");
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    currentLessonIndex = widget.currentLessonIndex;
    print("Lesson Index: $currentLessonIndex");
    course = widget.course;
    setCurrentLesson(currentLessonIndex);
    myCourseIndex = widget.myCourseIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.courseName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "${currentLesson.lessonTitle}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "${currentLesson.lessonContent + currentLesson.lessonContent + " $currentLessonIndex"}",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
              color: Colors.grey,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  setPreviousButton(),
                  setNextButton(),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
