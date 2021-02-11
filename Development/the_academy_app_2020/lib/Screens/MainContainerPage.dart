import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/UserModel.dart';
import 'package:the_academy_app_2020/Screens/HomePage.dart';
import 'package:the_academy_app_2020/Screens/ExplorePage.dart';
import 'package:the_academy_app_2020/Screens/CoursesPage.dart';
import 'package:the_academy_app_2020/Screens/ProfilePage.dart';


class MainContainerPage extends StatefulWidget {
  final UserModel user;


  MainContainerPage({this.user});


  @override
  _MainContainerPageState createState() => _MainContainerPageState();
}

class _MainContainerPageState extends State<MainContainerPage> {

  int _currentIndex = 0;

  Color tabColor;

  final List<Widget> _children = [
    HomePage(),
    ExplorePage(),
    MyCoursesPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          "The Academy",
          style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home,
              color: Theme.of(context).primaryColor,),
            title: new Text('Home',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),

          BottomNavigationBarItem(
            icon: new Icon(
                Icons.navigation,
                color: Theme.of(context).primaryColor),
            title: new Text('Explore',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),

          BottomNavigationBarItem(
            icon: new Icon(
                Icons.bookmark,
                color: Theme.of(context).primaryColor),
            title: new Text('Courses',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),

          BottomNavigationBarItem(
            icon: new Icon(
                Icons.person,
                color: Theme.of(context).primaryColor
            ),
            title: new Text('Profile',
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}