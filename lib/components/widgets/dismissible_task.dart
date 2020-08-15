import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_upp/components/widgets/task_tile.dart';
import 'package:get_upp/models/task.dart';
import 'package:get_upp/providers/active_color_provider.dart';
import 'package:get_upp/providers/tasks_list_provider.dart';
import 'package:get_upp/screens/edit_task_screen.dart';
import 'package:provider/provider.dart';

class DismissibleTask extends StatelessWidget {
  final Task task;
  final int index;
  DismissibleTask({Key key, this.task, this.index});
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TasksListProvider>(context);
    return Dismissible(
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green[400],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                FontAwesomeIcons.edit,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                FontAwesomeIcons.trashAlt,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ],
        ),
      ),
      key: ValueKey(taskData.displayingTasks[index].name),
      onDismissed: (direction) {
        taskData.displayingTasks.removeAt(index);
      },
      confirmDismiss: (direction) => promptUser(
          index: index,
          taskData: taskData,
          context: context,
          task: taskData.displayingTasks[index],
          direction: direction),
      child: TaskTile(
        taskTitle: task.name,
        isChecked: task.isDone,
        checkboxCallback: (bool checkboxState) {
          Provider.of<TasksListProvider>(context, listen: false)
              .updateCheckProperty(task);
        },
        importanceValue: task.importanceValue,
        year: task.year,
        month: task.month,
        day: task.day,
      ),
    );
  }

  Future<bool> promptUser(
      {DismissDirection direction,
      TasksListProvider taskData,
      Task task,
      BuildContext context,
      int index}) async {
    if (direction == DismissDirection.startToEnd) {
      Provider.of<ActiveColorProvider>(context, listen: false)
          .inactivateColors();
      if (task.importanceValue == 1) {
        Provider.of<ActiveColorProvider>(context,listen: false).changeLessButtonColor();
      } else if (task.importanceValue == 2) {
        Provider.of<ActiveColorProvider>(context,listen: false).changeMiddleButtonColor();
      } else if (task.importanceValue == 3) {
        Provider.of<ActiveColorProvider>(context,listen: false).changeMoreButtonColor();
      }
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(
            importanceDegree: task.importanceValue,
            index: index,
            day: task.day,
            month: task.month,
            year: task.year,
            title: task.name,
          ),
        ),
      );
    } else if (direction == DismissDirection.endToStart) {
      return await showDialog<bool>(
            barrierDismissible: true,
            context: context,
            builder: (context) => AlertDialog(
              elevation: 24.0,
              title: Text(
                'Sure?',
              ),
              content: Text(
                'Are you sure about deleting this task?',
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    taskData.deleteTask(task);
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ) ??
          false;
    }
  }
}
