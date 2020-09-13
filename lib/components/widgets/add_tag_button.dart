import 'package:flutter/material.dart';
import '../../screens/add_tag_screen.dart';
import 'package:provider/provider.dart' show Provider;
import '../../components/constants.dart';
import '../../providers/active_color_provider.dart';

class AddTagButton extends StatelessWidget {
  const AddTagButton({
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
            FocusScope.of(context).unfocus();
            Provider.of<ActiveColorProvider>(context, listen: false)
                .inactivateColors();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTagScreen(),
              ),
            );
          },
          minWidth: 138.0,
          height: 42.0,
          child: Text(
            '+ Add Tag',
            style: TextStyle(
                color: Color(0xFF048998),
                fontFamily: 'GothamBook',
                fontSize: 14.5),
          ),
        ),
      ),
    );
  }
}
