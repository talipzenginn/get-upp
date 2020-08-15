import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/constants.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final int importanceValue;
  final Function checkboxCallback;
  final int year;
  final int month;
  final int day;
  TaskTile({
    this.isChecked,
    this.taskTitle,
    this.checkboxCallback, this.importanceValue, this.year, this.month, this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          secondary: Icon(FontAwesomeIcons.circle,color: importanceValue == 1?kLessButtonActiveColor:importanceValue==2?kMiddleButtonActiveColor:importanceValue==3?kMoreButtonActiveColor:Colors.white,),
          title: Text(
            taskTitle,
            style: TextStyle(
                decoration: isChecked == true ? TextDecoration.lineThrough : null),
          ),
          value: isChecked,
          onChanged: checkboxCallback,
          controlAffinity: ListTileControlAffinity.platform,
          activeColor: kCheckboxColor,
          checkColor: Colors.white,
        ),
        Row(
          children: [
            SizedBox(width: 65.0,),
            Visibility(visible:year == 0?false:true,child: Text('$day.$month.$year',style: TextStyle(fontSize: 12.0,color: Colors.blueGrey),)),
          ],
        ),
      ],
    );
  }
}
