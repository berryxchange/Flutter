import 'package:firebase_database/firebase_database.dart';

class Prayer{

  String key;
  String prayerTitle;
  String prayerMessage;
  //int prayerPostAgreements;
  String prayerPostDay;
  String prayerPostMonth;
  String prayerFullDate;
  String byUserName;
  String byUserUID;



  Prayer(
      this.prayerTitle,
      this.prayerMessage,
      //this.prayerPostAgreements,
      this.prayerPostDay,
      this.prayerPostMonth,
      this.prayerFullDate,
      this.byUserName,
      this.byUserUID
      );

  Prayer.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        prayerTitle = snapshot.value["prayerPostTitle"],
        prayerMessage = snapshot.value["prayerPostMessage"],
        //prayerPostAgreements = snapshot.value["prayerPostAgreements"],
        prayerPostMonth = snapshot.value["prayerPostDateMonth"],
        prayerPostDay = snapshot.value["prayerPostDateDay"],
        prayerFullDate = snapshot.value["prayerFullDate"],
        byUserName = snapshot.value["byUserName"],
        byUserUID = snapshot.value["byUserUID"];


  toJson() {
    return {
      "prayerPostTitle": prayerTitle,
      "prayerPostMessage": prayerMessage,
      //"prayerPostAgreements": prayerPostAgreements,
      "prayerPostDateDay": prayerPostDay,
      "prayerPostDateMonth": prayerPostMonth,
      "prayerFullDate": prayerFullDate,
      "byUserName": byUserName,
      "byUserUID": byUserUID,
    };
  }
}