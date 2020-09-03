import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Provider;
import '../../helpers/reusable_methods.dart';
import '../../models/task.dart';
import '../../providers/tasks_list_provider.dart';
import '../../components/constants.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final int importanceValue;
  final Function checkboxCallback;
  final int year;
  final int month;
  final int day;
  final int index;
  final Task task;
  TaskTile({
    this.isChecked,
    this.taskTitle,
    this.checkboxCallback,
    this.importanceValue,
    this.year,
    this.month,
    this.day,
    this.index,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: kExpansionTileBackground,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(
              FontAwesomeIcons.circle,
              color: importanceValue == 1
                  ? kLessButtonActiveColor
                  : importanceValue == 2
                      ? kMiddleButtonActiveColor
                      : importanceValue == 3
                          ? kMoreButtonActiveColor
                          : kInactiveColor,
            ),
            title: Text(
              taskTitle,
              style: TextStyle(
                  color: kDisplayingTasksTitleColor,
                  fontSize: 14.1,
                  decoration:
                      isChecked == true ? TextDecoration.lineThrough : null),
            ),
            trailing: Checkbox(
              value: isChecked,
              onChanged: checkboxCallback,
              activeColor: kCheckboxColor,
              checkColor: kInactiveColor,
            ),
          ),
        ],
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 90.0,
                ),
                Visibility(
                    visible: year == 0 ? false : true,
                    child: Text(
                      'Due date: $day.$month.$year',
                      style: TextStyle(
                          fontSize: 12.0, color: kDisplayingTasksDueDateColor),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.edit,
                    color: kEditButtonColor,
                    size: 22.0,
                  ),
                  onPressed: () {
                    ReusableMethods().openEditTaskScreen(context, task, index);
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.trashAlt,
                    color: kDeleteButtonColor,
                    size: 22.0,
                  ),
                  onPressed: () {
                    showDialog(
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
                              Provider.of<TasksListProvider>(context,
                                      listen: false)
                                  .deleteTask(task);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(color: kConfirmColor),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'No',
                              style: TextStyle(color: kNotConfirmColor),
                            ),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
