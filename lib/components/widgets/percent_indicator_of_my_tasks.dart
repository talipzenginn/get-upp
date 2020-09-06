import 'package:flutter/material.dart';
import '../../providers/settings_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart'
    show CircularStrokeCap, CircularPercentIndicator;
import 'package:provider/provider.dart' show Provider;
import '../../components/constants.dart';
import '../../providers/tasks_list_provider.dart';

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
          ? Provider.of<TasksListProvider>(context).taskCount == 0
              ? false
              : Provider.of<SettingsProvider>(context)
                          .settings
                          .hideCompletedTasks ==
                      null
                  ? true
                  : Provider.of<SettingsProvider>(context)
                          .settings
                          .hideCompletedTasks
                      ? false
                      : true
          : false,
      child: CircularPercentIndicator(
        animation: true,
        animationDuration: 1200,
        radius: 58.5,
        lineWidth: 5.6,
        percent: percent,
        center: Visibility(
          visible: visible(),
          child: Text(
            '%${percentage.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: 'Gotham',
              fontSize: 12.2,
              color: kInactiveColor,
            ),
          ),
        ),
        backgroundColor: kPercentIndicatorBackground,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: kInactiveColor,
      ),
    );
  }
}
