import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:flutter_to_do_sembast/Models/todoModel.dart';

class TodoDB {
  //possible FB Database Idea
  /*databaseCall(path: data, object: data, actionToDo: data){

    switch(path){
       case (path) :
          launchCollectionPath1(object: data, actionToDo: data)
       case (path) :
          launchCollectionPath2(object: data, actionToDo: data)
       case (path) :
          launchCollectionPath3(object: data, actionToDo: data)
     }
   }

    launchCollectionPath1(object: data, actionToDo: data){
      FB collectionPath1 = data

      //actions
      switch (actionToDo){
        case add:
          collectionPath1.add(object: data)
        case update:
          collectionPath1.update(object: data)
        case delete:
          collectionPath1.delete(object: data)
        case read:
          collectionPath1.read()
      }
    }
   */

  //this needs to be a singleton
  static final TodoDB _singleton = TodoDB._internal();

  /*
  A factory constructor can only return a single instance of the current class:
  that's why factory constructors are often used when you need to implement the singleton pattern.
   */
  factory TodoDB() {
    return _singleton;
  }

  //---------------------------------------------
  /*
  A database factory allows us to open a sembast database.
  Each database is a file.
   */
  DatabaseFactory dbFactory = databaseFactoryIo;
  final store = intMapStoreFactory.store("todos");
  Database _database;

  /*
  a getter that will check whether the _database has already been set:
  if it has, the getter will return the existing _database.
  If it hasn't, it will call the _openDb() asynchronous method
   */
  Future _openDB() async {
    print("opening a database..");
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, "todos.db");
    final db = await dbFactory.openDatabase(dbPath);
    return db;

    /*
    Now that the database is open, we need to write the methods
    for the create, read, update, and delete tasks.
    Task:
    Insert a new document : add()
    Update an existing document : update()
    Delete a document : delete()
    Retrieve one or more documents : find()
     */
  }

//---------------------------------------------
  //Insert A ToDoObject
  Future insertTodo(ToDoModel todo) async {
    await store.add(_database, todo.toMap());
    print("${todo.name} has been inserted");
  }

//---------------------------------------------
  /*
  -Updating
   A Finder is a helper that you can use to search inside a store.
   With the update() method, you need to retrieve a TodoObject
   before updating it, so you need the Finder before you update the document.
   */
  Future updateTodo(ToDoModel todo) async {
    //Finder is a helper for searching a given store
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.update(_database, todo.toMap(), finder: finder);
    print("${todo.name} has been updated");
  }

//---------------------------------------------
  //Deleting
  Future deleteTodo(ToDoModel todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.delete(_database, finder: finder);
    print("${todo.name} has been deleted");
  }

  Future deleteAll() async {
    //Clears all records from the store
    await store.delete(_database);
    print("All Items have been deleted");
  }

//---------------------------------------------
  //Retrieving
  Future<List<ToDoModel>> getTodos() async {
    await database;
    final finder = Finder(sortOrders: [
      SortOrder("priority"),
      SortOrder("id"),
    ]);

    /*
    The find() method returns a
    Future<List<RecordSnapshot>> and not a List<TodoModel>
     */
    final todoSnapshot = await store.find(_database, finder: finder);
    return todoSnapshot.map((snapshot) {
      final todo = ToDoModel.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }
//---------------------------------------------

  Future<Database> get database async {
    if (_database == null) {
      print("No items exist, creating..");
      await _openDB().then((db) {
        _database = db;
      });
    }
    return _database;
  }

  //private internal constructor
  TodoDB._internal();
}
