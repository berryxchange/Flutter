import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Pages/Payments/PaymentMethodSelection/PaymentSelectionPage.dart';
import 'package:flutter_church_app_2020/Pages/Payments/TitheAndOffering/TitheAndOfferingBLOC.dart';
import 'package:flutter_church_app_2020/Models/PaymentOptionCardModel.dart';
import 'package:firebase_database/firebase_database.dart';


class TitheAndOffering extends StatefulWidget {
  static String id = "tithe_and_offering_page"; // page Id

  final ChurchUserModel thisUser;

  TitheAndOffering({this.thisUser});


  @override
  _TitheAndOfferingState createState() => _TitheAndOfferingState();
}

class _TitheAndOfferingState extends State<TitheAndOffering> {

  TitheAndOfferingBLOC titheAndOfferingBLOC;
  List<PaymentOptionCardModel> paymentOptions;
  DatabaseReference titheAndOfferingRef;

  Color setColors(String thisPaymentColor){
    Color thisColor;
    switch (thisPaymentColor) {
      case "Color(0xffff5722)"://deepOrange
        thisColor = Colors.deepOrange;
        break;
      case "Color(0xff4caf50)"://green
        thisColor = Colors.green;
        break;
      case "Color(0xff448aff)"://blueAccent
        thisColor = Colors.blueAccent;
        break;
      case "Color(0xff7c4dff)"://deepPurpleAccent
        thisColor = Colors.deepPurpleAccent;
        break;
    }
    print("New COlor: $thisColor");
    return thisColor;
  }

  @override
  void initState() {
    // TODO: implement initState

    titheAndOfferingBLOC = TitheAndOfferingBLOC();
    paymentOptions = titheAndOfferingBLOC.paymentOptions;

    titheAndOfferingRef = FirebaseDatabase.instance.reference()
        .child("TitheAndOffering");

    titheAndOfferingRef.onChildAdded.listen((event) {
      PaymentOptionCardModel thisTitheOrOffering = PaymentOptionCardModel.fromSnapshot(event.snapshot);
      setState(() {
        paymentOptions.add(thisTitheOrOffering);
      });
    });


    titheAndOfferingRef.onChildChanged.listen((event) {
      var old = paymentOptions.singleWhere((entry) {
        return entry.key == event.snapshot.key;
      });

      setState(() {
        paymentOptions[paymentOptions.indexOf(old)] = PaymentOptionCardModel.fromSnapshot(event.snapshot);
      });
    });


    titheAndOfferingRef.onChildRemoved.listen((event) {
      var old = paymentOptions.singleWhere((entry) {
        return entry.key == event.snapshot.key;
      });

      setState(() {
        paymentOptions.removeAt(paymentOptions.indexOf(old));
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tithe and Offering")
      ),
      body: ListView.builder(
          itemCount: paymentOptions.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      height: 250,
                      color: setColors(paymentOptions[index].color),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(paymentOptions[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),),
                          Text(paymentOptions[index].description,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  //padding: EdgeInsets.all(8),
                                  color: Colors.white,
                                  height: 50,
                                  width: 250,
                                  child: Center(
                                    child: Text("Click To Pay",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: setColors(paymentOptions[index].color)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PaymentSelectionPage(
                          thisUser: widget.thisUser,
                          paymentType: paymentOptions[index].paymentType,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          })
    );
  }
}




