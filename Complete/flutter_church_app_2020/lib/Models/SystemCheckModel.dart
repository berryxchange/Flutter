import 'package:firebase_database/firebase_database.dart';

class SystemCheckModel{
  String key;
  bool inUse;
  SystemCheckModel(this.inUse);

  SystemCheckModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        inUse = snapshot.value["inUse"];


  checksToJson(){
    return {
      "inUse": false
    };
  }
}
