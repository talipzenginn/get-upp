import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../../providers/tags_list_provider.dart';
import '../constants.dart';
import 'add_edit_screens_text.dart';

class TaggingExpansionTile extends StatelessWidget {
  final String title;
  TaggingExpansionTile({this.title});
  @override
  Widget build(BuildContext context) {
    TagsListProvider tagsListProviderFalse =
        Provider.of<TagsListProvider>(context, listen: false);
    TagsListProvider tagsListProviderTrue =
        Provider.of<TagsListProvider>(context);
    return Column(
      children: [
        Visibility(
          visible: tagsListProviderTrue.tagsCount == 0 ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0, left: 8.0, right: 8.0),
            child: AddEditScreensText(
              text: title,
              textSize: 18.0,
            ),
          ),
        ),
        Visibility(
          visible: tagsListProviderTrue.tagsCount == 0 ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kInactiveColor,
                        border: Border.all(
                          color: kReusableButtonBody,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ExpansionTile(
                        title: Text(
                          'Pick Your Tags',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0),
                        ),
                        onExpansionChanged: (v) {
                          FocusScope.of(context).unfocus();
                        },
                        children: [
                          Container(
                            width: 400,
                            height: tagsListProviderTrue.tagsCount <= 1
                                ? 60
                                : tagsListProviderTrue.tagsCount <= 2
                                    ? 120
                                    : tagsListProviderTrue.tagsCount <= 3
                                        ? 180
                                        : 220,
                            child: ListView.builder(
                              itemCount: tagsListProviderTrue.tagsCount,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                      tagsListProviderTrue.tags[index].name),
                                  trailing: Checkbox(
                                    activeColor: kAppBarColor,
                                    value:
                                        tagsListProviderTrue.tagsChecked[index],
                                    onChanged: (value) {
                                      tagsListProviderFalse.updateSelection(
                                          index, value);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
