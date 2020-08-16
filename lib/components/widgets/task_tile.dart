import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_upp/models/task.dart';
import 'package:get_upp/providers/active_color_provider.dart';
import 'package:get_upp/providers/tasks_list_provider.dart';
import 'package:get_upp/screens/edit_task_screen.dart';
import 'package:provider/provider.dart';
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
    this.checkboxCallback, this.importanceValue, this.year, this.month, this.day, this.index, this.task,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxListTile(
            secondary: Icon(FontAwesomeIcons.circle,color: importanceValue == 1?kLessButtonActiveColor:importanceValue==2?kMiddleButtonActiveColor:importanceValue==3?kMoreButtonActiveColor:Colors.white,),
            title: Text(
              taskTitle,
              style: TextStyle(
                fontSize: 14.1,
                  decoration: isChecked == true ? TextDecoration.lineThrough : null),
            ),
            value: isChecked,
            onChanged: checkboxCallback,
            controlAffinity: ListTileControlAffinity.platform,
            activeColor: kCheckboxColor,
            checkColor: Colors.white,
          ),
        ],
      ),
      children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 90.0,),
                      Visibility(visible:year == 0?false:true,child: Text('Due date: $day.$month.$year',style: TextStyle(fontSize: 12.0,color: Colors.blueGrey),)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.edit,
                          color: Colors.green,
                          size: 22.0,
                        ),
                        onPressed: () {
                          Provider.of<ActiveColorProvider>(context, listen: false)
                              .inactivateColors();
                          if (importanceValue == 1) {
                            Provider.of<ActiveColorProvider>(context,listen: false).changeLessButtonColor();
                          } else if (importanceValue == 2) {
                            Provider.of<ActiveColorProvider>(context,listen: false).changeMiddleButtonColor();
                          } else if (importanceValue == 3) {
                            Provider.of<ActiveColorProvider>(context,listen: false).changeMoreButtonColor();
                          }
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) => SingleChildScrollView(
                              padding:
                              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: EditTaskScreen(
                                importanceDegree: importanceValue,
                                index: index,
                                day: day,
                                month: month,
                                year: year,
                                title: taskTitle,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.trashAlt,
                          color: Colors.red,
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
                                    Provider.of<TasksListProvider>(context,listen: false).deleteTask(task);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
