import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';

class ProfilePage extends StatefulWidget {
  static String id = "profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  UserModel thisUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    thisUser = demoUserOne;
    print(thisUser.finance.previousPayments.length);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("First Name: ${thisUser.firstName}"),
          Text("Last Name: ${thisUser.lastName}"),
          Text("CP Points: ${thisUser.cPPoints}"),

          SizedBox(height: 20,),

          Container(
            height: 400,
            child: ListView.builder(
              itemCount: thisUser.finance.previousPayments.length,
                itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(thisUser.finance.previousPayments[index].productName),
                        Text(thisUser.finance.previousPayments[index].purchaseDate),
                        Text(thisUser.finance.previousPayments[index].productTerm),
                        Text(thisUser.finance.previousPayments[index].productSellingCategory),
                        Text(thisUser.finance.previousPayments[index].productTotalCost),
                      ],
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
