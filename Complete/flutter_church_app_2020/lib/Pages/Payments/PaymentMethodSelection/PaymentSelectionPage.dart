import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_church_app_2020/Models/UserModel.dart';
import 'package:flutter_church_app_2020/Pages/MainSelectionsPage/MainSelectionsPage.dart';
import 'package:flutter_church_app_2020/Pages/Payments/Stripe/PaymentPage/PaymentPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_church_app_2020/Pages/Payments/PaymentMethodSelection/PaymentMethodSelectionBLOC.dart';
import 'package:flutter_church_app_2020/Models/PaymentSourceModel.dart';


class PaymentSelectionPage extends StatefulWidget {
  static String id = "payment_page";

  final ChurchUserModel thisUser;
  final String paymentType;

  PaymentSelectionPage({this.thisUser, this.paymentType});

  @override
  _PaymentSelectionPageState createState() => _PaymentSelectionPageState();
}



class _PaymentSelectionPageState extends State<PaymentSelectionPage> {

  PaymentMethodSelectionBLOC paymentMethodSelectionBLOC;
  double paymentAmount;

  List<PaymentSourceModel> paymentSources;

  checkAction(String action){
    switch(action){
      case "paypal":
        _launchPaymentURL();
        break;
      case "debit":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PaymentPage(
                  paymentType: widget.paymentType,
                  thisUser: widget.thisUser,
                  paymentAmount: paymentAmount,
              );
            },
          ),
        );
    }
    //paymentMethodSelectionBLOC.checkAction(context: context, thisUser: widget.thisUser, action: action);
  }
  
  //functions
  
  _launchPaymentURL() async {
    paymentMethodSelectionBLOC.launchPaymentURL();
  }
  //------------------


  @override
  void initState() {
    // TODO: implement initState
    paymentMethodSelectionBLOC = PaymentMethodSelectionBLOC();
    paymentSources = paymentMethodSelectionBLOC.paymentSources;
    paymentAmount = paymentMethodSelectionBLOC.paymentAmount;

    print(widget.paymentType);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Portal"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text("Amount", style: TextStyle(
              fontSize: 24,
              color: Colors.blue
            ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Container(
                height: 100,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                  ],
                  onChanged: (value) {
                    paymentAmount = double.parse(value) * 100;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return '0.00';
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  //initialValue: "20.00",
                  style: TextStyle(
                    fontSize: 40
                  ),
                  //onSaved: (value) {
                    //return paymentAmount = double.parse(value);
                  //},
                  decoration: InputDecoration(
                      //labelText: "Enter your amount",
                      labelStyle: TextStyle(
                        fontSize: 16
                      ),
                      hintText: "200.00",
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                      //icon: Icon(Icons.attach_money)
                  ),
                )
              ),
            ),

            SizedBox(height: 20,),
            Text("Payment Sources", style: TextStyle(
              fontSize: 24,
                color: Colors.blue
            ),
            ),
            SizedBox(height: 20,),

            Expanded(
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(paymentSources.length, (index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        checkAction(paymentSources[index].action);
                      },
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 15.0)
                          ]
                        ),
                        child: Center(
                          child: Text(
                            paymentSources[index].title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


