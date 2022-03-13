import 'package:flutter_on_windows/models/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;
  var databaseFactory = databaseFactoryFfi;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePage) async {
    // Init ffi loader if needed.
    sqfliteFfiInit();

    final dbPath = await databaseFactory.getDatabasesPath();
    final path = join(dbPath, filePage);

    Database db = await databaseFactory.openDatabase(path);

    // check init table
    try {
      await db.rawQuery('SELECT * FROM $tableTodo LIMIT 1');
    } on Exception catch (_) {
      await _createDB(db, 1);
    }

    return db;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableTodo ( 
  ${TodoFields.id} $idType,
  ${TodoFields.title} $textType,
  ${TodoFields.time} $textType
  )
''');
  }

  Future<Todo> create(Todo todo) async {
    final db = await instance.database;

    final id = await db.insert(tableTodo, todo.toJson());
    return todo.copy(id: id);
  }

  Future<Todo> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTodo,
      columns: TodoFields.values,
      where: '${TodoFields.id} = ?',
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
    final orderBy = '${TodoFields.time} ASC';
    final result = await db.query(tableTodo, orderBy: orderBy);

    return result.map((json) => Todo.fromJson(json)).toList();
  }

  Future<int> update(Todo todo) async {
    final db = await instance.database;

    return db.update(
      tableTodo,
      todo.toJson(),
      where: '${TodoFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableTodo,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}