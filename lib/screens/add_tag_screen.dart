import 'package:flutter/material.dart';
import '../components/widgets/add_edit_screens_text.dart';
import '../helpers/reusable_methods.dart';
import '../components/widgets/pick_color_button.dart';
import '../components/constants.dart';

class AddTagScreen extends StatefulWidget {
  final List<Color> colors = [
    Colors.orange,
    Colors.red,
    Colors.yellow,
    Colors.greenAccent,
    Colors.pinkAccent,
    Colors.lightBlueAccent,
  ];
  @override
  _AddTagScreenState createState() => _AddTagScreenState();
}

class _AddTagScreenState extends State<AddTagScreen> {
  String tagName;
  Color selectedColor = Colors.lightBlueAccent;
  int selectColorIndex = 5;
  List<Color> colors;
  @override
  void initState() {
    super.initState();
    colors = widget.colors;
  }

  bool errorTextVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: AddEditScreensText(text: 'Add Tag', textSize: 30.0)),
            Theme(
              data: ThemeData.light().copyWith(primaryColor: Color(0xFF048998)),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  errorText:
                      errorTextVisible == true ? 'You should type title' : null,
                  hintText: 'Type your title',
                ),
                textAlign: TextAlign.center,
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
                        isIcon:
                            selectedColor == Colors.greenAccent ? true : false,
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
                ReusableMethods().addTag(
                    colors: colors,
                    selectedColor: selectedColor,
                    selectColorIndex: selectColorIndex,
                    tagName: tagName,
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
                  color: kAddTaskScreenButtonBody,
                ),
              ),
              color: Color(0xFF3bb4c1),
            ),
          ]),
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
