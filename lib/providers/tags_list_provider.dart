import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import 'package:flutter/cupertino.dart' show ChangeNotifier;
import '../helpers/tags_list_convert_json.dart';
import '../models/tag.dart';
import '../models/task.dart';
import '../helpers/selected_tag_list_convert_json.dart';
import '../providers/tasks_list_provider.dart';

class TagsListProvider extends ChangeNotifier {
  TagsListProvider() {
    getLocalData();
  }
  SharedPreferences preferences;
  List<Tag> tags = [];
  List<Tag> selectedTagList = [];
  List<bool> tagsChecked = [];
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
      tagsChecked.clear();
      for (int i = 0; i < tags.length; i++) {
        tagsChecked.add(false);
      }
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

  void deleteTag(Tag currentTag, BuildContext context) {
    Provider.of<TasksListProvider>(context, listen: false)
        .setTaskByTagDeletions(tagId: currentTag.id);
    tags.remove(currentTag);
    setList();
  }

  void updateTagTitle(int index, String newTitle, BuildContext context) {
    Provider.of<TasksListProvider>(context, listen: false)
        .setTaskByTagNameChanges(tagId: tags[index].id, newTagName: newTitle);
    tags[index].name = newTitle;
    setList();
  }

  void updateTagColor(int index, int newColorIndex, BuildContext context) {
    Provider.of<TasksListProvider>(context, listen: false)
        .setTaskByTagColorChanges(
            tagId: tags[index].id, newTagColorIndex: newColorIndex);
    tags[index].colorIndex = newColorIndex;
    setList();
  }

  void updateSelection(int index, bool value) {
    tagsChecked[index] = value;
    notifyListeners();
  }

  void clearSelection() {
    tagsChecked.clear();
    for (int i = 0; i < tags.length; i++) {
      tagsChecked.add(false);
    }
    notifyListeners();
  }

  void tagging() {
    selectedTagList.clear();
    for (int i = 0; i < tagsChecked.length; i++) {
      if (tagsChecked[i]) {
        selectedTagList.insert(0, tags[i]);
      }
    }
    notifyListeners();
  }

  void setSelection(Task task) {
    clearSelection();
    for (int i = 0;
        i <
            SelectedTagListConvertJson.fromJson(jsonDecode(task.tagListJson))
                .selectedTagsList
                .length;
        i++) {
      for (int j = 0; j < tags.length; j++) {
        if (tags[j].name ==
            SelectedTagListConvertJson.fromJson(jsonDecode(task.tagListJson))
                .selectedTagsList[i]
                .name) {
          tagsChecked[j] = true;
        }
      }
    }
    notifyListeners();
  }
}
