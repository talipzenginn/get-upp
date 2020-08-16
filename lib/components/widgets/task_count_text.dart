import 'package:flutter/material.dart';
import 'package:get_upp/providers/tasks_list_provider.dart';
import 'package:provider/provider.dart';

class TaskCountText extends StatelessWidget {
  const TaskCountText({
    Key key,
  }) : super(key: key);
  String taskCountText(BuildContext context) {
    String taskCount;
    if (Provider.of<TasksListProvider>(context).leftTaskCount == 0) {
      taskCount = 'Well\nDone!';
      return taskCount;
    } else {
      taskCount =
      '${Provider.of<TasksListProvider>(context).leftTaskCount} left\n${Provider.of<TasksListProvider>(context).taskCount - Provider.of<TasksListProvider>(context).leftTaskCount} completed';
      return taskCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Provider.of<TasksListProvider>(context).taskCount != null
          ? Provider.of<TasksListProvider>(context).taskCount == 0 ? false : true
          : false,
      child: Text(
        taskCountText(context),
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}