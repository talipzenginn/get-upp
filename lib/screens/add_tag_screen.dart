import 'package:flutter/material.dart';
import '../components/widgets/add_edit_screens_text.dart';
import '../helpers/reusable_methods.dart';
import '../components/widgets/pick_color_button.dart';
import '../components/constants.dart';

class AddTagScreen extends StatefulWidget {
  static final List<Color> colors = [
    kTagColor0,
    kTagColor1,
    kTagColor2,
    kTagColor3,
    kTagColor4,
    kTagColor5,
  ];
  @override
  _AddTagScreenState createState() => _AddTagScreenState();
}

class _AddTagScreenState extends State<AddTagScreen> {
  String tagName;
  Color selectedColor = kTagColor5;
  int selectColorIndex = 5;
  List<Color> colors;
  @override
  void initState() {
    super.initState();
    colors = AddTagScreen.colors;
  }

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
                    child: AddEditScreensText(text: 'Add Tag', textSize: 30.0)),
                Theme(
                  data: ThemeData.light().copyWith(primaryColor: kAppBarColor),
                  child: TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Tag Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      errorText: errorTextVisible == true
                          ? 'You should type title'
                          : null,
                      hintText: 'Type your title',
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
                    ReusableMethods.addTag(
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
                  color: kBackgroundColor,
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
