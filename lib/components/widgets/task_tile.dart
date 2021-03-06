import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart'
    show CircularCheckBox;
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Provider;
import '../../screens/add_tag_screen.dart';
import '../../models/tag.dart';
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
  final List<Tag> tagList;
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
    this.tagList,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: kExpansionTileBackground,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 0.0),
              leading: CircularCheckBox(
                value: isChecked,
                onChanged: checkboxCallback,
                inactiveColor: importanceValue == 1
                    ? kLessButtonActiveColor
                    : importanceValue == 2
                        ? kMiddleButtonActiveColor
                        : importanceValue == 3
                            ? kMoreButtonActiveColor
                            : kCheckboxInactiveColor,
                activeColor: kCheckboxActiveColor,
                checkColor: kInactiveColor,
              ),
              title: Text(
                taskTitle,
                style: TextStyle(
                    color: kDisplayingTasksTitleColor,
                    fontSize: 14.1,
                    decoration:
                        isChecked == true ? TextDecoration.lineThrough : null),
              ),
            ),
          ],
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 26.0, bottom: 10.0),
                child: Visibility(
                    visible: year == 0 ? false : true,
                    child: Text(
                      'Due date: ${ReusableMethods.weekdayString(DateTime.utc(year, month, day).weekday)}, $day.$month.$year',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'GothamBook',
                          color: kDisplayingTasksDueDateColor),
                    )),
              ),
              Visibility(
                visible: tagList.length == 0 ? false : true,
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tagList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.all(6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kInactiveColor,
                            border: Border.all(
                                color: AddTagScreen
                                    .colors[tagList[index].colorIndex])),
                        child: Text(
                          tagList[index].name,
                          style: TextStyle(
                              fontFamily: 'GothamBook',
                              color: tagList[index].colorIndex == 2
                                  ? Colors.black45
                                  : AddTagScreen
                                      .colors[tagList[index].colorIndex]),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.edit,
                        color: kEditButtonColor,
                        size: 22.0,
                      ),
                      onPressed: () {
                        ReusableMethods.openEditTaskScreen(
                            context, task, index);
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
