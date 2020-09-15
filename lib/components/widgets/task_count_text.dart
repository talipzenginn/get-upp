import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../../providers/settings_provider.dart';
import '../../providers/tasks_list_provider.dart';
import '../../components/constants.dart';

class TaskCountText extends StatelessWidget {
  String taskCountText(BuildContext context) {
    SettingsProvider settingsProviderTrue =
        Provider.of<SettingsProvider>(context);
    TasksListProvider tasksListProviderTrue =
        Provider.of<TasksListProvider>(context);
    String taskCount;
    if (settingsProviderTrue.settings.hideCompletedTasks != null) {
      if (!settingsProviderTrue.settings.hideCompletedTasks) {
        if (tasksListProviderTrue.leftTaskCount == 0) {
          taskCount = 'Well\nDone!';
        } else {
          taskCount =
              '${tasksListProviderTrue.leftTaskCount} left\n${tasksListProviderTrue.taskCount - tasksListProviderTrue.leftTaskCount} completed';
        }
      } else if (settingsProviderTrue.settings.hideCompletedTasks) {
        if (tasksListProviderTrue.leftTaskCount == 0) {
          taskCount = '';
        } else {
          taskCount = '${tasksListProviderTrue.leftTaskCount} left';
        }
      }
    } else if (settingsProviderTrue.settings.hideCompletedTasks == null) {
      if (tasksListProviderTrue.leftTaskCount == 0) {
        taskCount = 'Well\nDone!';
      } else {
        taskCount =
            '${tasksListProviderTrue.leftTaskCount} left\n${tasksListProviderTrue.taskCount - tasksListProviderTrue.leftTaskCount} completed';
      }
    }
    return taskCount;
  }

  @override
  Widget build(BuildContext context) {
    TasksListProvider tasksListProviderTrue =
        Provider.of<TasksListProvider>(context);
    return Visibility(
      visible: tasksListProviderTrue.taskCount != null
          ? tasksListProviderTrue.taskCount == 0 ? false : true
          : false,
      child: Text(
        taskCountText(context),
        style: TextStyle(
          fontFamily: 'GothamLight',
          fontSize: 16.0,
          color: kInactiveColor,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
