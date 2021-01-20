abstract class CourseCostPackageProtocol{
  String packageTitle;
  String packageDescription;
  double packageCost;
  String packageTerm; // month / year

  void buyThisPackage(){
   // do something
  }
  void cancelThisPackage(){
    //do something
  }
}

class CourseCostPackage extends CourseCostPackageProtocol{
  var packageTitle = "Premium - Access Pass";
  var packageDescription = "You will get an unlimited access to every class and course from this teacher you want for a year. This pass auto renews anually";
  var packageCost = 99999;
  var packageTerm = "Year";

  CourseCostPackage({
    this.packageTitle,
    this.packageDescription,
    this.packageCost,
    this.packageTerm
  });
}

List<CourseCostPackage> demoCoursePackages = [
  CourseCostPackage(
  packageTitle: "Premium - Access Pass",
  packageDescription: "You will get an unlimited access to every class and course from this teacher you want for a year. This pass auto renews anually",
  packageCost: 99999,
  packageTerm: "Year",
  ),
  CourseCostPackage(
      packageTitle: "All - Access Pass",
      packageDescription: "A good choice for anyone looking to learn about this course specifically",
      packageCost: 49999,
      packageTerm: "Year",
  ),
  CourseCostPackage(
      packageTitle: "This Class Only",
      packageDescription: "A good choice for anyone looking to learn about this course specifically",
      packageCost: 4999,
      packageTerm: "Year",
  ),
];