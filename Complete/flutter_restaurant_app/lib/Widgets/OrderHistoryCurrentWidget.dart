import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Firebase/Authentication/Auth.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Pages/OrderHistory/OrderHistoryDetailPage/OrderHistoryDetailPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_restaurant_app/Globals/FirebaseSingleton.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OrderHistoryCurrentListWidget extends StatefulWidget {
  //final List<OrderModel> currentOrders;
  //OrderHistoryCurrentListWidget({this.currentOrders,});

  @override
  _OrderHistoryCurrentListWidgetState createState() => _OrderHistoryCurrentListWidgetState();
}

class _OrderHistoryCurrentListWidgetState extends State<OrderHistoryCurrentListWidget> {

  User firebaseUser;
  List<OrderModel> currentOrders = List();
  DatabaseReference currentOrdersRef;
  DatabaseReference currentOrderItemsRef;
  final FirebaseDatabase database = FirebaseDatabase.instance;//FirebaseDatabase.instance;

  int checkOrder(){
    if (currentOrders != null){
      return currentOrders.length;
    }else{
      return 0;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseUser = AuthCentral.auth.currentUser;
    currentOrdersRef = database.reference().child("users").child(firebaseUser.uid).child("CurrentOrders");
    currentOrdersRef.onChildAdded.listen(_currentOrdersEvent);
    //currentOrdersRef.onValue.listen(_currentOrdersEvent);
    currentOrdersRef.onChildRemoved.listen(_currentOrdersRemovedEvent);
  }

  _currentOrdersEvent(Event event) async {

    print("getting current items");

    var thisOrder = OrderModel.fromSnapshot(event.snapshot);

    setState(() {
      currentOrders.add(thisOrder);
    });

  }

  checkPrice(OrderModel thisOrder){
    if (thisOrder.orderTotalCost != null){
      return Text("\$${thisOrder.orderTotalCost/100}",
        style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      );
    }else {
      //do something
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



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: FirebaseAnimatedList(
        query: currentOrdersRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
          var thisOrder = currentOrders[index];

          return Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) {
                      return OrderHistoryDetailPage(thisOrder: thisOrder,
                        timePeriod: "current",);
                    },
                  ),
                  );
                },
                child: Container(
                  //color: Colors.red,
                  height: 140,
                  //width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(1, 1),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.5                          )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(

                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.red,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(30, 0, 0, 0),
                                          offset: Offset(1, 1),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.5                          )
                                    ],
                                  ),
                                ),

                                //SizedBox(width: 20,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${thisOrder.purchaseDate}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Order#: ${thisOrder.orderName}",
                                      style: TextStyle(
                                        //color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    Text(
                                      "Items: ${thisOrder.setOrderTotalItemsCount().toString()}",
                                      style: TextStyle(
                                        //color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                    Text("${thisOrder.orderStatus}",
                                      style: TextStyle(
                                        //color: Colors.grey,
                                          fontSize: 14,
                                          color: thisOrder.checkOrderStatusColor()
                                      ),)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    checkPrice(thisOrder),
                                    Text("Details",
                                      style: TextStyle(
                                        color: ThemeData().primaryColor,
                                        fontSize: 16,
                                        //fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      )
    );
  }
}