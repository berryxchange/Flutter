import 'package:flutter/material.dart';
//the database
import 'package:flutter_to_do_sembast/database/todoDB.dart';
// the model
import 'package:flutter_to_do_sembast/Models/todoModel.dart';
//The BLOC
import 'package:flutter_to_do_sembast/BLOC/ToDoBLOC.dart';
//TodoObject Page
import 'package:flutter_to_do_sembast/Pages/ToDoPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo's BLOC",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToDoBLOC toDoBLOC;
  List<ToDoModel> toDoList;

  Future _testData() async {
    //----------- Setup -------------
    TodoDB db = TodoDB(); // the instance

    await db.database; // wait for the database connection

    List<ToDoModel> todos = await db
        .getTodos(); // set todoModel list as database objects of TodoObjects

    //----------- Commands -------------
    await db.deleteAll(); // delete all database items

    todos = await db
        .getTodos(); //list reloads to show the database, if any items exist.

    await db.insertTodo(ToDoModel(
        name: "Call Donald",
        description: "And tell him about daisy",
        completeBy: "02/02/2020",
        priority: 1));

    await db.insertTodo(ToDoModel(
        name: "Buy Sugar",
        description: "1 kg",
        completeBy: "02/02/2020",
        priority: 2));

    await db.insertTodo(ToDoModel(
        name: "Go Running",
        description: "@12.00, with neighbors",
        completeBy: "02/02/2020",
        priority: 3));

    todos = await db.getTodos();

    print("First insert");
    todos.forEach((ToDoModel todo) {
      print(todo.name);
    });

    //update the todoObject in the list
    ToDoModel todoToUpdate = todos[0]; //initializer of the object in the list
    todoToUpdate.name = "Call Tim"; // item to change
    await db.updateTodo(todoToUpdate); //set the change in the database

    //delete the todoObject in the list
    ToDoModel todoToDelete = todos[1]; //initializer of the object in the list
    await db.deleteTodo(todoToDelete); //delete the object in the database

    //read the todoObject in the list
    print("After Updates");
    todos = await db.getTodos();
    todos.forEach((ToDoModel todo) {
      print(todo.name);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    toDoBLOC = ToDoBLOC();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    toDoBLOC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToDoModel toDo = ToDoModel(
      name: "",
      description: "",
      completeBy: "",
      priority: 0,
    );

    //the database list
    //toDoList = toDoBLOC.toDoList;

    //_testData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ToDoPage(toDo: toDo, isNew: true);
          }));
        },
      ),
      body: Container(
        child: StreamListWidget(toDoBLOC: toDoBLOC, toDoList: toDoList),
      ),
    );
  }
}

class StreamListWidget extends StatelessWidget {
  const StreamListWidget({
    Key key,
    @required this.toDoBLOC,
    @required this.toDoList,
  }) : super(key: key);

  final ToDoBLOC toDoBLOC;
  final List<ToDoModel> toDoList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDoModel>>(
      stream: toDoBLOC.toDoListStream, //loads a new list
      initialData: toDoList, // loads an initial DB list
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
            itemCount: (snapshot.hasData) ? snapshot.data.length : 0,
            itemBuilder: (context, index) {
              return Dismissible(
                // allows the tab to be swipped to delete
                key: Key(snapshot.data[index].id.toString()),
                onDismissed: (_) {
                  return toDoBLOC.toDoDeleteSink.add(snapshot.data[index]);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).highlightColor,
                    child: Text("${snapshot.data[index].priority}"),
                  ),
                  title: Text("${snapshot.data[index].name}"),
                  subtitle: Text("${snapshot.data[index].description}"),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ToDoPage(
                            toDo: snapshot.data[index], isNew: false);
                      }));
                    },
                  ),
                ),
              );
            });
      },
    );
  }
}
