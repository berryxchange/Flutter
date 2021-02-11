import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Widgets/MenuListWidget.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';

class MenuPage extends StatefulWidget {
  final ValueChanged<int> menuAction;
  static String id = "/mainMenu";

  MenuPage({this.menuAction});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {


  sendUp(int index){
    //Navigator.pop(context);
    widget.menuAction(index);
  }

  //var pageHeight = 600.0;
  //Call User  UserModel thisUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // callUser
    //thisUser = demoUserOne;
    //print(currentOrder.orderItems);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.transparent,//ThemeData().primaryColor,
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                isScrollable: true,
                indicatorColor: ThemeData().primaryColor,
                tabs: [
                  Text("Popular",
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeData().primaryColor
                    ),
                  ),
                  Text("Salads",
                    style: TextStyle(
                        fontSize: 16,
                        color: ThemeData().primaryColor
                    ),
                  ),
                  Text("Soups",
                    style: TextStyle(
                      fontSize: 16,
                        color: ThemeData().primaryColor
                    ),
                  ),
                  Text("Hot Meals",
                    style: TextStyle(
                      fontSize: 16,
                        color: ThemeData().primaryColor
                    ),
                  ),
                  Text("Deserts",
                    style:
                    TextStyle(
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

                  // popular
                  MenuListWidget(menuCategory: popularMeals, menuAction: sendUp,),

                  // salads
                  MenuListWidget(menuCategory: salads, menuAction: sendUp),

                  //soups
                  MenuListWidget(menuCategory: soups, menuAction:sendUp),

                  //hotMeals
                  MenuListWidget(menuCategory: hotMeals, menuAction: sendUp),

                  //deserts
                  MenuListWidget(menuCategory: deserts, menuAction: sendUp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


