import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Screens/CoursePage.dart';
import 'package:the_academy_app_2020/Screens/LessonPage.dart';

abstract class LessonProtocol {
  var lessonImage;
  var lessonVideo;
  String lessonTitle;
  var lessonContent;
  var lessonCompletionTime;
  String lessonBrief;
  AcademyLesson lesson;

  previousLesson() {
    print("Shows next lesson");
  }

  nextLesson() {
    print("shows previous lesson");
  }

  // for Instructor
  setLessonImage({String choice}) {
    lessonImage = choice;
  }

  setLessonVideo({String choice}) {
    lessonVideo = choice;
  }

  setLessonTitle({String choice}) {
    lessonTitle = choice;
  }

  setLessonContent({String choice}) {
    lessonContent = choice;
  }

  setCompletionTime({var choice}) {
    lessonCompletionTime = choice;
  }

  // for debugging
  showLesson(BuildContext context, AcademyCourse course, int lessonIndex,
      int myCourseIndex) {
    print("Lesson Image: $lessonImage");
    print("Lesson Video: $lessonVideo");
    print("Lesson Title: $lessonTitle");
    print("Lesson Content: $lessonContent");
    print("Lesson Completion Time: $lessonCompletionTime");

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LessonPage(
        course: course,
        currentLessonIndex: lessonIndex,
        myCourseIndex: myCourseIndex,
      );
    }));
  }
}

class AcademyLesson extends LessonProtocol {
  var lessonImage = "Lesson1.jpg";
  var lessonVideo = "";
  String lessonTitle = "Lesson 1 - Lesson Intro";
  var lessonContent =
      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?";
  var lessonCompletionTime = 20;
  var lessonBrief;

  AcademyLesson(
      {this.lessonImage,
      this.lessonVideo,
      this.lessonTitle,
      this.lessonContent,
      this.lessonCompletionTime,
      this.lessonBrief});
}

List<AcademyLesson> demoLessons = [
  AcademyLesson(
      lessonImage: Image.asset("Lesson1.jpg"),
      lessonVideo: "",
      lessonTitle: "Lesson 1 - Lesson Intro",
      lessonContent:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      lessonCompletionTime: 20,
      lessonBrief: "Some short info on Part 1"),
  AcademyLesson(
      lessonImage: Image.asset("Lesson2.jpg"),
      lessonVideo: "",
      lessonTitle: "Lesson 2 - Lesson part 2",
      lessonContent:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      lessonCompletionTime: 7,
      lessonBrief: "Some short info on Part 2"),
  AcademyLesson(
      lessonImage: Image.asset("Lesson3.jpg"),
      lessonVideo: "",
      lessonTitle: "Lesson 3 - Lesson part 3",
      lessonContent:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      lessonCompletionTime: 10,
      lessonBrief: "Some short info on Part 3"),
  AcademyLesson(
      lessonImage: Image.asset("Lesson4.jpg"),
      lessonVideo: "",
      lessonTitle: "Lesson 4 - Lesson part 4",
      lessonContent:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      lessonCompletionTime: 15,
      lessonBrief: "Some short info on Part 4"),
];
