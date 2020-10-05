import 'package:flutter/foundation.dart';

class NavigationBarOnTapped extends ChangeNotifier {
  int _selectedIndex = 0;
  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int get selectedIndex {
    return _selectedIndex;
  }
}
