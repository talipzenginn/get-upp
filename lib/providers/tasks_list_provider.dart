import 'dart:convert';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:get_upp/helpers/selected_tag_list_convert_json.dart';
import 'package:get_upp/models/tag.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import '../helpers/tasks_list_convert_json.dart';
import '../models/task.dart';

class TasksListProvider extends ChangeNotifier {
  TasksListProvider() {
    getLocalData();
  }
  SharedPreferences preferences;
  List<Task> _displayingAllTasks = [];
  List<Task> _displayingLeftTasks = [];
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
      _displayingAllTasks = _tasks;
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

  void updateTaskTagList(int index, String jsonRequest) {
    _tasks[index].tagListJson = jsonRequest;
    setList();
  }

  void deleteTaskDueDate(int index) {
    _tasks[index].year = 0;
    _tasks[index].month = 0;
    _tasks[index].day = 0;
    setList();
  }

  void setTaskByTagNameChanges(String tagName, String newTagName) {
    for (Task task in _tasks) {
      List<Tag> tagList =
          SelectedTagListConvertJson.fromJson(jsonDecode(task.tagListJson))
              .selectedTagsList;
      for (Tag tag in tagList) {
        if (tag.name == tagName) {
          tag.name = newTagName;
        }
      }
      _tasks[_tasks.indexOf(task)].tagListJson = jsonEncode(tagList);
    }
    setList();
  }

  void setTaskByTagColorChanges(String tagName, int newTagColorIndex) {
    for (Task task in _tasks) {
      List<Tag> tagList =
          SelectedTagListConvertJson.fromJson(jsonDecode(task.tagListJson))
              .selectedTagsList;
      for (Tag tag in tagList) {
        if (tag.name == tagName) {
          tag.colorIndex = newTagColorIndex;
        }
      }
      _tasks[_tasks.indexOf(task)].tagListJson = jsonEncode(tagList);
    }
    setList();
  }

  int get taskCount {
    return _displayingAllTasks.length;
  }

  int get leftTaskCount {
    _leftTasks.clear();
    for (Task task in _displayingAllTasks) {
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
    _displayingAllTasks.clear();
    _displayingLeftTasks.clear();
    for (Task task in _leftTasks) {
      _displayingAllTasks.add(task);
      _displayingLeftTasks.add(task);
    }
    for (Task task in _completedTasks) {
      _displayingAllTasks.add(task);
    }
  }

  void setList() {
    createTasksListOrder();
    preferences.setString('tasksList', jsonEncode(_tasks));
    notifyListeners();
  }

  //değiştirilemez liste tipi dart:collection library den geliyor
  UnmodifiableListView<Task> get displayingAllTasks {
    return UnmodifiableListView(_displayingAllTasks);
  }

  UnmodifiableListView<Task> get displayingLeftTasks {
    return UnmodifiableListView(_displayingLeftTasks);
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }
}
