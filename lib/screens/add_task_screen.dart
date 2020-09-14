import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart'
    show DatePicker, DateTimePickerLocale;
import 'package:provider/provider.dart' show Provider;
import '../components/constants.dart';
import '../components/widgets/reusable_button.dart';
import '../providers/active_color_provider.dart';
import '../models/task.dart';
import '../providers/tasks_list_provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskName;

  int importanceValue;

  bool lessActiveness = false;

  bool middleActiveness = false;

  bool moreActiveness = false;

  DateTime newDateTime;

  bool errorTextVisible = false;

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
                  'Add Task',
                  style: TextStyle(color: kAddTaskScreenTitle, fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Theme(
                data: ThemeData.light()
                    .copyWith(accentColor: kAddTaskScreenTitle),
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    errorText: errorTextVisible == true
                        ? 'You should type title'
                        : null,
                    hintText: 'Type your title',
                  ),
                  autofocus: newDateTime == null ? true : false,
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
                        TextStyle(color: kAddTaskScreenTitle, fontSize: 22.0),
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
                      borderColor: kReusableButtonBody,
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
                      borderColor: kReusableButtonBody,
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
                      borderColor: kReusableButtonBody,
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
                    'Give Due Date',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: kAddTaskScreenTitle, fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.6),
                child: Row(
                  children: [
                    ReusableButton(
                      onTapfunction: () {
//                        showRoundedDatePicker(
//                                context: context,
//                                borderRadius: 16,
//                                initialDate: newDateTime == null
//                                    ? DateTime.now()
//                                    : newDateTime,
//                                firstDate: DateTime(DateTime.now().year),
//                                lastDate: DateTime(DateTime.now().year + 4))
//                            .then((value) {
//                          setState(() {
//                            newDateTime = value;
//                          });
//                        });
                        DatePicker.showSimpleDatePicker(
                          context,
                          textColor: kAddTaskScreenDueDatePicker,
                          titleText: 'Select Due Date',
                          initialDate: newDateTime == null
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
                      borderColor: kReusableButtonBody,
                      bodyColor: kAddTaskScreenButtonBody,
                      text: newDateTime == null
                          ? 'Add Due Date'
                          : 'Edit Due Date',
                      textSize: 13.0,
                    ),
                    Visibility(
                      visible: newDateTime == null ? false : true,
                      child: SizedBox(
                        width: 10.0,
                      ),
                    ),
                    Visibility(
                      visible: newDateTime == null ? false : true,
                      child: ReusableButton(
                        onTapfunction: () {
                          setState(() {
                            newDateTime = null;
                          });
                        },
                        borderColor: kReusableButtonBody,
                        bodyColor: kAddTaskScreenButtonBody,
                        text: 'Delete Due Date',
                        textSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 4.0, left: 8.0, right: 8.0),
                child: Center(
                  child: Text(
                    'Tag it',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: kAddTaskScreenTitle, fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: [
                    ReusableButton(
                      onTapfunction: () {},
                      borderColor: kReusableButtonBody,
                      bodyColor: kInactiveColor,
                      text: '+ Add Tag',
                      textSize: 12.0,
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
                        .addTask(Task(
                            name: taskName,
                            importanceValue: importanceValue,
                            year: newDateTime.year,
                            month: newDateTime.month,
                            day: newDateTime.day));
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                    taskName = null;
                    lessActiveness = false;
                    middleActiveness = false;
                    moreActiveness = false;
                    importanceValue = null;
                    newDateTime = null;
                  } else if (taskName != null && taskName != '') {
                    Provider.of<TasksListProvider>(context, listen: false)
                        .addTask(Task(
                            name: taskName, importanceValue: importanceValue));
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                    taskName = null;
                    lessActiveness = false;
                    middleActiveness = false;
                    moreActiveness = false;
                    importanceValue = null;
                  } else {
                    setState(() {
                      errorTextVisible = true;
                    });
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: kAddTaskScreenButtonBody,
                  ),
                ),
                color: kAddTaskScreenTitle,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: kAddTaskScreenButtonBody,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
