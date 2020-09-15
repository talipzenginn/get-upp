import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;
import '../../providers/settings_provider.dart';
import '../../components/widgets/dismissible_task.dart';
import '../../providers/tasks_list_provider.dart';

class DismissibleTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksListProvider>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = Provider.of<SettingsProvider>(context)
                        .settings
                        .hideCompletedTasks ==
                    null
                ? taskData.displayingAllTasks[index]
                : Provider.of<SettingsProvider>(context)
                        .settings
                        .hideCompletedTasks
                    ? taskData.displayingLeftTasks[index]
                    : taskData.displayingAllTasks[index];
            return DismissibleTask(
              task: task,
              index: index,
            );
          },
          itemCount: Provider.of<SettingsProvider>(context)
                      .settings
                      .hideCompletedTasks ==
                  null
              ? taskData.taskCount
              : Provider.of<SettingsProvider>(context)
                      .settings
                      .hideCompletedTasks
                  ? taskData.leftTaskCount
                  : taskData.taskCount,
        );
      },
    );
  }
}
