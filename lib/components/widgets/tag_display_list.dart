import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Consumer, Provider;
import '../../helpers/reusable_methods.dart';
import '../../providers/tags_list_provider.dart';
import '../../screens/add_tag_screen.dart';
import '../constants.dart';

class TagDisplayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TagsListProvider>(builder: (context, tagData, child) {
      return ListView.builder(
        itemCount: tagData.tagsCount,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 12.0, right: 12.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: kInactiveColor),
              child: ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.tag,
                      color:
                          AddTagScreen().colors[tagData.tags[index].colorIndex],
                    ),
                    title: Text(
                      tagData.tags[index].name,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'GothamBook',
                      ),
                    ),
                  ),
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.edit,
                              color: kEditButtonColor,
                              size: 22.0,
                            ),
                            onPressed: () {
                              ReusableMethods().openEditTagScreen(
                                  context: context,
                                  index: index,
                                  colorIndex: tagData.tags[index].colorIndex,
                                  title: tagData.tags[index].name);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.trashAlt,
                              color: kDeleteButtonColor,
                              size: 22.0,
                            ),
                            onPressed: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) => AlertDialog(
                                  elevation: 24.0,
                                  title: Text(
                                    'Sure?',
                                  ),
                                  content: Text(
                                    'Are you sure about deleting this tag?',
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Provider.of<TagsListProvider>(context,
                                                listen: false)
                                            .deleteTag(tagData.tags[index]);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: kConfirmColor),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'No',
                                        style:
                                            TextStyle(color: kNotConfirmColor),
                                      ),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
