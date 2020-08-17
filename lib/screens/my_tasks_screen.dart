import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_upp/components/widgets/percent_indicator_of_my_tasks.dart';
import 'package:get_upp/components/widgets/search_bar.dart';
import 'package:get_upp/components/widgets/task_count_text.dart';
import 'package:get_upp/components/widgets/task_display_list.dart';
import '../components/constants.dart';
import 'package:get_upp/providers/navigation_bar_on_tapped.dart';
import '../components/widgets/add_task_button.dart';
import 'package:provider/provider.dart';

class MyTasksScreen extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, color: kTitleColor);
  List<Widget> _widgetOptions = <Widget>[
    Column(
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
                padding: const EdgeInsets.only(bottom:3.0,top: 5.0),
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
    ),
    Center(
      child: Text(
        'Tags',
        style: optionStyle,
      ),
    ),
    Center(
      child: Text(
        'Families',
        style: optionStyle,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidListAlt),
            title: Text(
              'Tasks',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.tags),
            title: Text(
              'Tags',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.users),
            title: Text(
              'Families',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ],
        currentIndex: Provider.of<NavigationBarOnTapped>(context).selectedIndex,
        backgroundColor: kNavigationBarBackgroundColor,
        selectedItemColor: kNavigationBarColor,
        unselectedItemColor: Colors.grey,
        onTap: Provider.of<NavigationBarOnTapped>(context).onItemTapped,
      ),
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Center(
          child: Text(
            'GetUpp',
            style: TextStyle(color: kAppBarTextColor),
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: _widgetOptions
          .elementAt(Provider.of<NavigationBarOnTapped>(context).selectedIndex),
    );
  }
}