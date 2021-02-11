import 'package:the_academy_app_2020/Models/LessonModel.dart';
import 'package:the_academy_app_2020/Models/ExamModel.dart';
import 'package:the_academy_app_2020/Models/CourseCostPackage.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:flutter/material.dart';

abstract class CourseProtocol {
  var courseImage;
  var courseIntroVideo;
  String courseId;
  String courseName;
  bool purchased;
  List<int> courseRating;
  int coursePurchases;
  String courseDescription;
  List<String> courseIncentives;
  String courseOverview;
  List<LessonProtocol> courseLessons;
  List<ExamProtocol> courseExams;
  List<CourseProtocol> coursesOfferedByThisInstructor;
  List<CourseCostPackageProtocol> courseCostPackages;
  int currentLesson = 0;

  //for the instructor
  setCourseName({String choice}) {
    courseName = choice;
  }

  setCourseDescription({String choice}) {
    courseDescription = choice;
  }

  addCourseIncentive({String choice}) {
    courseIncentives.add(choice);
  }

  setCourseOverview({String choice}) {
    courseOverview = choice;
  }

  addCourseLesson({LessonProtocol choice}) {
    courseLessons.add(choice);
  }

  addCourseExam({ExamProtocol choice}) {
    courseExams.add(choice);
  }

  addCourseCostPackage({CourseCostPackageProtocol choice}) {
    courseCostPackages.add(choice);
  }

  setCurrentLesson(int currentLessonIndex) {
    currentLesson = currentLessonIndex;
  }

  String checkCoursePurchasesAmountToString() {
    if (coursePurchases <= 999) {
      // do nothing
    } else if (coursePurchases == 1000 || coursePurchases <= 999999) {
      return "K";
    } else if (coursePurchases > 999999) {
      return "M";
    }
    return "";
  }

  int checkCoursePurchasesNumber() {
    if (coursePurchases <= 999) {
      // do nothing
    } else if (coursePurchases == 1000 || coursePurchases <= 999999) {
      return (coursePurchases / 1000).floor();
    } else if (coursePurchases > 999999) {
      return (coursePurchases / 1000000).floor();
    }
    return coursePurchases;
  }

  //checks to see if course is purchased or not (when displaying text or when a purchase has been made)
  String getPurchase(bool purchaseResult) {
    switch (purchaseResult) {
      case true:
        return "Purchased";
        break;
      case false:
        return "Not Purchased";
        break;
    }
    return "";
  }

//for the user
  void showOverview() {
    print("Shows overview");
  }

  void showLessons() {
    print("Shows Lessons");
  }

  void showExams() {
    print("Shows exams");
  }

  purchaseThisCourse(UserModel thisUser) {
    //Prompt course costs page
    //confirm
    //setState(() {
    thisUser.checkContainsCurrentCourse(this) == false
        ? thisUser.myCoursesId.add(courseId)
        : thisUser.myCoursesId.remove(courseId);
    //});

    //to cancel
    //prompt dialogue window to confirm

    // update purchase button text once the purchase is made or canceled
    updatePurchaseButtonText(thisUser);

    print(purchased);
  }

  /*void purchaseThisCourse(){
    print("Shows $courseName price packages");
  }

   */

  updatePurchaseButtonText(UserModel thisUser) {
    var buttonText = "";
    //setState(() {
    thisUser.checkContainsCurrentCourse(this) == false
        ? buttonText = "Take This Course"
        : buttonText = "Cancel This Course";
    //});
    return buttonText;
  }

  checkPurchase(UserModel thisUser) {
    //show button title
    var buttonText = updatePurchaseButtonText(thisUser);
    return buttonText;
    //allow courses to be clicked
  }

  void cancelThisPackage(UserModel thisUser) {
    print("canceling package");
    thisUser.myCoursesId.remove(this.courseId);
  }

  updateCourseLessonSelection(
      int index, UserModel thisUser, BuildContext context, int myCourseIndex) {
    thisUser.checkContainsCurrentCourse(this)
        ? courseLessons[index].showLesson(context, this, index, myCourseIndex)
        : print("Item not purchased..");
  }

  showCourseRating() {
    var number = courseRating.reduce((a, b) => a + b) / courseRating.length;
    if (number is int) {
      print(number);
      return number;
    } else if (number is double) {
      print((number.floor()));
      return number.floor();
    }
    return 0;
  }

  //for debugging
  showCourse() {
    print("courseId: $courseId");
    print("courseImage $courseImage");
    print("courseIntroVideo $courseIntroVideo");
    print("courseName $courseName");
    print("purchased $purchased");
    print("courseRating $courseRating");
    print("coursePurchases $coursePurchases");

    print("courseDescription $courseDescription");

    for (var incentive in courseIncentives) {
      print("courseIncentives $incentive");
    }

    print("courseOverview $courseOverview");

    for (var lesson in courseLessons) {
      print("courseLessons $lesson");
    }

    for (var exam in courseExams) {
      print("courseExams $exam");
    }

    for (var otherCourse in coursesOfferedByThisInstructor) {
      print("courseOfferedByThisInstructor $otherCourse");
    }

    for (var package in courseCostPackages) {
      print("courseCostPackages $package");
    }
  }
}

