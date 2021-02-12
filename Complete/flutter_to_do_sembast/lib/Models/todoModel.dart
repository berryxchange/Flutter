class ToDoModel {
  int id;
  String name;
  String description;
  String completeBy;
  int priority;

  ToDoModel({this.name, this.description, this.completeBy, this.priority});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "completeBy": completeBy,
      "priority": priority,
    };
  }

  static ToDoModel fromMap(Map<String, dynamic> map) {
    return ToDoModel(
        name: map["name"],
        description: map["description"],
        completeBy: map["completeBy"],
        priority: map["priority"]);
  }
}
