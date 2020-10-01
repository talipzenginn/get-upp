import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Provider;
import '../../helpers/selected_tag_list_convert_json.dart';
import '../../components/widgets/reusable_snack_bar.dart';
import '../../components/constants.dart';
import '../../components/widgets/task_tile.dart';
import '../../helpers/reusable_methods.dart';
import '../../models/task.dart';
import '../../providers/tasks_list_provider.dart';

class DismissibleTask extends StatelessWidget {
  final Task task;
  final int index;
  DismissibleTask({Key key, this.task, this.index});
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TasksListProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 8.0, right: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: kInactiveColor),
        child: Theme(
          data: ThemeData(
              accentColor: Colors.black, dividerColor: Colors.transparent),
          child: Dismissible(
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: kEditDismissBackground,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      FontAwesomeIcons.edit,
                      color: kInactiveColor,
                      size: 25.0,
                    ),
                  ),
                ],
              ),
            ),
            secondaryBackground: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: kDeleteDismissBackground,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      FontAwesomeIcons.trashAlt,
                      color: kInactiveColor,
                      size: 25.0,
                    ),
                  ),
                ],
              ),
            ),
            key: ValueKey(taskData.displayingAllTasks[index].name),
            onDismissed: (direction) {
              taskData.displayingAllTasks.removeAt(index);
            },
            confirmDismiss: (direction) => promptUser(
                index: index,
                taskData: taskData,
                context: context,
                task: taskData.displayingAllTasks[index],
                direction: direction),
            child: TaskTile(
              index: index,
              task: task,
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (bool checkboxState) {
                Provider.of<TasksListProvider>(context, listen: false)
                    .updateCheckProperty(task);
                if (checkboxState) {
                  Scaffold.of(context).showSnackBar(ReusableSnackBar()
                      .snackBarWithContent(
                          snackBarContent: "Task Completed",
                          snackBarColor: Colors.teal));
                }
              },
              importanceValue: task.importanceValue,
              year: task.year,
              month: task.month,
              day: task.day,
              tagList: SelectedTagListConvertJson.fromJson(
                      jsonDecode(task.tagListJson))
                  .selectedTagsList,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> promptUser(
      {DismissDirection direction,
      TasksListProvider taskData,
      Task task,
      BuildContext context,
      int index}) async {
    bool confirm;
    if (direction == DismissDirection.startToEnd) {
      ReusableMethods.openEditTaskScreen(context, task, index);
    } else if (direction == DismissDirection.endToStart) {
      confirm = await showDialog<bool>(
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
                    style: TextStyle(color: kConfirmColor),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
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
          ) ??
          false;
    }
    return confirm;
  }
}
