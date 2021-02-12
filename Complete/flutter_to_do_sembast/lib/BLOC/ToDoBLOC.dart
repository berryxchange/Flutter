import 'dart:async';
import 'package:flutter_to_do_sembast/Models/todoModel.dart'; // the model
import 'package:flutter_to_do_sembast/database/todoDB.dart'; // the database

class ToDoBLOC {
  //the data that will change
  TodoDB dB;
  List<ToDoModel> toDoList;

  //---------- The Dispose Method ------------
  // Here you will close the four stream controllers so there is no possible room for memory leaks
  void dispose() {
    _toDoStreamController.close();
    _toDoInsertController.close();
    _toDoUpdateController.close();
    _toDoDeleteController.close();
  }

  //---------- Streaming ------------
  //Bradcast streams allow multiple listeners that can be added to the stream at any time.
  final _toDoStreamController = StreamController<List<ToDoModel>>.broadcast();

  //Controllers for each Database action
  //for Inserts
  final _toDoInsertController = StreamController<ToDoModel>();

  //for Updates
  final _toDoUpdateController = StreamController<ToDoModel>();

  //for Delete
  final _toDoDeleteController = StreamController<ToDoModel>();

  //getters for streams and sinks
  //Get the List of ToDoObjects
  Stream<List<ToDoModel>> get toDoListStream {
    return _toDoStreamController.stream;
  }

  //gets the Sink list
  StreamSink<List<ToDoModel>> get toDoListSink {
    return _toDoStreamController.sink;
  }

  //gets the Sink Insert action
  StreamSink<ToDoModel> get toDoInsertSink {
    return _toDoInsertController.sink;
  }

  //gets the Sink Update action
  StreamSink<ToDoModel> get toDoUpdateSink {
    return _toDoUpdateController.sink;
  }

  //gets the Sink Delete action
  StreamSink<ToDoModel> get toDoDeleteSink {
    return _toDoDeleteController.sink;
  }

//---------- BLOC Logic ------------

  // The logic that works as the go between
  // of the database business logic and the UI logic
  Future getToDoList() async {
    //NewList = database list
    List<ToDoModel> dBToDoList = await dB.getTodos();
    //main todoObject list = NewList from DB
    toDoList = dBToDoList;
    //Sink also adds NewList
    toDoListSink.add(dBToDoList);
  }

  //Actions
  List<ToDoModel> returnTodoList(toDoList) {
    return toDoList;
  }

  void _addToDo(ToDoModel todo) {
    dB.insertTodo(todo).then((result) {
      getToDoList();
    });
  }

  void _deleteToDo(ToDoModel todo) {
    dB.deleteTodo(todo).then((result) {
      getToDoList();
    });
  }

  void _updateToDo(ToDoModel todo) {
    dB.updateTodo(todo).then((result) {
      getToDoList();
    });
  }

  //---------- The Constructor ------------
  ToDoBLOC() {
    dB = TodoDB();
    getToDoList();

    //Listen to the changes:
    // check to see if there are new streams on the main stream
    // if so, return the new database list
    _toDoStreamController.stream.listen(returnTodoList);

    // check to see if there are new additions on the main stream
    // if so, add new data to the database, then return the new list
    _toDoInsertController.stream.listen(_addToDo);

    // check to see if there are new updates on the main stream
    // if so, update the database, with the new data, then return the new list
    _toDoUpdateController.stream.listen(_updateToDo);

    // check to see if there are new deletions on the main stream
    // if so, delete the object from the database, then return the new list
    _toDoDeleteController.stream.listen(_deleteToDo);
  }
}
