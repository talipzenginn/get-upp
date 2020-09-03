import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider;
import 'providers/active_color_provider.dart';
import 'providers/navigation_bar_on_tapped.dart';
import 'providers/search_bar_text_field_provider.dart';
import 'screens/main_scaffold.dart';
import 'providers/tasks_list_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchBarTextFieldProvider>(
          create: (context) => SearchBarTextFieldProvider(),
        ),
        ChangeNotifierProvider<NavigationBarOnTapped>(
          create: (context) => NavigationBarOnTapped(),
        ),
        ChangeNotifierProvider<ActiveColorProvider>(
          create: (context) => ActiveColorProvider(),
        ),
        ChangeNotifierProvider<TasksListProvider>(
          create: (context) => TasksListProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.light()
            .copyWith(accentColor: Colors.black, primaryColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: MainScaffold(),
      ),
    );
  }
}
