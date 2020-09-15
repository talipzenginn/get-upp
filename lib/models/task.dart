class Task {
  String name;
  bool isDone;
  int importanceValue;
  int year;
  int month;
  int day;
  String tagListJson;
  Task(
      {this.name,
      this.isDone = false,
      this.importanceValue,
      this.year = 0,
      this.month = 0,
      this.day = 0,
      this.tagListJson});

  void toggleDone() {
    print(importanceValue);
    isDone = !isDone;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        name: json['name'],
        isDone: json['isDone'],
        importanceValue: json['importanceValue'],
        year: json['year'],
        month: json['month'],
        day: json['day'],
        tagListJson: json['tagListJson']);
  }
  Map toJson() => {
        'name': name,
        'isDone': isDone,
        'importanceValue': importanceValue,
        'year': year,
        'month': month,
        'day': day,
        'tagListJson': tagListJson
      };
}
