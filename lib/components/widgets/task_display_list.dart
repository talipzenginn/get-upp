import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_upp/providers/tags_list_provider.dart';
import 'package:provider/provider.dart' show Consumer, Provider;
import '../../providers/settings_provider.dart';
import '../../providers/search_bar_text_field_provider.dart';
import '../../providers/tasks_list_provider.dart';
import 'dismissible_task.dart';
import 'dismissible_tasks_list.dart';

class TaskDisplayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<TagsListProvider>(context);
    SearchBarTextFieldProvider searchBarTextFieldProviderTrue =
        Provider.of<SearchBarTextFieldProvider>(context);
    SettingsProvider settingsProviderTrue =
        Provider.of<SettingsProvider>(context);
    if (searchBarTextFieldProviderTrue.query != null &&
        searchBarTextFieldProviderTrue.query != '') {
      return Consumer<TasksListProvider>(builder: (context, taskData, child) {
        final suggestionList = searchBarTextFieldProviderTrue.query.isEmpty
            ? []
            : settingsProviderTrue.settings.hideCompletedTasks == null
                ? taskData.tasks
                    .where((p) => p.name.toLowerCase().contains(
                        searchBarTextFieldProviderTrue.query.toLowerCase()))
                    .toList()
                : settingsProviderTrue.settings.hideCompletedTasks
                    ? taskData.displayingLeftTasks
                        .where((p) => p.name.toLowerCase().contains(
                            searchBarTextFieldProviderTrue.query.toLowerCase()))
                        .toList()
                    : taskData.tasks
                        .where((p) => p.name.toLowerCase().contains(
                            searchBarTextFieldProviderTrue.query.toLowerCase()))
                        .toList();
        suggestionList.sort((a, b) {
          Map mapA = jsonDecode(jsonEncode(a));
          Map mapB = jsonDecode(jsonEncode(b));
          return mapA['name']
              .toLowerCase()
              .compareTo(mapB['name'].toString().toLowerCase());
        });
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = suggestionList[index];
            int i = taskData.tasks.indexOf(task);
            return DismissibleTask(
              task: task,
              index: i,
            );
          },
          itemCount: suggestionList.length,
        );
      });
    } else {
      return DismissibleTasksList();
    }
  }
}
