import 'package:firebase_database/firebase_database.dart';

class Bible{
  String key;
  final String bibleVersion;
  final String bibleLink;


  Bible(
      this.bibleVersion,
      this.bibleLink
      );

  Bible.fromSnapshot(DataSnapshot snapshot)
      :key = snapshot.key,
        bibleVersion = snapshot.value["bibleVersion"],
        bibleLink = snapshot.value["bibleLink"];


  toJson(){
    return{
      "bibleVersion": bibleVersion,
      "bibleLink": bibleLink,
    };
  }
}