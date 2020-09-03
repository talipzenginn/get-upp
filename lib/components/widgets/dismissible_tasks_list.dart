import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer;
import '../../components/widgets/dismissible_task.dart';
import '../../providers/tasks_list_provider.dart';

class DismissibleTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksListProvider>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.displayingTasks[index];
            return DismissibleTask(
              task: task,
              index: index,
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
