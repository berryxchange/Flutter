import 'package:flutter/material.dart';
import 'package:flutter_to_do_sembast/BLOC/ToDoBLOC.dart';
import 'package:flutter_to_do_sembast/Models/todoModel.dart';
import 'package:flutter_to_do_sembast/Pages/main.dart';

class ToDoPage extends StatelessWidget {
  final ToDoModel toDo;
  final bool isNew;

  final TextEditingController textName = TextEditingController();
  final TextEditingController textDescription = TextEditingController();
  final TextEditingController textCompletedBy = TextEditingController();
  final TextEditingController textPriority = TextEditingController();
  final ToDoBLOC bloc;

  ToDoPage({this.toDo, this.isNew}) : bloc = ToDoBLOC();

  Future save() async {
    //the Object
    toDo.name = textName.text;
    toDo.description = textDescription.text;
    toDo.completeBy = textCompletedBy.text;
    toDo.priority = int.tryParse(textPriority.text);
    if (isNew) {
      bloc.toDoInsertSink.add(toDo);
    } else {
      bloc.toDoUpdateSink.add(toDo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double padding = 20.0;
    textName.text = toDo.name;
    textDescription.text = toDo.description;
    textCompletedBy.text = toDo.completeBy;
    textPriority.text = toDo.priority.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: textName,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: "Name"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: textDescription,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Description"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: textCompletedBy,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Complete By"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: textPriority,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Priority"),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(padding),
                child: MaterialButton(
                    color: Colors.green,
                    child: Text("Save"),
                    onPressed: () {
                      save().then((_) {
                        return Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }), (Route<dynamic> route) {
                          return false;
                        });
                      });
                    }))
          ],
        ),
      ),
    );
  }
}
