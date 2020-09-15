import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../models/tag.dart';
import '../providers/tags_list_provider.dart';
import '../providers/tasks_list_provider.dart';
import '../screens/edit_tag_screen.dart';
import '../models/task.dart';
import '../providers/active_color_provider.dart';
import '../screens/edit_task_screen.dart';

class ReusableMethods {
  void openEditTaskScreen(BuildContext context, Task task, int index) {
    ActiveColorProvider activeColorProviderFalse =
        Provider.of<ActiveColorProvider>(context, listen: false);
    FocusScope.of(context).unfocus();
    bool lessActiveness = false;
    bool middleActiveness = false;
    bool moreActiveness = false;
    activeColorProviderFalse.inactivateColors();
    if (task.importanceValue == 1) {
      activeColorProviderFalse.changeLessButtonColor();
    } else if (task.importanceValue == 2) {
      activeColorProviderFalse.changeMiddleButtonColor();
    } else if (task.importanceValue == 3) {
      activeColorProviderFalse.changeMoreButtonColor();
    }
    if (task.importanceValue == 1) {
      lessActiveness = true;
    } else if (task.importanceValue == 2) {
      middleActiveness = true;
    } else if (task.importanceValue == 3) {
      moreActiveness = true;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditTaskScreen(
          lessActiveness: lessActiveness,
          middleActiveness: middleActiveness,
          moreActiveness: moreActiveness,
          index: index,
          day: task.day,
          month: task.month,
          year: task.year,
          title: task.name,
        ),
      ),
    );
  }

  void openEditTagScreen(
      {BuildContext context, int index, int colorIndex, String title}) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditTagScreen(
          index: index,
          colorIndex: colorIndex,
          title: title,
        ),
      ),
    );
  }

  void addTask(
      {bool lessActiveness,
      bool middleActiveness,
      bool moreActiveness,
      int importanceValue,
      String taskName,
      DateTime newDateTime,
      String jsonRequest,
      Function elseFunction,
      BuildContext context}) {
    TagsListProvider tagsListProviderFalse =
        Provider.of<TagsListProvider>(context, listen: false);
    TasksListProvider tasksListProviderFalse =
        Provider.of<TasksListProvider>(context, listen: false);
    tagsListProviderFalse.tagging();
    jsonRequest = jsonEncode(tagsListProviderFalse.selectedTagList);
    if (lessActiveness) {
      importanceValue = 1;
    } else if (middleActiveness) {
      importanceValue = 2;
    } else if (moreActiveness) {
      importanceValue = 3;
    } else {
      importanceValue = null;
    }
    if ((taskName != null && taskName != '') && newDateTime != null) {
      tasksListProviderFalse.addTask(Task(
          name: taskName,
          importanceValue: importanceValue,
          year: newDateTime.year,
          month: newDateTime.month,
          day: newDateTime.day,
          tagListJson: jsonRequest));
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
      taskName = null;
      lessActiveness = false;
      middleActiveness = false;
      moreActiveness = false;
      importanceValue = null;
      newDateTime = null;
    } else if (taskName != null && taskName != '') {
      tasksListProviderFalse.addTask(Task(
          name: taskName,
          importanceValue: importanceValue,
          tagListJson: jsonRequest));
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
      taskName = null;
      lessActiveness = false;
      middleActiveness = false;
      moreActiveness = false;
      importanceValue = null;
    } else {
      elseFunction();
    }
  }

  void editTask({
    bool lessActiveness,
    bool middleActiveness,
    bool moreActiveness,
    int importanceValue,
    String taskName,
    DateTime newDateTime,
    int index,
    BuildContext context,
  }) {
    TasksListProvider tasksListProviderFalse =
        Provider.of<TasksListProvider>(context, listen: false);
    if (lessActiveness) {
      importanceValue = 1;
    } else if (middleActiveness) {
      importanceValue = 2;
    } else if (moreActiveness) {
      importanceValue = 3;
    } else {
      importanceValue = null;
    }
    if ((taskName != null && taskName != '') && newDateTime != null) {
      tasksListProviderFalse.updateTaskTitle(taskName, index);
      tasksListProviderFalse.updateTaskDueDate(
          newDateTime.year, newDateTime.month, newDateTime.day, index);
    } else if (taskName != null && taskName != '') {
      tasksListProviderFalse.updateTaskTitle(taskName, index);
    } else if (newDateTime != null) {
      tasksListProviderFalse.updateTaskDueDate(
          newDateTime.year, newDateTime.month, newDateTime.day, index);
    }
    tasksListProviderFalse.updateTaskPriority(importanceValue, index);
    Navigator.pop(context);
    FocusScope.of(context).unfocus();
    taskName = null;
    lessActiveness = false;
    middleActiveness = false;
    moreActiveness = false;
    importanceValue = null;
  }

  void addTag(
      {List<Color> colors,
      Color selectedColor,
      int selectColorIndex,
      String tagName,
      BuildContext context,
      Function elseFunction}) {
    TagsListProvider tagsListProviderFalse =
        Provider.of<TagsListProvider>(context, listen: false);
    for (Color color in colors) {
      if (selectedColor == color) {
        selectColorIndex = colors.indexOf(color);
      }
    }
    if (tagName != null && tagName != '') {
      tagsListProviderFalse.addTag(
        Tag(name: tagName, colorIndex: selectColorIndex),
      );
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
    } else {
      elseFunction();
    }
  }

  void editTag({
    List<Color> colors,
    Color selectedColor,
    int selectColorIndex,
    String tagName,
    int index,
    BuildContext context,
  }) {
    TagsListProvider tagsListProviderFalse =
        Provider.of<TagsListProvider>(context, listen: false);
    for (Color color in colors) {
      if (selectedColor == color) {
        selectColorIndex = colors.indexOf(color);
      }
    }
    if ((tagName != null && tagName != '')) {
      tagsListProviderFalse.updateTagTitle(index, tagName);
      tagsListProviderFalse.updateTagColor(index, selectColorIndex);
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
    } else {
      tagsListProviderFalse.updateTagColor(index, selectColorIndex);
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
    }
  }
}
