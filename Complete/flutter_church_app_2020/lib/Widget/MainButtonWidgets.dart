import 'package:flutter/material.dart';

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
          children: [Text(text, style: TextStyle(fontSize: 16))],
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

    Row hasIcon(){
      if (icon != null){
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 10,),
            Text(text, style: TextStyle(fontSize: 16))
          ],
        );
      }else{
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(fontSize: 16))
          ],
        );
      }
    }




    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.black54)),
      onPressed: () {
        onPressed();
      },
      color: Colors.transparent,
      textColor: Colors.black54,
      child: Container(
        height: 50,
        width: 300,
        child: hasIcon()
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
            side: BorderSide(color: Colors.black54)),
        onPressed: () {
          onPressed();
        },
        color: Colors.white,
        textColor: Colors.black54,
        child: Text(text, style: TextStyle(fontSize: 12)));
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
            side: BorderSide(color: Colors.red)),
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
                Text(text, style: TextStyle(fontSize: 16)),
              ],
            )));
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
          side: BorderSide(color: Colors.black54)),
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
          children: [Text(text, style: TextStyle(fontSize: 16))],
        ),
      ),
    );
  }
}
