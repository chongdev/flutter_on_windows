const String tableTodo = 'todos';

class TodoFields {
  static String get id => '_id';
  static String get title => 'title';
  static String get time => 'time';

  static final List<String> values = [
    /// Add all fields
    id, title, time
  ];
}

class Todo {
  final int? id;
  final String title;
  final DateTime createdTime;

  const Todo({
    this.id,
    required this.title,
    required this.createdTime,
  });


  static Todo fromJson(Map<String, Object?> json) => Todo(
    id: json[TodoFields.id] as int?,
    title: json[TodoFields.title] as String,
    createdTime: DateTime.parse(json[TodoFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    TodoFields.id: id,
    TodoFields.title: title,
    TodoFields.time: createdTime.toIso8601String(),
  };

  Todo copy({
    int? id,
    String? title,
    DateTime? createdTime,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        createdTime: createdTime ?? this.createdTime,
      );

}