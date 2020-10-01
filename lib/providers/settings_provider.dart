import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import '../models/settings.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    getLocalData();
  }
  SharedPreferences _preferences;
  Settings settings = Settings(hideCompletedTasks: null);

  void setLocalData() {
    _preferences.setString('settings', jsonEncode(settings));
    notifyListeners();
  }

  void getLocalData() async {
    _preferences = await SharedPreferences.getInstance();
    String jsonText = _preferences.getString('settings');
    if (jsonText != null) {
      final jsonResponse = jsonDecode(jsonText);
      Settings newSettings = Settings.fromJson(jsonResponse);
      settings = newSettings;
      notifyListeners();
    }
  }

  void updateHideCompletedProperty(bool val) {
    settings.toggleHideCompletedProperty(val);
    setLocalData();
    notifyListeners();
  }
}
