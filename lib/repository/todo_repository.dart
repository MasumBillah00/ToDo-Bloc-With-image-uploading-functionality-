import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../database_helper/database_helper.dart';
import '../model/todo_task_model.dart';


class ToDoAppRepository {
  final TodoDatabaseHelper databaseHelper; // Instance of TodoDatabaseHelper

  ToDoAppRepository(this.databaseHelper); // Constructor to initialize the helper

  Future<void> addItem(TodoTaskModel item) async {
    await databaseHelper.insertTask({
      'id': item.id,
      'value': item.value,
      'description': item.description,
      'isDeleting': item.isDeleting ? 1 : 0,
      'isFavourite': item.isFavourite ? 1 : 0,
    });
  }

  Future<List<TodoTaskModel>> fetchItems({bool includeDeleted = false}) async {
    final List<Map<String, dynamic>> maps = await databaseHelper.queryAllTasks();
    return List.generate(maps.length, (i) {
      return TodoTaskModel(
        id: maps[i]['id'],
        value: maps[i]['value'],
        description: maps[i]['description'],
        isDeleting: maps[i]['isDeleting'] == 1,
        isFavourite: maps[i]['isFavourite'] == 1,
      );
    });
  }

  Future<void> updateItem(TodoTaskModel item) async {
    final db = await databaseHelper.database;
    await db.update(
      'tasks',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> hideItem(String id) async {
    final db = await databaseHelper.database;
    await db.update(
      'tasks',
      {'isDeleting': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteItemPermanently(String id) async {
    final db = await databaseHelper.database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> restoreItem(String id) async {
    final db = await databaseHelper.database;
    await db.update(
      'tasks',
      {'isDeleting': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
