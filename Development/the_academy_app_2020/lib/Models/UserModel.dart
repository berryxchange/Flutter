import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Models/CreditCardModel.dart';
import 'package:the_academy_app_2020/Models/FinanceModel.dart';
import 'package:the_academy_app_2020/Models/paymentModel.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';
import 'package:the_academy_app_2020/Models/LessonModel.dart';
import 'package:the_academy_app_2020/Models/CourseCostPackage.dart';
import 'package:flutter/material.dart';

abstract class UserProtocol {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  var imageUrl;
  FinanceProtocol finance;
  List<String> myCoursesId = List();
  int cPPoints;
  List<CourseProtocol> myCourses = List();

  bool checkContainsCurrentCourse(AcademyCourse course) {
    if (myCoursesId.contains(course.courseId)) {
      print("You are currently taking this Course: ${course.courseName}");
      return true;
    } else {
      print("Sorry you are not currently taking this course..");
      return false;
    }
  }

  addPaymentToHistory(PaymentModel paidItem) {
    this.finance.previousPayments.add(paidItem);
    //append purchase to the previous payments list
  }

  addCardToList(CreditCardModel thisCard) {
    this.finance.cOF.add(thisCard);
  }

  addCourseToList(CourseProtocol course) {
    myCourses.add(course);
  }
}

class UserModel extends UserProtocol {
  var id = 0987654321;
  var firstName = "Quinton";
  var lastName = "D";
  var imageUrl = "myUserImage.png";
  var email = "saminoske2@yahoo.com";
  var phone = "4055555656";
  var finance;
  var myCoursesId = [];
  var cPPoints = 95490;
  var myCourses = [];

  bool checkContainsCurrentCourse(AcademyCourse course) {
    if (myCoursesId.contains(course.courseId)) {
      print("You are currently taking this Course: ${course.courseName}");
      return true;
    } else {
      print("Sorry you are not currently taking this course..");
      return false;
    }
  }

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.email,
    this.phone,
    this.finance,
    this.myCoursesId,
    this.cPPoints,
    this.myCourses,
  });
}

var demoUserOne = UserModel(
    id: 0987654321,
    firstName: "Quinton",
    lastName: "D",
    imageUrl: "myUserImage.png",
    email: "saminoske2@yahoo.com",
    phone: "4055555656",
    finance: myFinanceOne,
    myCoursesId: [],
    cPPoints: 95490,
    myCourses: []);

var demoUserTwo = UserModel(
    id: 0987654321,
    firstName: "Danny",
    lastName: "D",
    imageUrl: "myUserImage.png",
    email: "DannyD@yahoo.com",
    phone: "4055555656",
    finance: myFinanceTwo,
    myCoursesId: [],
    cPPoints: 1029304);
