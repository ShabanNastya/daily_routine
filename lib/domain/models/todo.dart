final String tableNote = 'notes';

///для бд
class NoteFields {
  static final values = [id, title, description];
  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
}

class Todo {
  final int? id;
  final String title;
  final String description;

  Todo({this.id, required this.title, required this.description});

  static Todo fromJson(Map<String, Object?> json) => Todo(
        id: json[NoteFields.id] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description
      };

  Todo copy({int? id, String? title, String? description}) => Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
      );
}
