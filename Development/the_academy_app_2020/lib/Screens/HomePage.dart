import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Screens/Stripe/PaymentPage.dart';




class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  static String id = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int totalAmount = 0;


  gotoPaymentsPage(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PaymentsPage(totalAmount: totalAmount, thisUser: demoUserOne,);
          },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(
              height: 50,
            ),

            Text("Welcome to",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme
                      .of(context)
                      .primaryColor
              ),
              textAlign: TextAlign.center,
            ),
            Text("The Academy",
              style: TextStyle(
                  fontSize: 24,
                  color: Theme
                      .of(context)
                      .primaryColor
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: 30,
            ),

            Text("Step into something new",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme
                      .of(context)
                      .primaryColor
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 75,),

            Container(
              height: 200,
              width: 335,
              decoration: BoxDecoration(
                  color: Colors.white,
                  //shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 22.0),
                        blurRadius: 22.0,
                        spreadRadius: 0,
                        color: Color.fromARGB(45, 0, 65, 255)
                    ),
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text("What's New At The Academy",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .primaryColor
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 120, right: 120, top: 30),
                      child: OutlineButton(
                        onPressed: (){
                          gotoPaymentsPage();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_forward,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                            SizedBox(width: 10,),
                            Text("View",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),

            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Reviews",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0050AC),
                  ),
                ),

                Text("View All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCBCBC)
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                height: 306,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 40, top: 20),
                          //height: 226,
                          width: 167,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 22.0),
                                    blurRadius: 22.0,
                                    spreadRadius: 0,
                                    color: Color.fromARGB(45, 0, 65, 255)
                                ),
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                radius: 37.5,
                                backgroundColor: Colors.blueGrey,
                                child: Container(
                                  height: 75,
                                  width: 75,
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Text(
                                "Diamond Taylor",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Text(
                                  "I was totally blown away by this academy and the things they had to offer!",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              SizedBox(height: 10,),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.star, size: 11,
                                        color: Colors.white,),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star_half, size: 11,
                                          color: Colors.white),
                                      SizedBox(width: 8,),
                                      Text("4.5", style:
                                      TextStyle(
                                          color: Colors.white
                                      ),),
                                      SizedBox(width: 8,),
                                      Text("Stars", style:
                                      TextStyle(
                                          color: Colors.white
                                      ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      onTap: (){
                        setState(() {
                          totalAmount = 1500;
                          print("totalAmount: $totalAmount");
                        });
                      },
                    ),

                    SizedBox(width: 10,),
                    GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 40, top: 20),
                          //height: 226,
                          width: 167,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 22.0),
                                    blurRadius: 22.0,
                                    spreadRadius: 0,
                                    color: Color.fromARGB(45, 0, 65, 255)
                                ),
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                radius: 37.5,
                                backgroundColor: Colors.blueGrey,
                                child: Container(
                                  height: 75,
                                  width: 75,
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Text(
                                "Diamond Taylor",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Text(
                                  "I was totally blown away by this academy and the things they had to offer!",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              SizedBox(height: 10,),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.star, size: 11,
                                        color: Colors.white,),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star_half, size: 11,
                                          color: Colors.white),
                                      SizedBox(width: 8,),
                                      Text("4.5", style:
                                      TextStyle(
                                          color: Colors.white
                                      ),),
                                      SizedBox(width: 8,),
                                      Text("Stars", style:
                                      TextStyle(
                                          color: Colors.white
                                      ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      onTap: (){
                        setState(() {
                          totalAmount = 5000;
                          print("totalAmount: $totalAmount");
                        });
                      },
                    ),

                    SizedBox(width: 10,),
                    GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 40, top: 20),
                          //height: 226,
                          width: 167,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 22.0),
                                    blurRadius: 22.0,
                                    spreadRadius: 0,
                                    color: Color.fromARGB(45, 0, 65, 255)
                                ),
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                radius: 37.5,
                                backgroundColor: Colors.blueGrey,
                                child: Container(
                                  height: 75,
                                  width: 75,
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Text(
                                "Diamond Taylor",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Text(
                                  "I was totally blown away by this academy and the things they had to offer!",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              SizedBox(height: 10,),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.star, size: 11,
                                        color: Colors.white,),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star, size: 11,
                                          color: Colors.white),
                                      Icon(Icons.star_half, size: 11,
                                          color: Colors.white),
                                      SizedBox(width: 8,),
                                      Text("4.5", style:
                                      TextStyle(
                                          color: Colors.white
                                      ),),
                                      SizedBox(width: 8,),
                                      Text("Stars", style:
                                      TextStyle(
                                          color: Colors.white
                                      ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      onTap: (){
                        setState(() {
                          totalAmount = 15000;
                          print("totalAmount: $totalAmount");
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Featured Teachers",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0050AC),
                  ),
                ),

                Text("View All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCBCBC)
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                height: 380,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 40, top: 20),
                      height: 300,
                      width: 335,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 22.0),
                                blurRadius: 22.0,
                                spreadRadius: 0,
                                color: Color.fromARGB(45, 0, 65, 255)
                            ),
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Dr. Kathren Coupe",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.left,
                            ),

                            Text(
                              "Professor of Applied Sciences",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.left,
                            ),

                            SizedBox(height: 8,),

                            Row(
                              children: <Widget>[
                                Icon(Icons.favorite,
                                  color: Colors.red,),

                                SizedBox(
                                  width: 8,
                                ),

                                Text("4.6",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),

                                Text("K",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Container(
                      margin: EdgeInsets.only(bottom: 40, top: 20),
                      //height: 300,
                      width: 335,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Dr. Kathren Coupe",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.left,
                            ),

                            Text(
                              "Professor of Applied Sciences",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.left,
                            ),

                            SizedBox(height: 8,),

                            Row(
                              children: <Widget>[
                                Icon(Icons.favorite,
                                  color: Colors.red,),

                                SizedBox(
                                  width: 8,
                                ),

                                Text("4.6",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),

                                Text("K",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 40, top: 20),
                      height: 300,
                      width: 335,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Dr. Kathren Coupe",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.left,
                            ),

                            Text(
                              "Professor of Applied Sciences",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.left,
                            ),

                            SizedBox(height: 8,),

                            Row(
                              children: <Widget>[
                                Icon(Icons.favorite,
                                  color: Colors.red,),

                                SizedBox(
                                  width: 8,
                                ),

                                Text("4.6",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),

                                Text("K",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("News",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0050AC),
                  ),
                ),

                Text("View All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCBCBC)
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 20),
              child: Container(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 40, top: 20),
                      height: 150,
                      width: 334,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 22.0),
                                blurRadius: 22.0,
                                spreadRadius: 0,
                                color: Color.fromARGB(45, 0, 65, 255)
                            ),
                          ]
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 335 / 2,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[


                              Text("Header",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Text("Short description",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.remove_red_eye, color: Colors.white,),
                                  SizedBox(width: 8,),
                                  Text("13.2",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text("K",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),

                                  SizedBox(width: 16,),

                                  Icon(Icons.star, color: Colors.white,),

                                  SizedBox(width: 8,),

                                  Text("4.6",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 40, top: 20),
                      height: 150,
                      width: 334,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 335 / 2,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[


                              Text("Header",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Text("Short description",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.remove_red_eye, color: Colors.white,),
                                  SizedBox(width: 8,),
                                  Text("13.2",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text("K",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),

                                  SizedBox(width: 16,),

                                  Icon(Icons.star, color: Colors.white,),

                                  SizedBox(width: 8,),

                                  Text("4.6",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 40, top: 20),
                      height: 150,
                      width: 334,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 335 / 2,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[


                              Text("Header",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Text("Short description",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.remove_red_eye, color: Colors.white,),
                                  SizedBox(width: 8,),
                                  Text("13.2",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text("K",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),

                                  SizedBox(width: 16,),

                                  Icon(Icons.star, color: Colors.white,),

                                  SizedBox(width: 8,),

                                  Text("4.6",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}