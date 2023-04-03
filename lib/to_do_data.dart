class ToDoData {
  String? task;
  bool isDone;
  ToDoData({
    required this.task,
    this.isDone = false,
  });

  Map toJson() => {
        'task': task,
        'isDone': isDone,
      };

  ToDoData.fromJson(Map<String, dynamic> json)
      : task = json['task'],
        isDone = json['isDone'];

  // get dem o values
  static List<ToDoData> getListOfToDoData() {
    List<ToDoData> toDoData = [
      ToDoData(task: "task 1"),
      ToDoData(task: "task 2"),
      ToDoData(task: "task 3", isDone: true),
    ];
    return toDoData;
  }
}
