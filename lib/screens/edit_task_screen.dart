import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart'
    show DatePicker, DateTimePickerLocale;
import 'package:provider/provider.dart' show Provider;
import '../components/constants.dart';
import '../components/widgets/reusable_button.dart';
import '../providers/active_color_provider.dart';
import '../providers/tasks_list_provider.dart';

class EditTaskScreen extends StatefulWidget {
  final int index;
  final int day;
  final int month;
  final int year;
  final String title;
  final lessActiveness;
  final middleActiveness;
  final moreActiveness;
  EditTaskScreen(
      {this.index,
      this.day,
      this.month,
      this.year,
      this.title,
      this.lessActiveness,
      this.middleActiveness,
      this.moreActiveness});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState(
      lessActiveness: lessActiveness,
      middleActiveness: middleActiveness,
      moreActiveness: moreActiveness);
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  bool lessActiveness;
  bool middleActiveness;
  bool moreActiveness;
  _EditTaskScreenState(
      {this.lessActiveness, this.middleActiveness, this.moreActiveness});
  String taskName = '';
  int importanceValue;
  DateTime newDateTime;
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Edit Task',
                  style: TextStyle(color: kEditTaskScreenTitle, fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Theme(
                data: ThemeData.light()
                    .copyWith(accentColor: kEditTaskScreenTitle),
                child: TextField(
                  maxLines: null,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: widget.title,
                  ),
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      taskName = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Priority',
                    style:
                        TextStyle(color: kEditTaskScreenTitle, fontSize: 22.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.6),
                child: Row(
                  children: <Widget>[
                    ReusableButton(
                      onTapfunction: () {
                        Provider.of<ActiveColorProvider>(context, listen: false)
                            .changeLessButtonColor();
                        lessActiveness = !lessActiveness;
                        middleActiveness = false;
                        moreActiveness = false;
                      },
                      bodyColor: Provider.of<ActiveColorProvider>(context)
                          .lessButtonColor,
                      text: 'less',
                      textSize: 12.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ReusableButton(
                      onTapfunction: () {
                        Provider.of<ActiveColorProvider>(context, listen: false)
                            .changeMiddleButtonColor();
                        middleActiveness = !middleActiveness;
                        lessActiveness = false;
                        moreActiveness = false;
                      },
                      bodyColor: Provider.of<ActiveColorProvider>(context)
                          .middleButtonColor,
                      text: 'middle',
                      textSize: 12.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ReusableButton(
                      onTapfunction: () {
                        Provider.of<ActiveColorProvider>(context, listen: false)
                            .changeMoreButtonColor();
                        moreActiveness = !moreActiveness;
                        lessActiveness = false;
                        middleActiveness = false;
                      },
                      bodyColor: Provider.of<ActiveColorProvider>(context)
                          .moreButtonColor,
                      text: 'more',
                      textSize: 12.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Due Date',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: kEditTaskScreenTitle, fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableButton(
                      onTapfunction: () {
//                        showRoundedDatePicker(
//                            context: context,
//                            borderRadius: 16,
//                            initialDate: widget.year != 0?DateTime.utc(widget.year,widget.month,widget.day):newDateTime == null
//                                ? DateTime.now()
//                                : newDateTime,
//                            firstDate: DateTime(DateTime.now().year),
//                            lastDate: DateTime(DateTime.now().year + 4))
//                            .then((value) {
//                          setState(() {
//                            newDateTime = value;
//                          });
//                        });
                        DatePicker.showSimpleDatePicker(
                          context,
                          textColor: kEditTaskScreenDueDatePicker,
                          titleText: 'Select Due Date',
                          initialDate: widget.year != 0
                              ? DateTime.utc(
                                  widget.year, widget.month, widget.day)
                              : newDateTime == null
                                  ? DateTime.now()
                                  : newDateTime,
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(DateTime.now().year + 8),
                          dateFormat: "dd-MMMM-yyyy",
                          locale: DateTimePickerLocale.en_us,
                          looping: false,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              newDateTime = value;
                            });
                          }
                        });
                      },
                      bodyColor: kEditTaskScreenButtonBody,
                      text: Provider.of<TasksListProvider>(context)
                                      .displayingTasks[widget.index]
                                      .year ==
                                  0 &&
                              newDateTime == null
                          ? 'Add Due Date'
                          : 'Edit Due Date',
                      textSize: 11.0,
                    ),
                    Visibility(
                      visible: Provider.of<TasksListProvider>(context)
                                      .displayingTasks[widget.index]
                                      .year ==
                                  0 &&
                              newDateTime == null
                          ? false
                          : true,
                      child: SizedBox(
                        width: 10.0,
                      ),
                    ),
                    Visibility(
                      visible: Provider.of<TasksListProvider>(context)
                                      .displayingTasks[widget.index]
                                      .year ==
                                  0 &&
                              newDateTime == null
                          ? false
                          : true,
                      child: ReusableButton(
                        onTapfunction: () {
                          Provider.of<TasksListProvider>(context, listen: false)
                              .deleteTaskDueDate(widget.index);
                          setState(() {
                            newDateTime = null;
                          });
                        },
                        bodyColor: kEditTaskScreenButtonBody,
                        text: 'Delete Due Date',
                        textSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  if (lessActiveness) {
                    importanceValue = 1;
                  } else if (middleActiveness) {
                    importanceValue = 2;
                  } else if (moreActiveness) {
                    importanceValue = 3;
                  } else {
                    importanceValue = null;
                  }
                  if ((taskName != null && taskName != '') &&
                      newDateTime != null) {
                    Provider.of<TasksListProvider>(context, listen: false)
                        .updateTaskTitle(taskName, widget.index);
                    Provider.of<TasksListProvider>(context, listen: false)
                        .updateTaskDueDate(newDateTime.year, newDateTime.month,
                            newDateTime.day, widget.index);
                  } else if (taskName != null && taskName != '') {
                    Provider.of<TasksListProvider>(context, listen: false)
                        .updateTaskTitle(taskName, widget.index);
                  } else if (newDateTime != null) {
                    Provider.of<TasksListProvider>(context, listen: false)
                        .updateTaskDueDate(newDateTime.year, newDateTime.month,
                            newDateTime.day, widget.index);
                  }
                  Provider.of<TasksListProvider>(context, listen: false)
                      .updateTaskPriority(importanceValue, widget.index);
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                  taskName = null;
                  lessActiveness = false;
                  middleActiveness = false;
                  moreActiveness = false;
                  importanceValue = null;
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: kEditTaskScreenButtonBody,
                  ),
                ),
                color: kEditTaskScreenTitle,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: kEditTaskScreenButtonBody,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
