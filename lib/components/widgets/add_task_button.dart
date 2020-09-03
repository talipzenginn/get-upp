import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../../components/constants.dart';
import '../../providers/active_color_provider.dart';
import '../../screens/add_task_screen.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Material(
        color: kInactiveColor,
        borderRadius: BorderRadius.circular(25.0),
        child: MaterialButton(
          onPressed: () {
            Provider.of<ActiveColorProvider>(context, listen: false)
                .inactivateColors();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            );
          },
          minWidth: 138.0,
          height: 42.0,
          child: Text(
            '+ Add Task',
            style: TextStyle(color: kReusableButtonBody),
          ),
        ),
      ),
    );
  }
}
