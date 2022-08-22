import 'package:daily_routine/domain/models/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  ///создать бд с полями и требованиями
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    ///column  --  type
    await db.execute('''
    CREATE TABLE $tableNote (
    ${NoteFields.id} $idType,
    ${NoteFields.title} $textType,
    ${NoteFields.description} $textType
    )
    ''');
  }

  Future<Todo> createNote(Todo todo) async {
    final db = await instance.database;
    // final json = todo.toJson();
    // final columns = '${NoteFields.title},${NoteFields.description}';
    // final values = '${json[NoteFields.title]}, ${NoteFields.description}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNote, todo.toJson());
    return todo.copy(id: id);
  }

  Future<Todo> readTodo(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNote,
      columns: NoteFields.values,
      //?, because id not secure prevents sql injection attack
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Todo>> readAllNotes() async {
    final db = await instance.database;
    ///final orderBy = '${NoteFields.title}';
    final result = await db.query(
      tableNote,
    );

    return result.map((json) => Todo.fromJson(json)).toList();
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;
    return db.update(
      tableNote,
      todo.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return db.delete(tableNote, where: '${NoteFields.id} ?', whereArgs: [id]);
  }

  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }
}
