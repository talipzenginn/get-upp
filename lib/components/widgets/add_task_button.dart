import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Provider;
import '../../components/constants.dart';
import '../../providers/active_color_provider.dart';
import '../../screens/add_task_screen.dart';
import '../../providers/tags_list_provider.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Material(
        elevation: 5,
        color: kInactiveColor,
        borderRadius: BorderRadius.circular(25.0),
        child: MaterialButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Provider.of<ActiveColorProvider>(context, listen: false)
                .inactivateColors();
            Provider.of<TagsListProvider>(context, listen: false)
                .clearSelection();
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
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.plus,
                size: 15,
                color: kAppBarColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  ' Add Task',
                  style: TextStyle(
                      color: kAppBarColor,
                      fontFamily: 'GothamBook',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
