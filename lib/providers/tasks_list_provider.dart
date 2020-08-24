import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../helpers/tasks_list_convert_json.dart';
import '../models/task.dart';
import 'dart:collection';

class TasksListProvider extends ChangeNotifier {
  TasksListProvider() {
    getLocalData();
  }
  SharedPreferences preferences;
  List<Task> _displayingTasks = [];
  List<Task> _tasks = [];
  List<Task> _leftTasks = [];
  List<Task> _completedTasks = [];

  void getLocalData() async {
    preferences = await SharedPreferences.getInstance();
    String jsonText = preferences.getString('tasksList');
    if (jsonText != null) {
      final jsonResponse = json.decode(jsonText);
      TasksListConvertJson taskJson =
          TasksListConvertJson.fromJson(jsonResponse);
      _tasks = taskJson.tasksList;
      _displayingTasks = _tasks;
      createTasksListOrder();
      notifyListeners();
    }
  }

  void addTask(Task newTask) {
    _tasks.insert(0, newTask);
    setList();
  }

  void updateCheckProperty(Task currentTask) {
    currentTask.toggleDone();
    setList();
  }

  void deleteTask(Task currentTask) {
    _tasks.remove(currentTask);
    setList();
  }

  void updateTaskTitle(String taskTitle, int index) {
    _tasks[index].name = taskTitle;
    setList();
  }

  void updateTaskPriority(int importanceValue, int index) {
    _tasks[index].importanceValue = importanceValue;
    setList();
  }

  void updateTaskDueDate(int year, int month, int day, int index) {
    _tasks[index].year = year;
    _tasks[index].month = month;
    _tasks[index].day = day;
    setList();
  }

  void deleteTaskDueDate(int index) {
    _tasks[index].year = 0;
    _tasks[index].month = 0;
    _tasks[index].day = 0;
    setList();
  }

  int get taskCount {
    return _displayingTasks.length;
  }

  int get leftTaskCount {
    _leftTasks.clear();
    for (Task task in _displayingTasks) {
      if (task.isDone == false) {
        _leftTasks.add(task);
      }
    }
    return _leftTasks.length;
  }

  void createTasksListOrder() {
    _leftTasks.clear();
    _completedTasks.clear();
    for (Task task in _tasks) {
      if (task.isDone == false) {
        _leftTasks.add(task);
      } else {
        _completedTasks.add(task);
      }
    }
    _displayingTasks.clear();
    for (Task task in _leftTasks) {
      _displayingTasks.add(task);
    }
    for (Task task in _completedTasks) {
      _displayingTasks.add(task);
    }
  }

  void setList() {
    createTasksListOrder();
    preferences.setString('tasksList', jsonEncode(_tasks));
    notifyListeners();
  }

  //değiştirilemez liste tipi dart:collection library den geliyor
  UnmodifiableListView<Task> get displayingTasks {
    return UnmodifiableListView(_displayingTasks);
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }
}
