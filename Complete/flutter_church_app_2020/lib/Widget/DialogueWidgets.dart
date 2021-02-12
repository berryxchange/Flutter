import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Widget/MainButtonWidgets.dart';
//import 'package:flutter_restaurant_backend_app/Globals/GlobalVariables.dart';

class LogoutWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final VoidCallback actionTwo;
  final title;
  final subtitle;

  LogoutWidget({this.actionOne, this.actionTwo, this.title, this.subtitle});

  @override
  _LogoutWidgetState createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(30, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 10.0,
                          spreadRadius: 0.5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Logging Out",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Are you sure you want to log out?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MainButtonWidget(
                          text: "Log Out",
                          onPressed: () {
                            widget.actionOne();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CancelButton(
                          text: "Cancel",
                          onPressed: () {
                            widget.actionTwo();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeleteUserWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final VoidCallback actionTwo;
  final title;
  final subtitle;

  DeleteUserWidget({this.actionOne, this.actionTwo, this.title, this.subtitle});

  @override
  _DeleteUserWidgetState createState() => _DeleteUserWidgetState();
}

class _DeleteUserWidgetState extends State<DeleteUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(30, 0, 0, 0),
                        offset: Offset(1, 1),
                        blurRadius: 10.0,
                        spreadRadius: 0.5)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      DeleteButton(
                        text: "Remove Account",
                        onPressed: () {
                          widget.actionOne();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CancelButton(
                        text: "Cancel",
                        onPressed: () {
                          widget.actionTwo();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

//Updated Profile
class ProfileUpdatedWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final title;
  final subtitle;

  ProfileUpdatedWidget({this.actionOne, this.title, this.subtitle});

  @override
  _ProfileUpdatedWidgetState createState() => _ProfileUpdatedWidgetState();
}

class _ProfileUpdatedWidgetState extends State<ProfileUpdatedWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(30, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 10.0,
                          spreadRadius: 0.5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MainButtonWidget(
                          text: "Ok",
                          onPressed: () {
                            widget.actionOne();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Updated password
class PasswordUpdatedWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final title;
  final subtitle;

  PasswordUpdatedWidget({this.actionOne, this.title, this.subtitle});

  @override
  _PasswordUpdatedWidgetState createState() => _PasswordUpdatedWidgetState();
}

class _PasswordUpdatedWidgetState extends State<PasswordUpdatedWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(30, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 10.0,
                            spreadRadius: 0.5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          MainButtonWidget(
                            text: "Ok",
                            onPressed: () {
                              widget.actionOne();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          //return isLoggingOut = false;
        });
      },
    );
  }
}

//Updated password
class DeliveryAddressUpdatedWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final title;
  final subtitle;

  DeliveryAddressUpdatedWidget({this.actionOne, this.title, this.subtitle});

  @override
  _DeliveryAddressUpdatedWidgetState createState() =>
      _DeliveryAddressUpdatedWidgetState();
}

class _DeliveryAddressUpdatedWidgetState
    extends State<DeliveryAddressUpdatedWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(30, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 10.0,
                            spreadRadius: 0.5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          MainButtonWidget(
                            text: "Ok",
                            onPressed: () {
                              widget.actionOne();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          //return isLoggingOut = false;
        });
      },
    );
  }
}

class DeleteAddressWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final VoidCallback actionTwo;
  final title;
  final subtitle;

  DeleteAddressWidget(
      {this.actionOne, this.actionTwo, this.title, this.subtitle});

  @override
  _DeleteAddressWidgetState createState() => _DeleteAddressWidgetState();
}

class _DeleteAddressWidgetState extends State<DeleteAddressWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(30, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 10.0,
                            spreadRadius: 0.5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          DeleteButton(
                            text: "Remove Address",
                            onPressed: () {
                              widget.actionOne();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CancelButton(
                            text: "Cancel",
                            onPressed: () {
                              widget.actionTwo();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          //return isRemovingUser = false;
        });
      },
    );
  }
}



//Updated password
class CardPaymentUpdatedWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final title;
  final subtitle;

  CardPaymentUpdatedWidget({this.actionOne, this.title, this.subtitle});

  @override
  _CardPaymentUpdatedWidgetState createState() =>
      _CardPaymentUpdatedWidgetState();
}

class _CardPaymentUpdatedWidgetState extends State<CardPaymentUpdatedWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(30, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 10.0,
                            spreadRadius: 0.5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          MainButtonWidget(
                            text: "Ok",
                            onPressed: () {
                              widget.actionOne();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          //return isLoggingOut = false;
        });
      },
    );
  }
}

//no Items in cart
class NoItemsWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final title;
  final subtitle;

  NoItemsWidget({this.actionOne, this.title, this.subtitle});

  @override
  _NoItemsWidgetState createState() => _NoItemsWidgetState();
}

class _NoItemsWidgetState extends State<NoItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(30, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 10.0,
                          spreadRadius: 0.5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MainButtonWidget(
                          text: "Go To Menu",
                          onPressed: () {
                            widget.actionOne();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeleteItemFromListWidget extends StatefulWidget {
  final VoidCallback actionOne;
  final VoidCallback actionTwo;
  final title;
  final subtitle;

  DeleteItemFromListWidget(
      {this.actionOne, this.actionTwo, this.title, this.subtitle});

  @override
  _DeleteItemFromListWidgetState createState() =>
      _DeleteItemFromListWidgetState();
}

class _DeleteItemFromListWidgetState extends State<DeleteItemFromListWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(30, 0, 0, 0),
                        offset: Offset(1, 1),
                        blurRadius: 10.0,
                        spreadRadius: 0.5)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      DeleteButton(
                        text: "Remove Item",
                        onPressed: () {
                          widget.actionOne();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CancelButton(
                        text: "Cancel",
                        onPressed: () {
                          widget.actionTwo();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
