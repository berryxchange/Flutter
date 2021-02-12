import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Widgets/OrderHistoryCurrentWidget.dart';
import 'package:flutter_restaurant_app/Widgets/OrderHistoryPastWidget.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';
import 'package:flutter_restaurant_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OrderHistoryPage extends StatefulWidget {
  static String id = "/orderHistory";
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {

  //var firebaseSingleton = FirebaseUserSingleton.sharedInstance;

  //UserModel thisUser;
  List<OrderModel> previousOrders = List();
  List<OrderModel> currentOrders = List();




  void getCurrentUserCurrentOrders() async{

    /*
    try {
      if (FBSingleton.thisCurrentUser != null) {
        print("all good to go!");

        FBSingleton.currentOrdersRef = FBSingleton.database.reference().child('users').child("${FBSingleton.thisCurrentUser.uid}").child("CurrentOrders");
        FBSingleton.currentOrdersRef.onChildAdded.listen(_currentOrdersEvent);
        FBSingleton.currentOrdersRef.onChildRemoved.listen(_currentOrdersRemovedEvent);


      } else {
        print("this user is not in the database...");
      }
    }catch (error){
      print("something went wrong: $error");
    }

     */
  }

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
      setState(() {
        currentOrders.add(thisOrder);
      });
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
         setState(() {
           currentOrders.removeAt(currentOrderIndex);
         });
          print("${orderItem.orderName} has been removed");
        }
      }
    }
  }



  void getCurrentUserPastOrders() async{
    setState(() {
      //previousOrders = firebaseSingleton.setUserPreviousOrders();
    });

   // print("Previous orders main count: ${previousOrders.length}");
    /*
    try {
      if (FBSingleton.thisCurrentUser != null) {
        print("all good to go!");

        FBSingleton.pastOrdersRef = FBSingleton.database.reference().child('users').child("${FBSingleton.thisCurrentUser.uid}").child("PreviousOrders");
        FBSingleton.pastOrdersRef.onChildAdded.listen(_previousOrdersEvent);

      } else {
        print("this user is not in the database...");
      }
    }catch (error){
      print("something went wrong: $error");
    }
     */
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
      setState(() {
        previousOrders.add(thisOrder);
      });

      //thisOrder = thisOrder;
      //print(previousOrders.length);
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //thisUser = demoUserOne;
    getCurrentUserCurrentOrders();
    getCurrentUserPastOrders();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: TabBar(
              isScrollable: true,
              indicatorColor: ThemeData().primaryColor,
              tabs: [
                Text("Current",
                  style: TextStyle(
                      fontSize: 16,
                      color: ThemeData().primaryColor
                  ),
                ),
                Text("Past",
                  style: TextStyle(
                      fontSize: 16,
                      color: ThemeData().primaryColor
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                OrderHistoryCurrentListWidget(
                  //thisUser: thisUser,
                  //currentOrders: currentOrders,
                ),
                OrderHistoryPastListWidget(
                  //previousOrders: previousOrders,
                  //thisUser: thisUser,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
