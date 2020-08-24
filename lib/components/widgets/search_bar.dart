import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_upp/providers/search_bar_text_field_provider.dart';
import 'package:get_upp/providers/tasks_list_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Provider.of<TasksListProvider>(context).taskCount != null
          ? Provider.of<TasksListProvider>(context).taskCount == 0
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
                        color: Colors.white,
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
                      color: Colors.lightBlueAccent,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: TextField(
                    controller: Provider.of<SearchBarTextFieldProvider>(context)
                        .controller,
                    showCursor: Provider.of<SearchBarTextFieldProvider>(context)
                        .showCursor,
                    cursorColor: Colors.white,
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
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white70),
                      hintText: 'Search task',
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 15.0),
                        child: Icon(
                          FontAwesomeIcons.search,
                          color: Colors.white,
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
