import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Models/DeliveryAddressModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Protocol
abstract class UserProtocol{
  String key;
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  String userName;
  String uid;
  String token;
  String paymentId;
  var imageUrl;
  int purchasePoints;
  List<CreditCardModel> cards;
  List<OrderModel> previousOrders;
  List<OrderModel> currentOrders;
  List<DeliveryAddressModel> deliveryAddresses;

  showUserDetails(){
    print("id: $id");
    print("first Name: $firstName");
    print("last Name: $lastName");
    print("email: $email");
    print("phone: $phone");
    print("password: $password");
    for (var address in deliveryAddresses){
      print("address: $address");
    }
    print("image: $imageUrl");

    for (var card in cards){
      print("card: $card");
    }
    for (var order in previousOrders){
      print("previous order: $order");
    }
    print("Purchase Points: $purchasePoints");
  }



  addPaymentToHistory({OrderModel paidOrder}){
    setUserOrdersToFBCurrentHistory(paidOrder);
  }

  addCardToList(CreditCardModel thisCard){
    this.cards.add(thisCard);
  }

  removeCardFromList(CreditCardModel thisCard){
    this.cards.remove(thisCard);
  }

  addAddressToList(DeliveryAddressProtocol address){
    this.deliveryAddresses.add(address);
  }

  removeAddressFromList(DeliveryAddressProtocol address){
    this.deliveryAddresses.remove(address);
  }


  //firebase Post
  void setUserOrdersToFBCurrentHistory(OrderModel thisNewOrder) async{

    //set references

    //create FB Singleton Instance to use its properties
    var firebase = FirebaseDatabase.instance;
    User firebaseUser = AuthCentral.auth.currentUser;

    print("OrderItem Inventory: ${thisNewOrder.orderItems.length}");
    print("OrderItem Inventory Name: ${thisNewOrder.orderItems[0].productName}");

    //check if user UID exists
    if (firebaseUser.uid != null) {
      print("all good to go sending to FB! the UID: ${firebaseUser.uid}");

      //Set References
      //main order List
      setCurrentOrder(firebase, thisNewOrder);
      setOrderItemsForCurrentOrder(firebase, thisNewOrder);
      setUserCurrentOrder(firebase, thisNewOrder, firebaseUser);
      setUserOrderItemsForCurrentOrder(firebase, thisNewOrder, firebaseUser);
      globalCurrentOrder.orderItems = [];
      /*setCurrentOrder(firebase, thisNewOrder).whenComplete((){
        //main order List Items
        setOrderItemsForCurrentOrder(firebase, thisNewOrder).whenComplete(() {
          //user order List
          setUserOrderItemsForCurrentOrder(firebase, thisNewOrder, firebaseUser).whenComplete(() {
            //user order List Items
            setUserCurrentOrder(firebase, thisNewOrder, firebaseUser).whenComplete(() {
              //globalCurrentOrder.onOrderComplete();
            });
          });
        });
      });

       */
    }
  }
}


Future setCurrentOrder(FirebaseDatabase firebase, OrderModel thisNewOrder)async{
  DatabaseReference mainCurrentOrdersRef;

  // current orders for the business
  mainCurrentOrdersRef = firebase.reference()
      .child("CurrentOrders")
      .child(thisNewOrder.orderName);

  //Then, wait till this post of the incoming order as JSON data Dictionary is finished
  await mainCurrentOrdersRef
      .update(thisNewOrder
      .toJson());
}

Future setOrderItemsForCurrentOrder(FirebaseDatabase firebase, OrderModel thisNewOrder)async{
  print("Setting Item To Order");
  for (var item in thisNewOrder.orderItems){
    print("Item posting: ${item.productName}");
    DatabaseReference currentOrdersItemsRef;


    //Reference
    currentOrdersItemsRef = firebase.reference()
        .child("CurrentOrders")
        .child(thisNewOrder.orderName)
        .child("orderItems")
        .child(item.productName.toLowerCase());

    //Set
    await currentOrdersItemsRef.update(item.toJson());
  }
}


Future setUserCurrentOrder(FirebaseDatabase firebase, OrderModel thisNewOrder, User firebaseUser)async{
  DatabaseReference currentOrdersRef;
  currentOrdersRef = firebase.reference()
      .child('users')
      .child("${firebaseUser.uid}")
      .child("CurrentOrders")
      .child(thisNewOrder.orderName);


  //Then, wait till this post of the incoming order as JSON data Dictionary is finished
  await currentOrdersRef
      .update(thisNewOrder
      .toJson());
}

Future setUserOrderItemsForCurrentOrder(FirebaseDatabase firebase, OrderModel thisNewOrder, User firebaseUser)async{
  DatabaseReference currentOrdersItemsRef;
  print("Setting Item To Order count ${thisNewOrder.orderItems.length}");
  for (var item in thisNewOrder.orderItems){
    print("Item posting: ${item.productName}");
    //Reference
    currentOrdersItemsRef = firebase.reference()
        .child('users')
        .child("${firebaseUser.uid}")
        .child("CurrentOrders")
        .child(thisNewOrder.orderName)
        .child("orderItems")
        .child(item.productName.toLowerCase());
    //Set
    await currentOrdersItemsRef.update(item.toJson());
  }
}




class UserModel extends UserProtocol {
  var key;
  var id = "0987654321";
  var firstName = "Quinton";
  var lastName = "D";
  var userName = "";
  var uid;
  var token;
  var paymentId;
  var imageUrl = "myUserImage.png";
  var email = "saminoske2@yahoo.com";
  var password = "";
  var phone = "4055555656";
  var purchasePoints = 95490;// could be used for something
  var cards = List();
  var deliveryAddresses = List();

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.uid,
    this.token,
    this.paymentId,
    this.imageUrl,
    this.email,
    this.password,
    this.phone,
    this.purchasePoints,
    this.cards,
    this.deliveryAddresses
  });

  UserModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        firstName = snapshot.value["firstName"],
        lastName = snapshot.value["lastName"],
        userName = snapshot.value["userName"],
        imageUrl = snapshot.value["imageUrl"],
        email = snapshot.value["email"],
        password = snapshot.value["password"],
        phone = snapshot.value["phone"],
        purchasePoints = snapshot.value["purchasePoints"],
        cards = snapshot.value["cards"],
        deliveryAddresses = snapshot.value["deliveryAddresses"],
        uid = snapshot.value["uid"],
        token = snapshot.value["token"],
        paymentId = snapshot.value["paymentId"];


  toJson() {
    return {
      //"id": id,
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "uid": uid,
      "imageUrl": imageUrl,
      "email": email,
      "password": password,
      "phone": phone,
      "token": token,
      "paymentId": paymentId
    };
  }

}



