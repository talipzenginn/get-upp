import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../screens/settings_page.dart';
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text(
              'Tasks',
              style: TextStyle(fontFamily: 'GothamLight', fontSize: 12.5),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            title: Text(
              'Tags',
              style: TextStyle(fontFamily: 'GothamLight', fontSize: 12.5),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text(
              'Families',
              style: TextStyle(fontFamily: 'GothamLight', fontSize: 12.5),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            title: Text(
              'Settings',
              style: TextStyle(fontFamily: 'GothamLight', fontSize: 12.5),
            ),
          ),
        ],
        currentIndex: Provider.of<NavigationBarOnTapped>(context).selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kNavigationBarBackgroundColor,
        selectedItemColor: kNavigationBarColor,
        unselectedItemColor: kUnselectedItemColor,
        onTap: Provider.of<NavigationBarOnTapped>(context).onItemTapped,
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
        backgroundColor: kAppBarColor,
        title: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Get',
                  style: TextStyle(
                    fontFamily: 'GothamLight',
                    color: Colors.white,
                    fontSize: 29,
                  ),
                ),
                TextSpan(
                  text: 'Upp',
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    color: Colors.white,
                    fontSize: 29,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor:
          Provider.of<NavigationBarOnTapped>(context).selectedIndex == 3
              ? kInactiveColor
              : kBackgroundColor,
      body: _widgetOptions
          .elementAt(Provider.of<NavigationBarOnTapped>(context).selectedIndex),
    );
  }
}
