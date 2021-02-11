import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_restaurant_app/Models/CreditCardModel.dart';
import 'package:flutter_restaurant_app/Models/DeliveryAddressModel.dart';

/*
//Singleton
class FirebaseUserSingleton{
  static final FirebaseUserSingleton sharedInstance = FirebaseUserSingleton._protected();// protects data (the lock)

  //Firebase References
  DatabaseReference userRef;
  DatabaseReference pastOrdersRef;
  DatabaseReference pastOrderItemsRef;
  DatabaseReference cardsRef;
  DatabaseReference addressesRef;
  DatabaseReference currentOrdersRef;

  User thisCurrentUser;


  //Finals
  final FirebaseDatabase database = FirebaseDatabase.instance;//FirebaseDatabase.instance;
  FirebaseAuth _auth = AuthCentral.auth;


  //Models
  UserModel thisUser = UserModel();


  //Initializers
  List<CreditCardModel> cards = List();
  List<OrderModel> previousOrders = List();
  List<OrderModel> currentOrders = List();
  List<DeliveryAddressModel> deliveryAddresses = List();
  OrderModel currentOrder;





  // allows data to be findable
  factory FirebaseUserSingleton(){
    return sharedInstance;
  }

  //voids

  //sets up the user for the whole app lifecycle
  void getCurrentUser() async{
    try {
      final thisUser = _auth.currentUser;

      if (thisUser != null) {
        thisCurrentUser = thisUser;
        print("This User has been identified");

        //Initialize data
        setUserData(thisCurrentUser: thisCurrentUser);

        //Initialize references



        currentOrdersRef = database.reference().child('users').child("${thisCurrentUser.uid}").child("CurrentOrders");
        pastOrdersRef = database.reference().child('users').child("${thisCurrentUser.uid}").child("PreviousOrders");

        //Adding Listeners to references
        userRef.onChildAdded.listen(_currentUsersEvent);


        currentOrdersRef.onChildAdded.listen(_currentOrdersEvent);
        currentOrdersRef.onChildRemoved.listen(_currentOrdersRemovedEvent);


        print("All data has been setup");

      } else {
        print("this user is not in the database...");
      }
    }catch (error){
      print("something went wrong: $error");
    }
  }
//-----------------------------------------------------------------------------

  //For userData
  setUserData({User thisCurrentUser})async {
    //Instances & listeners
    userRef = database.reference().child('users').child("${thisCurrentUser.uid}");
    userRef.onChildAdded.listen(_currentUsersEvent);
  }

  //Listeners
  _currentUsersEvent(Event event) {
    var trueUser = UserModel.fromSnapshot(event.snapshot);
    if (trueUser.userName != null) {
      if(trueUser.uid == thisCurrentUser.uid){
        print("The current user matches");
        thisUser = trueUser;
      }
    }
  }
  //----------------



  //For userAddressData
  setUserAddressData(){
    User thisCurrentAddressUser = _auth.currentUser;
    //Instances & listeners
    addressesRef = database.reference().child('users').child("${thisCurrentAddressUser.uid}").child("Addresses");
    addressesRef.onChildAdded.listen(_currentUsersAddressesEvent);

    print("Address Count: ${deliveryAddresses.length}");
  }

  _currentUsersAddressesEvent(Event event) {
    var thisAddress = DeliveryAddressModel.fromSnapshot(event.snapshot);
    if (thisAddress.address != null) {
      deliveryAddresses.add(thisAddress);
    }
  }
//----------------


//for cards
setUserCardData(){
//Instances & listeners
cardsRef =  database.reference().child('users').child("${thisCurrentUser.uid}").child("Cards");
cardsRef.onChildAdded.listen(_currentUsersCardsEvent);
}
  _currentUsersCardsEvent(Event event) {

    //thisUserInfo
    var thisCard = CreditCardModel.fromSnapshot(event.snapshot);
    print(event.snapshot.toString());
    if (thisCard.cardHolderName != null) {
      cards.add(thisCard);
      //thisCard = thisCard;
    }
  }
  //----------------


  //setting previous orders
  setUserPreviousOrders(){
    print("getting previous orders");
    User thisPreviousOrdersUser = _auth.currentUser;
    //Instances & listeners
    pastOrdersRef = database.reference().child('users').child("${thisPreviousOrdersUser.uid}").child("PreviousOrders");
    pastOrdersRef.onChildAdded.listen(_previousOrdersEvent);
    print("PreviousOrders Count: ${previousOrders.length}");
    return previousOrders;
  }

  _previousOrdersEvent(Event event) {
    var thisOrder = OrderModel.fromSnapshot(event.snapshot);
    if (thisOrder.orderName != null) {

      var thisOrderItems = thisOrder.loggedOrderItems.values;
      print(thisOrderItems.length);

      for (var item in thisOrderItems){
        var orderItem = MealModel(
            productName: item["productName"],
            productPrice: item["productPrice"],
            productDescription: item["productDescription"],
            productImage: item["productImage"],
            productId: item["productId"],
            productDuplicates: item["productDuplicates"]
        );
        print(orderItem.productName);
        thisOrder.orderItems.add(orderItem);
      }
      previousOrders.add(thisOrder);
    }
  }
  //----------------


  _currentOrdersEvent(Event event) {

    print("getting current items");
    var thisOrder = OrderModel.fromSnapshot(event.snapshot);
    if (thisOrder.orderName != null) {

      var thisOrderItems = thisOrder.loggedOrderItems.values;
      print(thisOrderItems.length);

      for (var item in thisOrderItems){
        var orderItem = MealModel(
            productName: item["productName"],
            productPrice: item["productPrice"],
            productDescription: item["productDescription"],
            productImage: item["productImage"],
            productId: item["productId"],
            productDuplicates: item["productDuplicates"]
        );
        print(orderItem.productName);
        thisOrder.orderItems.add(orderItem);
      }
      currentOrders.add(thisOrder);
      //thisOrder = thisOrder;
    }
  }

  _currentOrdersRemovedEvent(Event event) {
    print("getting current items");
    var thisOrder = OrderModel.fromSnapshot(event.snapshot);
    if (thisOrder.orderName != null) {
      for (var orderItem in currentOrders){
        if (orderItem.orderName == thisOrder.key){
          var currentOrderIndex = currentOrders.indexOf(orderItem);
          currentOrders.removeAt(currentOrderIndex);
          print("${orderItem.orderName} has been removed");
        }
      }
    }
  }

  //protected data to use
  FirebaseUserSingleton._protected(){
    // put protected data here

  }
}

 */