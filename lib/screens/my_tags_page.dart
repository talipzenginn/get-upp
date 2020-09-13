import 'package:flutter/material.dart';
import '../components/widgets/add_tag_button.dart';
import '../components/widgets/tag_display_list.dart';
import '../components/constants.dart';

class MyTagsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 15.0,
            right: 15.0,
            left: 27.0,
            bottom: 13.4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'My Tags',
                style: TextStyle(
                  fontFamily: 'Gotham',
                  color: kTitleColor,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: AddTagButton(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: TagDisplayList(),
            decoration: BoxDecoration(
              color: kTaskListColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
