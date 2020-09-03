import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../components/widgets/add_task_button.dart';
import '../components/widgets/percent_indicator_of_my_tasks.dart';
import '../components/widgets/search_bar.dart';
import '../components/widgets/task_count_text.dart';
import '../components/widgets/task_display_list.dart';

class MyTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 45.0,
            right: 15.0,
            left: 27.0,
            bottom: 13.4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text(
                'My Tasks',
                style: TextStyle(
                  color: kTitleColor,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.0, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        TaskCountText(),
                        SizedBox(
                          width: 12.0,
                        ),
                        PercentIndicatorOfMyTasks()
                      ],
                    ),
                    AddTaskButton(),
                  ],
                ),
              ),
              SearchBar(),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: TaskDisplayList(),
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
