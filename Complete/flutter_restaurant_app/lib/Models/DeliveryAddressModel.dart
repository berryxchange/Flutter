import 'package:firebase_database/firebase_database.dart';

abstract class DeliveryAddressProtocol{
  String address;
  String city;
  String state;
  String zip;
  String apartmentNumber;
  bool isSelected;
}

class DeliveryAddressModel extends DeliveryAddressProtocol{
  var key;
  var address = "7708 N.W. 84th st";
  var city = "Oklahoma City";
  var state = "Oklahoma";
  var zip = "73132";
  var apartmentNumber = "";
  var isSelected = false;


  DeliveryAddressModel({
    this.address,
    this.city,
    this.state,
    this.zip,
    this.apartmentNumber,
    this.isSelected
  });

  DeliveryAddressModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        address = snapshot.value["address"],
        city = snapshot.value["city"],
        state = snapshot.value["state"],
        zip = snapshot.value["zip"],
        apartmentNumber = snapshot.value["apartmentNumber"],
        isSelected = snapshot.value["isSelected"];

  toJson() {
    return {
      "address": address,
      "city": city,
      "state": state,
      "zip": zip,
      "apartmentNumber": apartmentNumber,
      "isSelected": isSelected,
    };
  }
}

