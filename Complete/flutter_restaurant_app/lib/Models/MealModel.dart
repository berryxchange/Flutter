import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';
import 'package:secure_random/secure_random.dart';
import 'package:firebase_database/firebase_database.dart';

var _secureRandom = SecureRandom();
abstract class MealProtocol{
  String productName;
  int productPrice;
  var productImage;
  int productDuplicates;
  String productDescription;
  String productId;

  // for admins
  addProductToTheList({MealProtocol product}){
    popularMeals.add(product);
  }
  //-----------

  showMeal(){
    print("Product Name: $productName");
    print("Product Price: $productPrice");
    print("Product Image: $productImage");
    print("Product Description: $productDescription");
    print("ProductId $productId");
  }
}

class MealModel extends MealProtocol{
  var key;
  var productName = "Meal 1";
  var productPrice = 899;
  var productImage = "";
  var productDescription = "something about this meal 1";
  var productId = _secureRandom.nextString(length: 6);
  var productDuplicates;

  MealModel({
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productImage,
    this.productId,
    this.productDuplicates
  });

  MealModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        productName = snapshot.value["productName"],
        productPrice = snapshot.value["productPrice"],
        productDescription = snapshot.value["productDescription"],
        productImage = snapshot.value["productImage"],
        productId = snapshot.value["productId"],
        productDuplicates = snapshot.value["productDuplicates"];

  toJson() {
    return {
      "productName": productName,
      "productPrice": productPrice,
      "productDescription": productDescription,
      "productImage": productImage,
      "productId": productId,
      "productDuplicates": productDuplicates
    };
  }
}




