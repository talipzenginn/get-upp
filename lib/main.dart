import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import './providers/tags_list_provider.dart';
import './providers/settings_provider.dart';
import './components/constants.dart';
import './providers/active_color_provider.dart';
import './providers/navigation_bar_on_tapped.dart';
import './providers/search_bar_text_field_provider.dart';
import './providers/tasks_list_provider.dart';
import './screens/main_scaffold.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';

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
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProvider<TagsListProvider>(
          create: (context) => TagsListProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light()
            .copyWith(accentColor: kAccentColor, primaryColor: kPrimaryColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: SplashScreen(),
                ),
              );
            }
            if (userSnapshot.hasData) {
              return MainScaffold();
            }
            return AuthScreen();
          },
        ),
      ),
    );
  }
}
