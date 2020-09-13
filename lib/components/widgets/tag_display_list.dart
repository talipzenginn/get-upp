import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Consumer, Provider;
import '../../providers/tags_list_provider.dart';
import '../../screens/add_tag_screen.dart';

class TagDisplayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TagsListProvider>(builder: (context, tagData, child) {
      return ListView.builder(
        itemCount: tagData.tagsCount,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onLongPress: () {
              Provider.of<TagsListProvider>(context, listen: false)
                  .deleteTag(tagData.tags[index]);
            },
            leading: Icon(
              FontAwesomeIcons.tag,
              color: AddTagScreen().colors[tagData.tags[index].colorIndex],
            ),
            title: Text(tagData.tags[index].name),
          );
        },
      );
    });
  }
}
