import '../models/tag.dart';

class SelectedTagListConvertJson {
  final List<Tag> selectedTagsList;
  SelectedTagListConvertJson({
    this.selectedTagsList,
  });
  factory SelectedTagListConvertJson.fromJson(List<dynamic> parsedJson) {
    List<Tag> selectedTagList = List<Tag>();
    selectedTagList = parsedJson.map((i) => Tag.fromJson(i)).toList();
    return SelectedTagListConvertJson(selectedTagsList: selectedTagList);
  }
}
