import 'package:flutter/material.dart';
import '../components/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Text(
          'Loading...',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
