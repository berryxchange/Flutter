import 'package:the_academy_app_2020/Models/CourseModel.dart';

abstract class CourseCategoryProtocol{
  String courseCategoryName;
  var courseCategoryImage;
  //List<CourseCategoryProtocol> categories = List();
  List<CourseProtocol> categoryCourses = List();
  List<CourseProtocol> categorySections;// used to host all categories
  List<CourseProtocol> categoryContests = List();
  List<CourseCategoryProtocol> categoryMembershipCourses = List();
  List<CourseCategoryProtocol> categoryCourseByCourse = List();
  List<CourseCategoryProtocol> categoryClassByClass = List();

  setCategoryName({String choice }){
    courseCategoryName = choice;
  }

  setCategoryImage({String choice }){
    courseCategoryImage = choice;
  }

  addCategoryCourseToList(CourseProtocol choice){
    categoryCourses.add(choice);
  }

  addSectionToList(CourseProtocol choice){
    categorySections.add(choice);
  }

  addContestToList(CourseProtocol choice){
    categoryContests.add(choice);
  }

  addMembershipCourseToList(CourseCategoryProtocol choice){
    categoryMembershipCourses.add(choice);
  }

  addCourseToList(CourseCategoryProtocol choice){
    categoryCourseByCourse.add(choice);
  }

  addClassToList(CourseCategoryProtocol choice){
    categoryClassByClass.add(choice);
  }



  showCategory(){
    print("Category Name: $courseCategoryName");
    print("Category Image: $courseCategoryImage");

    for (var section in categorySections){
      print("Section: $section");
    }

    for (var contest in categoryContests){
      print("Contest: $contest");
    }

    for (var membership in categoryMembershipCourses){
      print("Membership Course: $membership");
    }

    for (var course in categoryCourseByCourse){
      print("Course: $course");
    }

    for (var classCourse in categoryClassByClass){
      print("Class: $classCourse");
    }
  }
}

class AcademyCategory extends CourseCategoryProtocol{
  var courseCategoryName = "Travel";
  var courseCategoryImage = "TravelCategoryImage.png";

  //List<CourseCategoryProtocol> categories = List();
  //List<CourseProtocol> categorySections = demoCourses;// used to host all categories
  var categoryCourses = [];
  var categoryContests = demoCourses;
  var categoryMembershipCourses = [];
  var categoryCourseByCourse = [];
  var categoryClassByClass = [];


  AcademyCategory({
    //this.categories,
    this.categoryCourses,
    this.courseCategoryName,
    this.courseCategoryImage,
    this.categoryContests,
    this.categoryMembershipCourses,
    this.categoryCourseByCourse,
    this.categoryClassByClass

  });
}
List<AcademyCategory> demoTopCategories = [ AcademyCategory(
    courseCategoryName: "Travel",
    courseCategoryImage: "TravelCategoryImage.png",
    //categories: demoCategories,
    categoryContests: demoCourses,
    categoryMembershipCourses: demoSubCategories,
    categoryCourseByCourse: demoSubCategories,
    categoryClassByClass: demoSubCategories
),
  AcademyCategory(
      courseCategoryName: "Foreign Language",
      courseCategoryImage: "TravelCategoryImage.png",
      //categories: demoCategories,
      categoryContests: demoCourses,
      categoryMembershipCourses: demoSubCategories,
      categoryCourseByCourse: demoSubCategories,
      categoryClassByClass: demoSubCategories
  ),
  AcademyCategory(
      courseCategoryName: "Photography",
      courseCategoryImage: "TravelCategoryImage.png",
      //categories: demoCategories,
      categoryContests: demoCourses,
      categoryMembershipCourses: demoSubCategories,
      categoryCourseByCourse: demoSubCategories,
      categoryClassByClass: demoSubCategories
  ),
  AcademyCategory(
      courseCategoryName: "Computer Programming",
      courseCategoryImage: "TravelCategoryImage.png",
      //categories: demoCategories,
      categoryContests: demoCourses,
      categoryMembershipCourses: demoSubCategories,
      categoryCourseByCourse: demoSubCategories,
      categoryClassByClass: demoSubCategories
  ),
  AcademyCategory(
      courseCategoryName: "Design",
      courseCategoryImage: "TravelCategoryImage.png",
      //categories: demoCategories,
      categoryContests: demoCourses,
      categoryMembershipCourses: demoSubCategories,
      categoryCourseByCourse: demoSubCategories,
      categoryClassByClass: demoSubCategories
  ),
];

List<AcademyCategory> demoSubCategories = [
  AcademyCategory(
    courseCategoryName: "Travel",
    courseCategoryImage: "TravelCategoryImage.png",
    categoryCourses: demoCourses,
  ),
  AcademyCategory(
    courseCategoryName: "Foreign Language",
    courseCategoryImage: "TravelCategoryImage.png",
    categoryCourses: demoCourses,
  ),
  AcademyCategory(
    courseCategoryName: "Photography",
    courseCategoryImage: "TravelCategoryImage.png",
    categoryCourses: demoCourses,

  ),
  AcademyCategory(
    courseCategoryName: "Computer Programming",
    courseCategoryImage: "TravelCategoryImage.png",
    categoryCourses: demoCourses,
  ),
  AcademyCategory(
    courseCategoryName: "Design",
    courseCategoryImage: "TravelCategoryImage.png",
    categoryCourses: demoCourses,
  ),
];