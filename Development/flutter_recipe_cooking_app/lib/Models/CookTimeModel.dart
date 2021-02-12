abstract class CookTimeProtocol {
  var prepTimeHours;
  var prepTimeMinutes;
  var cookTimeHours;
  var cookTimeMinutes;
  //var readyTime;

  int getReadyTime() {
    return prepTimeMinutes + cookTimeMinutes;
  }
}

class CookTimeModel extends CookTimeProtocol {
  var prepTimeHours = 0;
  var prepTimeMinutes = 20;
  var cookTimeHours = 0;
  var cookTimeMinutes = 15;
  //var readyTime = 0;

  CookTimeModel({
    this.cookTimeHours,
    this.cookTimeMinutes,
    this.prepTimeHours,
    this.prepTimeMinutes,
    //this.readyTime
  });
}

var fettuccineCookTime = CookTimeModel(
  cookTimeHours: 0,
  cookTimeMinutes: 20,
  prepTimeHours: 0,
  prepTimeMinutes: 15,
  //readyTime: 0
);
