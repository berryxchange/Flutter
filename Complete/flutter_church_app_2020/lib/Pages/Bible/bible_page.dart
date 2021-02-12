import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_church_app_2020/Models/bible_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class BiblePage extends StatefulWidget {
  static String id = "bible_page";
  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {

  DatabaseReference bibleRef;

  List<Bible> bibles = List();

  bool showSpinner = false;

  //finals
  final FirebaseDatabase database = FirebaseDatabase.instance;
  //------------------


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bibleRef = database.reference().child('Bibles');
    bibleRef.onChildAdded.listen(_onBibleAdded);
  }

  _onBibleAdded(Event event) {
    setState(() {
      bibles.add(Bible.fromSnapshot(event.snapshot));
        print(bibles);
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Church Name"),
      actions: <Widget>[
        ],
    ),
      body: SafeArea(
            child: Container(
                color: Colors.grey[200],
    //height: 200.0,
                child:
                Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                //width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: MediaQuery.of(context).size.height / 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15.0
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: GestureDetector(
                            onTap: (){
                              showSpinner = true;
                              _launchURL(bibles[index].bibleLink);
                              showSpinner = false;
                              },
                            child: Card(
                              elevation: 0.0,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Image.asset("Assets/BibleCover.png",
                                    fit: BoxFit.cover,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          bibles[index].bibleVersion,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: "trajan",
                                            color: Colors.orange[200],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        Text(
                                          "The",
                                          style: TextStyle(
                                              fontSize: 42.0,
                                              fontFamily: "Trajan",
                                              color: Colors.orange[200]
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "Holy",
                                          style: TextStyle(
                                              fontSize: 50.0,
                                              fontFamily: "Trajan",
                                              color: Colors.orange[200]
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "Bible",
                                          style: TextStyle(
                                              fontSize: 70.0,
                                              fontFamily: "Trajan",
                                              color: Colors.orange[200]
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )
                    );
                    },
                  itemCount: bibles.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  controller: SwiperController(),
                  containerHeight: 400,
                  pagination: SwiperPagination(
                  ),
                  loop: false,
                )
            )
        ));
  }
}

_launchURL(url) async {
  //const url = 'https://www.bible.com/bible/546/GEN.1.KJVA';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}