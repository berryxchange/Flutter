import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Models/MealModel.dart';
import 'package:flutter_restaurant_app/Pages/Menu/ProductPage/ProductPage.dart';
import 'package:flutter_restaurant_app/Models/UserModel.dart';
import 'package:flutter_restaurant_app/Globals/GlobalVariables.dart';

class MenuListWidget extends StatelessWidget {
  final List<MealModel> menuCategory;
  final ValueChanged<int> menuAction;
  //final UserModel thisUser;

  const MenuListWidget({
    this.menuCategory,
    this.menuAction,
    //this.thisUser,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    sendUp(int index){
      Navigator.pop(context);
      menuAction(index);
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        return Column(
          children: [
            Padding(
              child: Container(
                //color: Colors.red,
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 65, top: 12.5),
                      child: Container(
                        height: 175,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
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
                          padding: const EdgeInsets.only(top: 35.0, left: 10, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 85.0, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  menuCategory[index].productName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54
                                  ),
                                ),

                                //SizedBox(height: 10,),

                                Text(
                                  menuCategory[index].productDescription,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey
                                  ),
                                ),

                                //SizedBox(height: 10,),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "\$${menuCategory[index].productPrice/100}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeData().primaryColor
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: FlatButton(
                                        onPressed: (){
                                          Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) {
                                              return ProductPage(
                                                thisMeal: menuCategory[index],
                                                menuAction: sendUp,
                                                from: "Menu",
                                                //thisUser: demoUserOne,
                                              );
                                            },
                                          ),
                                          );
                                        },
                                        child: Text("Buy",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: ThemeData().primaryColor
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 2,
                                              color: ThemeData().primaryColor),

                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ClipRRect(
                        child: Container(
                          color: Colors.blue,
                          height: 150,
                          width: 150,
                          child: Image.asset(
                            "Assets/ProductImages/${menuCategory[index].productImage}",
                            height: 175,
                            fit: BoxFit.fitHeight,),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            ),
          ],
        );
      },
      itemCount: menuCategory.length,
    );
  }
}

class MenuCategoryTab extends StatelessWidget {

  final cateogryName;

  const MenuCategoryTab({
    this.cateogryName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        //constraints: BoxConstraints.expand(width: 100),
        //color: Colors.blue,
        child: Text(
          cateogryName,
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20
          ),
        ),
      ),
      //onTap: getPageHeight("Overview"),
    );
  }
}