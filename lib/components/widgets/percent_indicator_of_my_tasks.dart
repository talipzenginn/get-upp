import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart'
    show CircularStrokeCap, CircularPercentIndicator;
import 'package:provider/provider.dart' show Provider;
import '../../components/constants.dart';
import '../../providers/settings_provider.dart';
import '../../providers/tasks_list_provider.dart';

class PercentIndicatorOfMyTasks extends StatelessWidget {
  const PercentIndicatorOfMyTasks({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProviderTrue =
        Provider.of<SettingsProvider>(context);
    TasksListProvider tasksListProviderTrue =
        Provider.of<TasksListProvider>(context);
    double percentage = ((tasksListProviderTrue.taskCount -
                tasksListProviderTrue.leftTaskCount) /
            tasksListProviderTrue.taskCount) *
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
      visible: tasksListProviderTrue.taskCount != null
          ? tasksListProviderTrue.taskCount == 0
              ? false
              : settingsProviderTrue.settings.hideCompletedTasks == null
                  ? true
                  : settingsProviderTrue.settings.hideCompletedTasks
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
        backgroundColor: Color(0xFF048998),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: kInactiveColor,
      ),
    );
  }
}
