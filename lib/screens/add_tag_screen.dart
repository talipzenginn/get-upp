import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../components/constants.dart';
import '../components/widgets/reusable_button.dart';
import '../models/tag.dart';
import '../providers/tags_list_provider.dart';

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
              child: Text(
                'Add Tag',
                style: TextStyle(color: kAddTaskScreenTitle, fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Theme(
              data:
                  ThemeData.light().copyWith(accentColor: kAddTaskScreenTitle),
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
                    child: Center(
                      child: Text(
                        'Pick a Color',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kAddTaskScreenTitle, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ReusableButton(
                        onTapfunction: () {
                          setState(() {
                            selectedColor = colors[0];
                          });
                        },
                        borderColor: Colors.black,
                        text: '',
                        textSize: 0,
                        bodyColor: Colors.orange,
                        isIcon: selectedColor == Colors.orange ? true : false,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ReusableButton(
                        onTapfunction: () {
                          setState(() {
                            selectedColor = colors[1];
                          });
                        },
                        isIcon: selectedColor == Colors.red ? true : false,
                        borderColor: Colors.black,
                        text: '',
                        textSize: 0,
                        bodyColor: Colors.red,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ReusableButton(
                        onTapfunction: () {
                          setState(() {
                            selectedColor = colors[2];
                          });
                        },
                        isIcon: selectedColor == Colors.yellow ? true : false,
                        borderColor: Colors.black,
                        text: '',
                        textSize: 0,
                        bodyColor: Colors.yellow,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      ReusableButton(
                        onTapfunction: () {
                          setState(() {
                            selectedColor = colors[3];
                          });
                        },
                        isIcon:
                            selectedColor == Colors.greenAccent ? true : false,
                        borderColor: Colors.black,
                        text: '',
                        textSize: 0,
                        bodyColor: Colors.greenAccent,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ReusableButton(
                        onTapfunction: () {
                          setState(() {
                            selectedColor = colors[4];
                          });
                        },
                        isIcon:
                            selectedColor == Colors.pinkAccent ? true : false,
                        borderColor: Colors.black,
                        text: '',
                        textSize: 0,
                        bodyColor: Colors.pinkAccent,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      ReusableButton(
                        onTapfunction: () {
                          setState(() {
                            selectedColor = colors[5];
                          });
                        },
                        isIcon: selectedColor == Colors.lightBlueAccent
                            ? true
                            : false,
                        borderColor: Colors.black,
                        text: '',
                        textSize: 0,
                        bodyColor: Colors.lightBlueAccent,
                      )
                    ],
                  )
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                for (Color color in colors) {
                  if (selectedColor == color) {
                    selectColorIndex = colors.indexOf(color);
                  }
                }
                if (tagName != null && tagName != '') {
                  Provider.of<TagsListProvider>(context, listen: false).addTag(
                    Tag(name: tagName, colorIndex: selectColorIndex),
                  );
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
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
