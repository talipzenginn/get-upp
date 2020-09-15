import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../../providers/settings_provider.dart';
import '../../providers/tasks_list_provider.dart';
import '../../components/constants.dart';

class TaskCountText extends StatelessWidget {
  const TaskCountText({
    Key key,
  }) : super(key: key);
  String taskCountText(BuildContext context) {
    String taskCount;
    if (Provider.of<SettingsProvider>(context).settings.hideCompletedTasks !=
        null) {
      if (!Provider.of<SettingsProvider>(context).settings.hideCompletedTasks) {
        if (Provider.of<TasksListProvider>(context).leftTaskCount == 0) {
          taskCount = 'Well\nDone!';
        } else {
          taskCount =
              '${Provider.of<TasksListProvider>(context).leftTaskCount} left\n${Provider.of<TasksListProvider>(context).taskCount - Provider.of<TasksListProvider>(context).leftTaskCount} completed';
        }
      } else if (Provider.of<SettingsProvider>(context)
          .settings
          .hideCompletedTasks) {
        if (Provider.of<TasksListProvider>(context).leftTaskCount == 0) {
          taskCount = '';
        } else {
          taskCount =
              '${Provider.of<TasksListProvider>(context).leftTaskCount} left';
        }
      }
    } else if (Provider.of<SettingsProvider>(context)
            .settings
            .hideCompletedTasks ==
        null) {
      if (Provider.of<TasksListProvider>(context).leftTaskCount == 0) {
        taskCount = 'Well\nDone!';
      } else {
        taskCount =
            '${Provider.of<TasksListProvider>(context).leftTaskCount} left\n${Provider.of<TasksListProvider>(context).taskCount - Provider.of<TasksListProvider>(context).leftTaskCount} completed';
      }
    }
    return taskCount;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Provider.of<TasksListProvider>(context).taskCount != null
          ? Provider.of<TasksListProvider>(context).taskCount == 0
              ? false
              : true
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
