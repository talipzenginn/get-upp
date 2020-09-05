class Settings {
  bool hideCompletedTasks;
  Settings({this.hideCompletedTasks = false});
  void toggleHideCompletedProperty(bool val) {
    hideCompletedTasks = val;
  }

  factory Settings.fromJson(Map<String, dynamic> parsedJson) {
    return Settings(
      hideCompletedTasks: parsedJson['hideCompletedTasks'],
    );
  }
  Map toJson() => {'hideCompletedTasks': hideCompletedTasks};
}
