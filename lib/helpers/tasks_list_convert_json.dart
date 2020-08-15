import '../models/task.dart';

class TasksListConvertJson {
  final List<Task> tasksList;
  TasksListConvertJson({
    this.tasksList,
  });
  factory TasksListConvertJson.fromJson(List<dynamic> parsedJson) {
    List<Task> taskList = List<Task>();
    taskList = parsedJson.map((i) => Task.fromJson(i)).toList();
    return TasksListConvertJson(tasksList: taskList);
  }
}
