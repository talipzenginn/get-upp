import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../providers/tags_list_provider.dart';
import '../components/widgets/reusable_button.dart';
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
                          isIcon: selectedColor == Colors.greenAccent
                              ? true
                              : false,
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
                  if ((tagName != null && tagName != '')) {
                    Provider.of<TagsListProvider>(context, listen: false)
                        .updateTagTitle(widget.index, tagName);
                    Provider.of<TagsListProvider>(context, listen: false)
                        .updateTagColor(widget.index, selectColorIndex);
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  } else {
                    Provider.of<TagsListProvider>(context, listen: false)
                        .updateTagColor(widget.index, selectColorIndex);
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  }
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
