import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart'
    show DatePicker, DateTimePickerLocale;
import 'package:provider/provider.dart' show Provider;
import '../components/widgets/add_edit_screens_text.dart';
import '../helpers/reusable_methods.dart';
import '../components/widgets/priority_button.dart';
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
    ActiveColorProvider activeColorProviderFalse =
        Provider.of<ActiveColorProvider>(context, listen: false);
    ActiveColorProvider activeColorProviderTrue =
        Provider.of<ActiveColorProvider>(context);
    TasksListProvider tasksListProviderFalse =
        Provider.of<TasksListProvider>(context, listen: false);
    TasksListProvider tasksListProviderTrue =
        Provider.of<TasksListProvider>(context);
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
                  child: AddEditScreensText(text: 'Edit Task', textSize: 30.0)),
              Theme(
                data:
                    ThemeData.light().copyWith(primaryColor: Color(0xFF048998)),
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
                    child:
                        AddEditScreensText(text: 'Priority', textSize: 22.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.6),
                child: Row(
                  children: <Widget>[
                    PriorityButton(
                      onTapFunction: () {
                        activeColorProviderFalse.changeLessButtonColor();
                        lessActiveness = !lessActiveness;
                        middleActiveness = false;
                        moreActiveness = false;
                      },
                      bodyColor: activeColorProviderTrue.lessButtonColor,
                      text: 'less',
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    PriorityButton(
                      onTapFunction: () {
                        activeColorProviderFalse.changeMiddleButtonColor();
                        middleActiveness = !middleActiveness;
                        lessActiveness = false;
                        moreActiveness = false;
                      },
                      bodyColor: activeColorProviderTrue.middleButtonColor,
                      text: 'middle',
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    PriorityButton(
                      onTapFunction: () {
                        activeColorProviderFalse.changeMoreButtonColor();
                        moreActiveness = !moreActiveness;
                        lessActiveness = false;
                        middleActiveness = false;
                      },
                      bodyColor: activeColorProviderTrue.moreButtonColor,
                      text: 'more',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child:
                        AddEditScreensText(text: 'Due Date', textSize: 18.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableButton(
                      onTapFunction: () {
//                          showRoundedDatePicker( context: context,borderRadius: 16, initialDate: widget.year != 0?DateTime.utc(widget.year,widget.month,widget.day):newDateTime == null? DateTime.now(): newDateTime,firstDate: DateTime(DateTime.now().year),lastDate: DateTime(DateTime.now().year + 4)).then((value) { setState(() {newDateTime = value; }); });
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
                      borderColor: kReusableButtonBody,
                      bodyColor: kEditTaskScreenButtonBody,
                      text: tasksListProviderTrue
                                      .displayingAllTasks[widget.index].year ==
                                  0 &&
                              newDateTime == null
                          ? 'Add Due Date'
                          : 'Edit Due Date',
                      textSize: 11.0,
                    ),
                    Visibility(
                      visible: tasksListProviderTrue
                                      .displayingAllTasks[widget.index].year ==
                                  0 &&
                              newDateTime == null
                          ? false
                          : true,
                      child: SizedBox(
                        width: 10.0,
                      ),
                    ),
                    Visibility(
                      visible: tasksListProviderTrue
                                      .displayingAllTasks[widget.index].year ==
                                  0 &&
                              newDateTime == null
                          ? false
                          : true,
                      child: ReusableButton(
                        onTapFunction: () {
                          tasksListProviderFalse
                              .deleteTaskDueDate(widget.index);
                          setState(() {
                            newDateTime = null;
                          });
                        },
                        borderColor: kReusableButtonBody,
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
                  ReusableMethods().editTask(
                    lessActiveness: lessActiveness,
                    middleActiveness: middleActiveness,
                    moreActiveness: moreActiveness,
                    importanceValue: importanceValue,
                    taskName: taskName,
                    newDateTime: newDateTime,
                    index: widget.index,
                    context: context,
                  );
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: kEditTaskScreenButtonBody,
                  ),
                ),
                color: kBackgroundColor,
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
