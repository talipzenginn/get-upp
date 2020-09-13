import '../models/tag.dart';

class TagsListConvertJson {
  final List<Tag> tagsList;
  TagsListConvertJson({
    this.tagsList,
  });
  factory TagsListConvertJson.fromJson(List<dynamic> parsedJson) {
    List<Tag> tagList = List<Tag>();
    tagList = parsedJson.map((i) => Tag.fromJson(i)).toList();
    return TagsListConvertJson(tagsList: tagList);
  }
}
