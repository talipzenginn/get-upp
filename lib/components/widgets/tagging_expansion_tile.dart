import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Provider;
import '../../screens/add_tag_screen.dart';
import '../../providers/tags_list_provider.dart';
import '../constants.dart';
import './add_edit_screens_text.dart';

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
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: kInactiveColor,
                      border: Border.all(
                        width: 1.4,
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
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 8, right: 8),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) =>
                                    SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: AddTagScreen(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kAppBarColor, width: 1.4),
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Add New Tag',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 400,
                          height: tagsListProviderTrue.tagsCount <= 1
                              ? 60
                              : tagsListProviderTrue.tagsCount <= 2
                                  ? 120
                                  : tagsListProviderTrue.tagsCount <= 3
                                      ? 170
                                      : 220,
                          child: ListView.builder(
                            itemCount: tagsListProviderTrue.tagsCount,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.tag,
                                  size: 23,
                                  color: AddTagScreen.colors[
                                      tagsListProviderTrue
                                          .tags[index].colorIndex],
                                ),
                                title:
                                    Text(tagsListProviderTrue.tags[index].name),
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
      ],
    );
  }
}
