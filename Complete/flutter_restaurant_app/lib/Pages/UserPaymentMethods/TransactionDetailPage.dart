import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/OrderModel.dart';

class TransactionDetailPage extends StatefulWidget {

  final OrderModel thisOrder;

  TransactionDetailPage({this.thisOrder});

  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {

  OrderModel thisOrder;

  @override
  void initState() {
    // TODO: implement initState
    thisOrder = widget.thisOrder;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 30),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(12)
              ),
              color: Colors.white, //Colors.blue,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(80, 0, 0, 0),
                    offset: Offset(1, 1),
                    blurRadius: 10.0,
                    spreadRadius: 1.0)
              ],
            ),
            child: ClipRRect(
              borderRadius:  BorderRadius.all(Radius.circular(12)),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    color: Colors.blue,
                    child:Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.airplanemode_active_outlined, size: 50, color: Colors.white,),
                            Text("${thisOrder.purchaseDate}",style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),)
                          ],
                        )
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Description"),
                              Text("Total")
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Divider(
                            height: 2,
                            color: Colors.blue,
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${thisOrder.orderName}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text("\$${thisOrder.orderTotalCost /100}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
