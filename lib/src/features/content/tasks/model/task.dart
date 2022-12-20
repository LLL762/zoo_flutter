class Task {
  String id;
  // name, description, type, status;
  int? priority;

  Task(this.id, this.priority);

  Task.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        priority = json['priority'];

  static List<Task> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray.map((e) => Task.fromJson(e)).toList();
  }
}
