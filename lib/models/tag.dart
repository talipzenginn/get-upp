class Tag {
  String name;
  int colorIndex;

  Tag({this.name, this.colorIndex});

  Map toJson() => {'name': name, 'color': colorIndex};

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      colorIndex: json['color'],
    );
  }
}
