import 'package:flutter/material.dart';
import 'package:get_upp/providers/tasks_list_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class PercentIndicatorOfMyTasks extends StatelessWidget {
  const PercentIndicatorOfMyTasks({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double percentage = ((Provider.of<TasksListProvider>(context).taskCount -
        Provider.of<TasksListProvider>(context).leftTaskCount) /
        Provider.of<TasksListProvider>(context).taskCount) *
        100;
    double percent = percentage / 100;
    bool visible() {
      if (percentage != null) {
        return true;
      } else {
        return false;
      }
    }

    return Visibility(
      visible: Provider.of<TasksListProvider>(context).taskCount != null
          ? Provider.of<TasksListProvider>(context).taskCount == 0 ? false : true
          : false,
      child: CircularPercentIndicator(
        radius: 57.0,
        lineWidth: 5.0,
        percent: percent,
        center: Visibility(
          visible: visible(),
          child: Text(
            '%${percentage.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 12.2,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue[600],
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Colors.white,
      ),
    );
  }
}