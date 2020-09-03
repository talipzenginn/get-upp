import 'package:flutter/cupertino.dart';
import '../components/constants.dart';

class ActiveColorProvider extends ChangeNotifier {
  Color lessButtonColor = kInactiveColor;
  Color middleButtonColor = kInactiveColor;
  Color moreButtonColor = kInactiveColor;

  void inactivateColors() {
    lessButtonColor = kInactiveColor;
    middleButtonColor = kInactiveColor;
    moreButtonColor = kInactiveColor;
    notifyListeners();
  }

  void changeLessButtonColor() {
    lessButtonColor = lessButtonColor == kLessButtonActiveColor
        ? kInactiveColor
        : kLessButtonActiveColor;
    middleButtonColor = kInactiveColor;
    moreButtonColor = kInactiveColor;
    notifyListeners();
  }

  void changeMiddleButtonColor() {
    middleButtonColor = middleButtonColor == kMiddleButtonActiveColor
        ? kInactiveColor
        : kMiddleButtonActiveColor;
    lessButtonColor = kInactiveColor;
    moreButtonColor = kInactiveColor;
    notifyListeners();
  }

  void changeMoreButtonColor() {
    moreButtonColor = moreButtonColor == kMoreButtonActiveColor
        ? kInactiveColor
        : kMoreButtonActiveColor;
    lessButtonColor = kInactiveColor;
    middleButtonColor = kInactiveColor;
    notifyListeners();
  }
}
