import 'package:flutter/material.dart';
import 'package:get_upp/components/constants.dart';
import 'package:get_upp/components/widgets/reusable_button.dart';

class AddTagScreen extends StatefulWidget {
  @override
  _AddTagScreenState createState() => _AddTagScreenState();
}

class _AddTagScreenState extends State<AddTagScreen> {
  String tagName;

  bool orangeIsPicked = false;
  bool redIsPicked = false;
  bool yellowIsPicked = false;
  bool greenIsPicked = false;
  bool pinkIsPicked = false;
  bool blueIsPicked = true;

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
                    'Add Tag',
                    style:
                        TextStyle(color: kAddTaskScreenTitle, fontSize: 30.0),
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
                            onTapfunction: () {},
                            borderColor: Colors.black,
                            text: '',
                            textSize: 0,
                            bodyColor: Colors.orange,
                            isIcon: orangeIsPicked,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          ReusableButton(
                            onTapfunction: () {},
                            isIcon: redIsPicked,
                            borderColor: Colors.black,
                            text: '',
                            textSize: 0,
                            bodyColor: Colors.red,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          ReusableButton(
                            onTapfunction: () {},
                            isIcon: yellowIsPicked,
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
                            onTapfunction: () {},
                            isIcon: greenIsPicked,
                            borderColor: Colors.black,
                            text: '',
                            textSize: 0,
                            bodyColor: Colors.greenAccent,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          ReusableButton(
                            onTapfunction: () {},
                            isIcon: pinkIsPicked,
                            borderColor: Colors.black,
                            text: '',
                            textSize: 0,
                            bodyColor: Colors.pinkAccent,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          ReusableButton(
                            onTapfunction: () {},
                            isIcon: blueIsPicked,
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
                    if (tagName != null && tagName != '') {
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
