import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart' show FlutterSwitch;
import 'package:provider/provider.dart' show Provider;
import '../providers/settings_provider.dart';
import '../components/constants.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 25.0,
            right: 15.0,
            left: 27.0,
            bottom: 13.4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                'My Tasks Page Settings',
                style: TextStyle(
                  fontFamily: 'GothamLight',
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Hide completed tasks',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  FlutterSwitch(
                    width: 93.0,
                    height: 40.0,
                    valueFontSize: 16.0,
                    toggleSize: 45.0,
                    value: Provider.of<SettingsProvider>(context)
                                .settings
                                .hideCompletedTasks ==
                            null
                        ? false
                        : Provider.of<SettingsProvider>(context)
                            .settings
                            .hideCompletedTasks,
                    borderRadius: 30.0,
                    padding: 8.0,
                    showOnOff: true,
                    inactiveColor: Colors.grey,
                    activeColor: kAppBarColor,
                    onToggle: (val) {
                      Provider.of<SettingsProvider>(context, listen: false)
                          .updateHideCompletedProperty(val);
                    },
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
