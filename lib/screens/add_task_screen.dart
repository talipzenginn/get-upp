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
import '../providers/tags_list_provider.dart';

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
  String jsonRequest;
  @override
  Widget build(BuildContext context) {
    ActiveColorProvider activeColorProviderFalse =
        Provider.of<ActiveColorProvider>(context, listen: false);
    ActiveColorProvider activeColorProviderTrue =
        Provider.of<ActiveColorProvider>(context);
    TagsListProvider tagsListProviderFalse =
        Provider.of<TagsListProvider>(context, listen: false);
    TagsListProvider tagsListProviderTrue =
        Provider.of<TagsListProvider>(context);
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
                  child: AddEditScreensText(
                    text: 'Add Task',
                    textSize: 30.0,
                  )),
              Theme(
                data:
                    ThemeData.light().copyWith(primaryColor: Color(0xFF048998)),
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
                child: AddEditScreensText(
                  text: 'Priority',
                  textSize: 22.0,
                ),
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
                child:
                    AddEditScreensText(text: 'Give Due Date', textSize: 18.0),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.6),
                child: Row(
                  children: [
                    ReusableButton(
                      onTapFunction: () {
//                           showRoundedDatePicker( context: context,borderRadius: 16,initialDate: newDateTime == null? DateTime.now(): newDateTime,firstDate: DateTime(DateTime.now().year),lastDate: DateTime(DateTime.now().year + 4)).then((value) {setState(() {newDateTime = value;});});
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
                        onTapFunction: () {
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
              Visibility(
                visible: tagsListProviderTrue.tagsCount == 0 ? false : true,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 4.0, left: 8.0, right: 8.0),
                  child: AddEditScreensText(
                    text: 'Tag it',
                    textSize: 18.0,
                  ),
                ),
              ),
              Visibility(
                visible: tagsListProviderTrue.tagsCount == 0 ? false : true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: kInactiveColor,
                              border: Border.all(
                                color: kReusableButtonBody,
                              ),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ExpansionTile(
                              title: Text(
                                'Pick Your Tags',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14.0),
                              ),
                              onExpansionChanged: (v) {
                                FocusScope.of(context).unfocus();
                              },
                              children: [
                                Container(
                                  width: 400,
                                  height: tagsListProviderTrue.tagsCount <= 1
                                      ? 60
                                      : tagsListProviderTrue.tagsCount <= 2
                                          ? 120
                                          : tagsListProviderTrue.tagsCount <= 3
                                              ? 180
                                              : 220,
                                  child: ListView.builder(
                                    itemCount: tagsListProviderTrue.tagsCount,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(tagsListProviderTrue
                                            .tags[index].name),
                                        trailing: Checkbox(
                                          activeColor: kAppBarColor,
                                          value: tagsListProviderTrue
                                              .tagsChecked[index],
                                          onChanged: (value) {
                                            tagsListProviderFalse
                                                .updateSelection(index, value);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  ReusableMethods().addTask(
                      lessActiveness: lessActiveness,
                      middleActiveness: middleActiveness,
                      moreActiveness: moreActiveness,
                      importanceValue: importanceValue,
                      taskName: taskName,
                      newDateTime: newDateTime,
                      jsonRequest: jsonRequest,
                      context: context,
                      elseFunction: () {
                        setState(() {
                          errorTextVisible = true;
                        });
                      });
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: kInactiveColor,
                  ),
                ),
                color: kAppBarColor,
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
