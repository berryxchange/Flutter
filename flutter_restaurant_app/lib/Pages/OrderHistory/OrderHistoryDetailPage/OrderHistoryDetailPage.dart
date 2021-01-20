import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';
import 'package:flutter_restaurant_app/Widgets/FloatingCardWidget.dart';
import 'package:flutter_restaurant_app/Widgets/MainButtonWidgets.dart';
import 'package:flutter_restaurant_app/Widgets/OrderHistoryCartListWidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';

class OrderHistoryDetailPage extends StatefulWidget {
  final OrderModel thisOrder;
  final timePeriod;

  OrderHistoryDetailPage({this.thisOrder, this.timePeriod});

  @override
  _OrderHistoryDetailPageState createState() => _OrderHistoryDetailPageState();
}



class _OrderHistoryDetailPageState extends State<OrderHistoryDetailPage> {

  DatabaseReference currentOrdersRef;
  DatabaseReference previousOrdersRef;
  DatabaseReference currentOrderItemsRef;
  DatabaseReference previousOrderItemsRef;
  DatabaseReference userPreviousOrderItemsRef;
  DatabaseReference userCurrentOrderItemsRef;
  DatabaseReference userCurrentOrdersRef;
  DatabaseReference userPreviousOrdersRef;

  final FirebaseDatabase database = FirebaseDatabase.instance;//FirebaseDatabase.instance;

  OrderModel thisOrder;

  var cardStartIndex = 12;
  var cardEndIndex = 16;
  List<int> ratingIndex = [];

  Color ratingStarColor(index){
    if (ratingIndex.contains(index)){
      return ThemeData().primaryColor;
    }else{
      return Colors.grey;
    }
  }

  checkTimelineForButton(){
    switch(widget.timePeriod){
      case "current":
        break;
      case "past":
        return MainButtonWidget(
          text: "Report an issue with Order",
          onPressed: (){
            print("Sending Issue form");
          },
        );
    }
  }

  checkTimelineForItems(){
    switch(widget.timePeriod){
      case "current":
        print(widget.timePeriod);
        userCurrentOrderItemsRef = database.reference().child('users').child("${widget.thisOrder.orderUserId}").child("CurrentOrders").child(thisOrder.orderName).child("orderItems");
        userCurrentOrderItemsRef.onChildAdded.listen(_currentOrderItemsEvent);

        break;
      case "past":
        print(widget.timePeriod);
        userPreviousOrderItemsRef = database.reference().child('users').child("${widget.thisOrder.orderUserId}").child("PreviousOrders").child(thisOrder.orderName).child("orderItems");
        userPreviousOrderItemsRef.onChildAdded.listen(_previousOrderItemsEvent);
    }
  }

  EdgeInsets orderHistoryPadding(){
    switch(widget.timePeriod){
      case "current":
        return EdgeInsets.only(top:0, left: 12, right: 12, bottom: 0);
        break;
      case "past":
        return EdgeInsets.only(top:0, left: 12, right: 12, bottom: 100);
    }
    return EdgeInsets.only(top:0, left: 0, right: 0, bottom: 0);;
  }


  ratingAction(int index){
    switch(index){
      case 0:
        ratingIndex = [];
        ratingIndex = [0];
        break;
      case 1:
        ratingIndex = [];
        ratingIndex = [0, 1];
        break;
      case 2:
        ratingIndex = [];
        ratingIndex = [0, 1, 2];
        break;
      case 3:
        ratingIndex = [];
        ratingIndex = [0, 1, 2, 3];
        break;
      case 4:
        ratingIndex = [];
        ratingIndex = [0, 1, 2, 3, 4];
    }

  }


  showCardNumber(){
    var cardNumb = widget.thisOrder.paymentCardNumber;
    var lastFourDigits = cardNumb.substring(cardNumb.length - 4);
    return "**** **** **** $lastFourDigits";
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    thisOrder = widget.thisOrder;
    thisOrder.orderItems = List();
    checkTimelineForItems();
  }


  _currentOrderItemsEvent(Event event) async {
    var thisOrderItem = MealModel.fromSnapshot(event.snapshot);

    print(thisOrderItem.productName);
    setState(() {
      thisOrder.orderItems.add(thisOrderItem);
    });
  }

  _previousOrderItemsEvent(Event event) async {
    var thisOrderItem = MealModel.fromSnapshot(event.snapshot);

    print(thisOrderItem.productName);
    setState(() {
      thisOrder.orderItems.add(thisOrderItem);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: orderHistoryPadding(),
            child: ListView(
              children: [
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.thisOrder.orderStatus,
                      style: TextStyle(
                        fontSize: 16,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                         Icons.watch_later,
                          color: Colors.grey,
                          size: 18,
                        ),

                        SizedBox(width: 5,),
                        Text(
                          "${widget.thisOrder.purchaseDate}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20,),

                FloatingCardWidget(
                  color: Colors.white,
                  size: 200,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Text("Please Rate Our Delivery",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),

                      SizedBox(height: 20,),

                      Container(
                        height: 50,
                        width: 240,//MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,

                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index){
                            return IconButton(
                              icon: Icon(Icons.star,
                              size: 40,),
                              color: ratingStarColor(index),
                              onPressed: (){
                                setState(() {
                                  ratingAction(index);
                                });
                              },
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20,),

                      FlatButton(
                        child: Text("Rate",
                          style: TextStyle(
                            fontSize: 16,

                          ),
                        ),
                        onPressed: (){
                          print("Rating delivery has ${ratingIndex.length} Star(s)");
                        },
                      )
                    ],
                  ),
                ),

                SizedBox(height: 30,),

                Container(
                  child: Text("Address",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                FloatingCardWidget(
                  size: 100,
                  color: Colors.white,
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("To: ${widget.thisOrder.deliveryAddress} ${widget.thisOrder.deliveryApartmentNumber}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text("From: 7708 Nw 84th St."),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30,),

                Text("Payment method",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 10,),

                FloatingCardWidget(
                  size: 100,
                  color: ThemeData().primaryColor,
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Icon(Icons.credit_card,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Center(
                          child: Text(showCardNumber(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Divider(
                  height: 1,
                ),

                SizedBox(height: 20,),

                Text("Order Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),

                //SizedBox(height:10,),

                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 20),
                  child: Container(
                      height: 300,
                      child:OrderHistoryCartListWidget(
                        menuCategory: thisOrder.orderItems,
                      )
                  ),
                ),

                Divider(
                  height: 1,
                ),

                SizedBox(height:30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Basket Charges"),
                    Text("\$${thisOrder.setSubtotal()/100}"),
                  ],
                ),

                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery Charges"),
                    Text("\$${widget.thisOrder.orderDeliveryCharges/100}"),
                  ],
                ),

                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Amount Payable",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("\$${widget.thisOrder.orderTotalCost/100}",
                      style: TextStyle(
                          fontSize: 16,
                          color: ThemeData().primaryColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20,),
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:30.0),
                child: Center(
                  child: checkTimelineForButton(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


abstract class RatingModel{
  Icon ratingIcon;
  Color ratingColor;
  VoidCallback onPressed(){
    return (){
      //do something
    };
  }
}

class RatingButton extends RatingModel{
  var ratingIcon  = Icon(Icons.star);
  var ratingColor = Colors.grey;


  RatingButton({this.ratingIcon, this.ratingColor,});
}
