import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoDatabaseHelper {
  static final TodoDatabaseHelper _instance = TodoDatabaseHelper._internal();
  static Database? _database;

  TodoDatabaseHelper._internal();

  factory TodoDatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      version: 2, // Increment version number for schema change
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        value TEXT,
        description TEXT,
        isDeleting INTEGER,
        isFavourite INTEGER
      )
      '''
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          '''
        ALTER TABLE tasks ADD COLUMN description TEXT
        '''
      );
    }
  }

  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    Database db = await database;
    return await db.query('tasks');
  }

  Future<Map<String, dynamic>?> queryTask(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> insertTask(Map<String, dynamic> task) async {
    Database db = await database;
    await db.insert('tasks', task, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTask(Map<String, dynamic> task) async {
    Database db = await database;
    await db.update(
      'tasks',
      task,
      where: 'id = ?',
      whereArgs: [task['id']],
    );
  }

  Future<void> deleteTask(String id) async {
    Database db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
