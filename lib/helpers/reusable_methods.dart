import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../screens/edit_tag_screen.dart';
import '../models/task.dart';
import '../providers/active_color_provider.dart';
import '../screens/edit_task_screen.dart';

class ReusableMethods {
  void openEditTaskScreen(BuildContext context, Task task, int index) {
    FocusScope.of(context).unfocus();
    bool lessActiveness = false;
    bool middleActiveness = false;
    bool moreActiveness = false;
    Provider.of<ActiveColorProvider>(context, listen: false).inactivateColors();
    if (task.importanceValue == 1) {
      Provider.of<ActiveColorProvider>(context, listen: false)
          .changeLessButtonColor();
    } else if (task.importanceValue == 2) {
      Provider.of<ActiveColorProvider>(context, listen: false)
          .changeMiddleButtonColor();
    } else if (task.importanceValue == 3) {
      Provider.of<ActiveColorProvider>(context, listen: false)
          .changeMoreButtonColor();
    }
    if (task.importanceValue == 1) {
      lessActiveness = true;
    } else if (task.importanceValue == 2) {
      middleActiveness = true;
    } else if (task.importanceValue == 3) {
      moreActiveness = true;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditTaskScreen(
          lessActiveness: lessActiveness,
          middleActiveness: middleActiveness,
          moreActiveness: moreActiveness,
          index: index,
          day: task.day,
          month: task.month,
          year: task.year,
          title: task.name,
        ),
      ),
    );
  }

  void openEditTagScreen(
      {BuildContext context, int index, int colorIndex, String title}) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditTagScreen(
          index: index,
          colorIndex: colorIndex,
          title: title,
        ),
      ),
    );
  }
}
