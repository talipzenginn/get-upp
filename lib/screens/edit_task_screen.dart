import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:get_upp/components/widgets/reusable_button.dart';
import 'package:get_upp/providers/active_color_provider.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_list_provider.dart';

class EditTaskScreen extends StatefulWidget {
  final int index;
  final int importanceDegree;
  final int day;
  final int month;
  final int year;
  final String title;
  bool lessActiveness = false;
  bool middleActiveness = false;
  bool moreActiveness = false;
  EditTaskScreen(
      {this.index, this.importanceDegree, this.day, this.month, this.year, this.title}) {
    if (importanceDegree == 1) {
      lessActiveness = true;
    } else if (importanceDegree == 2) {
      middleActiveness = true;
    } else if (importanceDegree == 3) {
      moreActiveness = true;
    }
  }

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
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
                  style:
                      TextStyle(color: Colors.lightBlueAccent, fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                maxLines: null,
                controller: controller,
                decoration: InputDecoration(
                  hintText:
                      widget.title,
                ),
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    taskName = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Priority',
                    style: TextStyle(
                        color: Colors.lightBlueAccent, fontSize: 22.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.6),
                child: Row(
                  children: <Widget>[
                    ReusableButton(
                      onTapfunction: () {
                        Provider.of<ActiveColorProvider>(context,
                            listen: false)
                            .changeLessButtonColor();
                        setState(() {
                          widget.lessActiveness = !widget.lessActiveness;
                          widget.middleActiveness = false;
                          widget.moreActiveness = false;
                        });
                      },
                      bodyColor: Provider.of<ActiveColorProvider>(context)
                          .lessButtonColor,
                      text: 'less',
                      textSize:12.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ReusableButton(
                      onTapfunction: () {
                        Provider.of<ActiveColorProvider>(context,
                            listen: false)
                            .changeMiddleButtonColor();
                        setState(() {
                          widget.middleActiveness = !widget.middleActiveness;
                          widget.lessActiveness = false;
                          widget.moreActiveness = false;
                        });
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
                        Provider.of<ActiveColorProvider>(context,
                            listen: false)
                            .changeMoreButtonColor();
                        setState(() {
                          widget.moreActiveness = !widget.moreActiveness;
                          widget.lessActiveness = false;
                          widget.middleActiveness = false;
                        });
                      },
                      bodyColor:  Provider.of<ActiveColorProvider>(context)
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
                    style: TextStyle(
                        color: Colors.lightBlueAccent, fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableButton(
                      onTapfunction:  () {
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
                          textColor: Colors.lightBlueAccent,
                          titleText: 'Select Due Date',
                          initialDate: widget.year != 0?DateTime.utc(widget.year,widget.month,widget.day):newDateTime == null
                               ? DateTime.now()
                               : newDateTime,
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(DateTime.now().year + 8),
                          dateFormat: "dd-MMMM-yyyy",
                          locale: DateTimePickerLocale.en_us,
                          looping: false,
                        ).then((value) {
                          if(value != null){
                            setState(() {
                              newDateTime = value;
                            });
                          }
                        });
                      },
                      bodyColor: Colors.white,
                      text:    Provider.of<TasksListProvider>(context).displayingTasks[widget.index].year == 0 && newDateTime == null
                          ? 'Add Due Date'
                          : 'Edit Due Date',
                      textSize: 11.0,
                    ),
                    Visibility(
                      visible: Provider.of<TasksListProvider>(context).displayingTasks[widget.index].year == 0 && newDateTime == null?false:true,
                      child: SizedBox(
                        width: 10.0,
                      ),
                    ),
                    Visibility(
                      visible: Provider.of<TasksListProvider>(context).displayingTasks[widget.index].year == 0 && newDateTime == null?false:true,
                      child:    ReusableButton(
                        onTapfunction: () {
                          Provider.of<TasksListProvider>(context, listen: false).deleteTaskDueDate(widget.index);
                          setState(() {
                            newDateTime = null;
                          });
                        },
                        bodyColor: Colors.white,
                        text: 'Delete Due Date',
                        textSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  if (widget.lessActiveness) {
                    importanceValue = 1;
                  } else if (widget.middleActiveness) {
                    importanceValue = 2;
                  } else if (widget.moreActiveness) {
                    importanceValue = 3;
                  } else {
                    importanceValue = null;
                  }
                  if ((taskName != null &&
                      taskName != '')&& newDateTime != null){
                    Provider.of<TasksListProvider>(context, listen: false)
                        .updateTaskTitle(taskName, widget.index);
                    Provider.of<TasksListProvider>(context, listen: false)
                        .updateTaskDueDate(
                        newDateTime.year,
                        newDateTime.month,
                        newDateTime.day,
                        widget.index);
                  } else if (taskName != null &&
                      taskName != '') {
                    Provider.of<TasksListProvider>(context, listen: false)
                        .updateTaskTitle(taskName, widget.index);
                  }else if(newDateTime!=null){
                    Provider.of<TasksListProvider>(context, listen: false)
                        .updateTaskDueDate(
                        newDateTime.year,
                        newDateTime.month,
                        newDateTime.day,
                        widget.index);
                  }
                  Provider.of<TasksListProvider>(context, listen: false)
                      .updateTaskPriority(importanceValue, widget.index);
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                  taskName = null;
                  widget.lessActiveness = false;
                  widget.middleActiveness = false;
                  widget.moreActiveness = false;
                  importanceValue = null;
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}