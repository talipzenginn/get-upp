import 'package:flutter/material.dart';
import '../components/widgets/add_edit_screens_text.dart';
import '../helpers/reusable_methods.dart';
import '../components/widgets/pick_color_button.dart';
import '../components/constants.dart';
import './add_tag_screen.dart';

class EditTagScreen extends StatefulWidget {
  final String title;
  final int colorIndex;
  final int index;
  const EditTagScreen({this.title, this.colorIndex, this.index});
  @override
  _EditTagScreenState createState() => _EditTagScreenState();
}

class _EditTagScreenState extends State<EditTagScreen> {
  Color selectedColor;
  int selectColorIndex;
  List<Color> colors;
  String tagName = '';
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    colors = AddTagScreen.colors;
    selectedColor = AddTagScreen.colors[widget.colorIndex];
    selectColorIndex = widget.colorIndex;
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
                  child: AddEditScreensText(text: 'Edit Tag', textSize: 30.0)),
              Theme(
                data: ThemeData.light().copyWith(primaryColor: kAppBarColor),
                child: TextFormField(
                  maxLines: null,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Tag Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: widget.title,
                  ),
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      tagName = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: AddEditScreensText(
                            text: 'Pick a Color', textSize: 18.0)),
                    Row(
                      children: [
                        PickColorButton(
                          onTapFunction: () {
                            setState(() {
                              selectedColor = colors[0];
                            });
                          },
                          bodyColor: kTagColor0,
                          isIcon: selectedColor == kTagColor0 ? true : false,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        PickColorButton(
                          onTapFunction: () {
                            setState(() {
                              selectedColor = colors[1];
                            });
                          },
                          isIcon: selectedColor == kTagColor1 ? true : false,
                          bodyColor: kTagColor1,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        PickColorButton(
                          onTapFunction: () {
                            setState(() {
                              selectedColor = colors[2];
                            });
                          },
                          isIcon: selectedColor == kTagColor2 ? true : false,
                          bodyColor: kTagColor2,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        PickColorButton(
                          onTapFunction: () {
                            setState(() {
                              selectedColor = colors[3];
                            });
                          },
                          isIcon: selectedColor == kTagColor3 ? true : false,
                          bodyColor: kTagColor3,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        PickColorButton(
                          onTapFunction: () {
                            setState(() {
                              selectedColor = colors[4];
                            });
                          },
                          isIcon: selectedColor == kTagColor4 ? true : false,
                          bodyColor: kTagColor4,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        PickColorButton(
                          onTapFunction: () {
                            setState(() {
                              selectedColor = colors[5];
                            });
                          },
                          isIcon: selectedColor == kTagColor5 ? true : false,
                          bodyColor: kTagColor5,
                        )
                      ],
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  ReusableMethods.editTag(
                      colors: colors,
                      selectedColor: selectedColor,
                      selectColorIndex: selectColorIndex,
                      tagName: tagName,
                      index: widget.index,
                      context: context);
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: kAddTaskScreenButtonBody,
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