class AcademyCourse extends CourseProtocol {
  var courseId = "1234567890";
  var courseImage = "TravelingFranceCourse.jpg";
  var courseIntroVideo = "";
  var courseName = "Traveling in France 2020";
  var purchased = false;
  var courseRating = [2, 5, 2, 3, 1, 4, 4, 5];
  var coursePurchases = 4005;
  var courseDescription =
      "This course provides an overview of the travel and tourism profession.";
  var courseIncentives = [
    "Learn basic French",
    "Learn about French culture",
    "Learn about the history of France",
    "Opportunity for 2 week tour of France"
  ];
  var courseOverview =
      "This course is an introduction to the travel, tourism, and hospitality industry. It explores the structures, products and services of industry suppliers, such as transportation companies, attractions, hotels and other lodging providers, and of marketing organizations, such as travel agencies, tour packagers and destination-promotion organizations. The course provides students with an overview of this specific area of study with an emphasis on industry trends and future developments, terminology and an understanding on interrelationships of the three. ";
  var courseLessons = demoLessons;
  var courseExams = [];
  var coursesOfferedByThisInstructor = [];
  var courseCostPackages = [];
  var currentLesson = 0;

  AcademyCourse({
    this.courseId,
    this.courseImage,
    this.courseIntroVideo,
    this.courseName,
    this.purchased,
    this.courseRating,
    this.coursePurchases,
    this.courseDescription,
    this.courseIncentives,
    this.courseOverview,
    this.courseLessons,
    this.courseExams,
    this.coursesOfferedByThisInstructor,
    this.courseCostPackages,
    this.currentLesson,
  });
}

List<AcademyCourse> demoCourses = [
  AcademyCourse(
    courseId: "ABCDE12345",
    courseImage: "TravelingFranceCourse.jpg",
    courseIntroVideo: "",
    courseName: "Traveling in France 2020",
    purchased: false,
    courseRating: [2, 5, 2, 3, 1, 4, 4, 5],
    coursePurchases: 30,
    courseDescription:
        "This course provides an overview of the travel and tourism profession.",
    courseIncentives: [
      "Learn basic French",
      "Learn about French culture",
      "Learn about the history of France",
      "Opportunity for 2 week tour of France"
    ],
    courseOverview:
        "This course provides an overview of the travel and tourism profession. Students explore a full range of travel products and destinations, as well as the business and technical skills necessary to begin a productive travel career.",
    courseLessons: demoLessons,
    courseExams: [],
    coursesOfferedByThisInstructor: [],
    courseCostPackages: demoCoursePackages,
    currentLesson: 0,
  ),
  AcademyCourse(
    courseId: "ABCDE098765",
    courseImage: "TravelingFranceCourse.jpg",
    courseIntroVideo: "",
    courseName: "Traveling in Japan",
    purchased: true,
    courseRating: [2, 5, 2, 3, 1, 4, 4, 5],
    coursePurchases: 4010306,
    courseDescription:
        "This course provides an overview of the travel and tourism profession.",
    courseIncentives: [
      "Learn basic Japanese",
      "Learn about Japanese culture",
      "Learn about the history of Japan",
      "Opportunity for 2 week tour of Japan"
    ],
    courseOverview:
        "This course provides an overview of the travel and tourism profession. Students explore a full range of travel products and destinations, as well as the business and technical skills necessary to begin a productive travel career.",
    courseLessons: demoLessons,
    courseExams: [],
    coursesOfferedByThisInstructor: [],
    courseCostPackages: demoCoursePackages,
    currentLesson: 0,
  ),
  AcademyCourse(
    courseId: "ABCDE112233",
    courseImage: "TravelingFranceCourse.jpg",
    courseIntroVideo: "",
    courseName: "Traveling in Italy 2020",
    purchased: false,
    courseRating: [2, 5, 2, 3, 1, 4, 4, 5],
    coursePurchases: 3091,
    courseDescription:
        "This course provides an overview of the travel and tourism profession.",
    courseIncentives: [
      "Learn basic Italian",
      "Learn about Italian culture",
      "Learn about the history of Italy",
      "Opportunity for 2 week tour of Italy"
    ],
    courseOverview:
        "This course provides an overview of the travel and tourism profession. Students explore a full range of travel products and destinations, as well as the business and technical skills necessary to begin a productive travel career.",
    courseLessons: demoLessons,
    courseExams: [],
    coursesOfferedByThisInstructor: [],
    courseCostPackages: demoCoursePackages,
    currentLesson: 0,
  ),
  AcademyCourse(
    courseId: "ABCDE56789",
    courseImage: "TravelingFranceCourse.jpg",
    courseIntroVideo: "",
    courseName: "Traveling in China 2020",
    purchased: true,
    courseRating: [2, 5, 2, 3, 1, 4, 4, 5],
    coursePurchases: 17900033,
    courseDescription:
        "This course provides an overview of the travel and tourism profession.",
    courseIncentives: [
      "Learn basic China",
      "Learn about Chinese culture",
      "Learn about the history of China",
      "Opportunity for 2 week tour of China"
    ],
    courseOverview:
        "This course provides an overview of the travel and tourism profession. Students explore a full range of travel products and destinations, as well as the business and technical skills necessary to begin a productive travel career. This course provides an overview of the travel and tourism profession. Students explore a full range of travel products and destinations, as well as the business and technical skills necessary to begin a productive travel career. This course provides an overview of the travel and tourism profession. Students explore a full range of travel products and destinations, as well as the business and technical skills necessary to begin a productive travel career. This course provides an overview of the travel and tourism profession. Students explore a full range of travel products and destinations, as well as the business and technical skills necessary to begin a productive travel career. This course provides an overview of the travel and tourism profession. Students explore a full range of travel products and destinations, as well as the business and technical skills necessary to begin a productive travel career.",
    courseLessons: demoLessons,
    courseExams: [],
    coursesOfferedByThisInstructor: [],
    courseCostPackages: demoCoursePackages,
    currentLesson: 0,
  )
];
