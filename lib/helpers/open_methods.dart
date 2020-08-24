import 'package:flutter/material.dart';
import 'package:get_upp/models/task.dart';
import 'package:get_upp/providers/active_color_provider.dart';
import 'package:get_upp/screens/edit_task_screen.dart';
import 'package:provider/provider.dart';

class OpenMethods{
  void openEditTaskScreen(BuildContext context, Task task, int index){
    bool lessActiveness = false;
    bool middleActiveness = false;
    bool moreActiveness = false;
    Provider.of<ActiveColorProvider>(context, listen: false)
        .inactivateColors();
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
}