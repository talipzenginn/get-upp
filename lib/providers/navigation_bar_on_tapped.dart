import 'package:flutter/foundation.dart';

class NavigationBarOnTapped extends ChangeNotifier {
  int _selectedIndex = 0;
  bool isVisible = true;
  void onItemTapped(int index) {
    _selectedIndex = index;
    isVisible = _selectedIndex == 0 ? true : false;
    notifyListeners();
  }

  int get selectedIndex {
    return _selectedIndex;
  }
}
