import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import 'package:flutter/cupertino.dart' show ChangeNotifier;
import '../helpers/tags_list_convert_json.dart';
import '../models/tag.dart';

class TagsListProvider extends ChangeNotifier {
  TagsListProvider() {
    getLocalData();
  }
  SharedPreferences preferences;
  List<Tag> tags = [];

  int get tagsCount {
    return tags.length;
  }

  void getLocalData() async {
    preferences = await SharedPreferences.getInstance();
    String jsonText = preferences.getString('tagsList');
    if (jsonText != null) {
      final jsonResponse = json.decode(jsonText);
      TagsListConvertJson tagJson = TagsListConvertJson.fromJson(jsonResponse);
      tags = tagJson.tagsList;
      notifyListeners();
    }
  }

  void setList() {
    preferences.setString('tagsList', jsonEncode(tags));
    notifyListeners();
  }

  void addTag(Tag newTag) {
    tags.insert(0, newTag);
    setList();
  }

  void deleteTag(Tag currentTag) {
    tags.remove(currentTag);
    setList();
  }

  void notifyListeners() {}
}
