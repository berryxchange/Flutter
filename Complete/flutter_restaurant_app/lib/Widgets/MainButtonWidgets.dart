import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


//Main Button
class MainButtonWidget extends StatelessWidget {
  final text;
  final VoidCallback onPressed;
  const MainButtonWidget({
    this.text,
    this.onPressed,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () {
        onPressed();
      },
      color: Colors.blue,
      textColor: Colors.white,
      child: Container(
        height: 50,
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}



//Secondary Button

class FlatSecondaryMainButton extends StatelessWidget {
  final text;
  final icon;
  final VoidCallback onPressed;

  const FlatSecondaryMainButton({
    this.text,
    this.icon,
    this.onPressed,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.black54)
      ),
      onPressed: () {
        onPressed();
      },
      color: Colors.transparent,
      textColor: Colors.black54,
      child: Container(
        height: 50,
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(text,
                style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}


//Edit Button

class EditButton extends StatelessWidget {
  final text;
  final VoidCallback onPressed;

  const EditButton({
    this.text,
    this.onPressed,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.black54)
      ),
      onPressed: () {
        onPressed();
      },
      color: Colors.white,
      textColor: Colors.black54,
      child: Text(text,
          style: TextStyle(fontSize: 12))
    );
  }
}


//Delete Button
class DeleteButton extends StatelessWidget {
  final text;
  final icon;
  final VoidCallback onPressed;

  const DeleteButton({
    this.text,
    this.icon,
    this.onPressed,


    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.red)
        ),
        onPressed: () {
          onPressed();
        },
        color: Colors.white,
        textColor: Colors.red,
        child: Container(
          height: 50,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete),
              Text(text,
                  style: TextStyle(fontSize: 16)),
            ],
          )
        )
    );
  }
}


//Cancel Button

class CancelButton extends StatelessWidget {
  final text;
  final icon;
  final VoidCallback onPressed;

  const CancelButton({
    this.text,
    this.icon,
    this.onPressed,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.black54)
      ),
      onPressed: () {
        onPressed();
      },
      color: Colors.transparent,
      textColor: Colors.black54,
      child: Container(
        height: 50,
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}


class ProductIncreaser extends StatefulWidget {
  final int mealCount;

  ProductIncreaser({this.mealCount});

  @override
  _ProductIncreaserState createState() => _ProductIncreaserState();
}

class _ProductIncreaserState extends State<ProductIncreaser> {

  int amount = 0;

  int getAmount(){
    return amount;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount = widget.mealCount;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(100, 203, 206, 212),
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    amount += 1;
                  });
                },
                //backgroundColor: Colors.blue,
                child: Text("+",
                  style: TextStyle(
                      fontSize: 24,
                    color: ThemeData().primaryColor
                  ),
                ),
              ),
            ),

            Expanded(
              child: Container(
                height: 50,
                width: 300,
                child: Center(
                  child: Text(amount.toString(),
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                          color: ThemeData().primaryColor
                      ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    amount -= 1;
                  });
                },
                //backgroundColor: Colors.blue,
                child: Text("-",
                  style: TextStyle(
                      fontSize: 28,
                      color: ThemeData().primaryColor
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
