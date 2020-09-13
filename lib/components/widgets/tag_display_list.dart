import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:provider/provider.dart' show Provider;
import '../../providers/tags_list_provider.dart';
import '../../screens/add_tag_screen.dart';

class TagDisplayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Provider.of<TagsListProvider>(context).tagsCount,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            FontAwesomeIcons.tag,
            color: AddTagScreen().colors[
                Provider.of<TagsListProvider>(context).tags[index].colorIndex],
          ),
          title: Text(Provider.of<TagsListProvider>(context).tags[index].name),
        );
      },
    );
  }
}
