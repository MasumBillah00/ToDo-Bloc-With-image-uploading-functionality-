// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class LoginDatabaseHelper {
//   static final LoginDatabaseHelper instance = LoginDatabaseHelper._init();
//
//   static Database? _database;
//
//   LoginDatabaseHelper._init();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('app.db');
//     return _database!;
//   }
//
//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);
//
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }
//
//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//     CREATE TABLE users (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       email TEXT NOT NULL,
//       password TEXT NOT NULL
//     )
//     ''');
//   }
//
//   Future<void> insertUser(String email, String password) async {
//     final db = await instance.database;
//     await db.insert('users', {'email': email, 'password': password});
//   }
//
//   Future<Map<String, dynamic>?> getUser(String email, String password) async {
//     final db = await instance.database;
//     final result = await db.query(
//       'users',
//       where: 'email = ? AND password = ?',
//       whereArgs: [email, password],
//     );
//
//     if (result.isNotEmpty) {
//       return result.first;
//     } else {
//       return null;
//     }
//   }
// }
