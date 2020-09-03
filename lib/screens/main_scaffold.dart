import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import '../screens/settings_page.dart';
import 'package:provider/provider.dart' show Provider;
import '../screens/my_families_page.dart';
import '../screens/my_tags_page.dart';
import '../screens/my_tasks_page.dart';
import '../components/constants.dart';
import '../providers/navigation_bar_on_tapped.dart';

class MainScaffold extends StatelessWidget {
  final List<Widget> _widgetOptions = <Widget>[
    MyTasksPage(),
    MyTagsPage(),
    MyFamiliesPage(),
    SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 13.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.list),
            title: Text(
              'Tasks',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.tags),
            title: Text(
              'Tags',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.users),
            title: Text(
              'Families',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cogs),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        ],
        currentIndex: Provider.of<NavigationBarOnTapped>(context).selectedIndex,
        backgroundColor: kNavigationBarBackgroundColor,
        selectedItemColor: kNavigationBarColor,
        unselectedItemColor: kUnselectedItemColor,
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
