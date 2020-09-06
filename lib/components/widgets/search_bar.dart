import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Provider;
import '../../components/constants.dart';
import '../../providers/search_bar_text_field_provider.dart';
import '../../providers/tasks_list_provider.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Provider.of<TasksListProvider>(context).taskCount != null
          ? Provider.of<TasksListProvider>(context).taskCount == 0 ||
                  Provider.of<TasksListProvider>(context).leftTaskCount == 0
              ? false
              : true
          : false,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: [
            Visibility(
                visible:
                    Provider.of<SearchBarTextFieldProvider>(context).showCursor,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: kInactiveColor,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Provider.of<SearchBarTextFieldProvider>(context,
                                listen: false)
                            .removeQuery();
                        Provider.of<SearchBarTextFieldProvider>(context,
                                listen: false)
                            .controllerClear();
                        FocusScope.of(context).unfocus();
                      }),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 4.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: kSearchBarBackground,
                      border: Border.all(color: kInactiveColor),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: TextField(
                    controller: Provider.of<SearchBarTextFieldProvider>(context)
                        .controller,
                    showCursor: Provider.of<SearchBarTextFieldProvider>(context)
                        .showCursor,
                    cursorColor: kInactiveColor,
                    cursorRadius: Radius.circular(30.0),
                    onChanged: (value) {
                      Provider.of<SearchBarTextFieldProvider>(context,
                              listen: false)
                          .setQuery(value);
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(
                      color: kInactiveColor,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                          color: kSearchBarHintText,
                          fontFamily: 'GothamBook',
                          fontSize: 16.0),
                      hintText: 'Search task',
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 15.0, right: 5.0),
                        child: Icon(
                          FontAwesomeIcons.search,
                          color: kInactiveColor,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
