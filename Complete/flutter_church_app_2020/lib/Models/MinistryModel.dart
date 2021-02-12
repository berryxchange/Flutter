import 'package:firebase_database/firebase_database.dart';


abstract class MinistryProtocol {
  String ministryImage;
  String ministryName;
  String ministrySubtitle;
  String ministryDestination;
}


class MinistryModel extends MinistryProtocol{
  String key;
  var ministryImage;
  var ministryName;
  var ministrySubtitle;
  var ministryDestination;

  MinistryModel(
      this.ministryImage,
      this.ministryName,
      this.ministrySubtitle,
      this.ministryDestination);

  MinistryModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        ministryImage = snapshot.value["ministryImage"],
        ministryName = snapshot.value["ministryName"],
        ministrySubtitle = snapshot.value["ministrySubtitle"],
        ministryDestination = snapshot.value["ministryDestination"];


  Future<bool> checksFromSnapshot(DataSnapshot snapshot) async{
    key = snapshot.key;
    bool isInUse;
    isInUse = snapshot.value["inUse"];
    return isInUse;
  }

  toJson() {
    return {
      "ministryImage": ministryImage,
      "ministryName": ministryName,
      "ministrySubtitle": ministrySubtitle,
      "ministryDestination": ministryDestination,
    };
  }
  checksToJson(){
    return {
      "inUse": false
    };
  }
}
