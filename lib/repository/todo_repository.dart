import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/todo_task_model.dart';

class ToDoAppRepository {
  static final ToDoAppRepository _instance = ToDoAppRepository._internal();
  factory ToDoAppRepository() => _instance;
  static Database? _database;

  ToDoAppRepository._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'todo_app.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id TEXT PRIMARY KEY, value TEXT, isDeleting INTEGER, isFavourite INTEGER, isDone INTEGER)',
        );
      },
    );
  }

  Future<void> addItem(TodoTaskModel item) async {
    final db = await database;
    await db.insert('tasks', item.toMap());
  }

  Future<List<TodoTaskModel>> fetchItems({bool includeDeleted = false}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: includeDeleted ? null : 'isDeleting = 0',
    );
    return List.generate(maps.length, (i) {
      return TodoTaskModel.fromMap(maps[i]);
    });
  }

  Future<void> updateItem(TodoTaskModel item) async {
    final db = await database;
    await db.update(
      'tasks',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> hideItem(String id) async {
    final db = await database;
    await db.update(
      'tasks',
      {'isDeleting': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteItemPermanently(String id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> restoreItem(String id) async {
    final db = await database;
    await db.update(
      'tasks',
      {'isDeleting': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}