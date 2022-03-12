const String tableNotes = 'notes';

class NoteFields {
  static String get id => '_id';
  static String get isImportant => 'isImportant';
  static String get title => 'title';
  static String get description => 'description';
  static String get number => 'number';
  static String get time => 'time';

  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, time
  ];
}

class Note {
  final int? id;
  final bool isImportant;
  final String title;
  final String description;
  final int number;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.title,
    required this.description,
    required this.number,
    required this.createdTime,
  });

  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    isImportant: json[NoteFields.isImportant] == 1,
    number: json[NoteFields.number] as int,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    createdTime: DateTime.parse(json[NoteFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.title: title,
    NoteFields.isImportant: isImportant ? 1 : 0,
    NoteFields.number: number,
    NoteFields.description: description,
    NoteFields.time: createdTime.toIso8601String(),
  };

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );
}
