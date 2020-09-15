import 'package:flutter/material.dart';
import '../helpers/reusable_methods.dart';
import '../components/widgets/pick_color_button.dart';
import '../components/constants.dart';
import 'add_tag_screen.dart';

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
    colors = AddTagScreen().colors;
    selectedColor = AddTagScreen().colors[widget.colorIndex];
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
                child: Text(
                  'Edit Tag',
                  style: TextStyle(color: Color(0xFF3bb4c1), fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
              ),
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
                      child: Center(
                        child: Text(
                          'Pick a Color',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF3bb4c1), fontSize: 18.0),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        PickColorButton(
                          onTapFunction: () {
                            setState(() {
                              selectedColor = colors[0];
                            });
                          },
                          bodyColor: Colors.orange,
                          isIcon: selectedColor == Colors.orange ? true : false,
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
                          isIcon: selectedColor == Colors.red ? true : false,
                          bodyColor: Colors.red,
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
                          isIcon: selectedColor == Colors.yellow ? true : false,
                          bodyColor: Colors.yellow,
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
                          isIcon: selectedColor == Colors.greenAccent
                              ? true
                              : false,
                          bodyColor: Colors.greenAccent,
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
                          isIcon:
                              selectedColor == Colors.pinkAccent ? true : false,
                          bodyColor: Colors.pinkAccent,
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
                          isIcon: selectedColor == Colors.lightBlueAccent
                              ? true
                              : false,
                          bodyColor: Colors.lightBlueAccent,
                        )
                      ],
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  ReusableMethods().editTag(
                      colors: colors,
                      selectedColor: selectedColor,
                      selectColorIndex: selectColorIndex,
                      tagName: tagName,
                      index: widget.index,
                      context: context);
                },
                child: Text(
                  'Edit',
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
