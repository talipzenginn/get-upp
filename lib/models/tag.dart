class Tag {
  String name;
  int colorIndex;
  String id;

  Tag({this.name, this.colorIndex, this.id});

  Map toJson() => {'name': name, 'color': colorIndex, 'id': id};

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(name: json['name'], colorIndex: json['color'], id: json['id']);
  }
}
