

import '../database_helper/database_helper.dart';
import '../model/todo_task_model.dart';

class ToDoAppRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<TodoTaskModelModel>> fetchItems() async {
    final tasksData = await _databaseHelper.queryAllTasks();
    return tasksData.map((task) => TodoTaskModelModel.fromMap(task)).toList();
  }

  Future<void> addItem(TodoTaskModelModel item) async {
    await _databaseHelper.insertTask(item.toMap());
  }

  Future<void> updateItem(TodoTaskModelModel item) async {
    await _databaseHelper.updateTask(item.toMap());
  }

  Future<void> deleteItem(String id) async {
    await _databaseHelper.deleteTask(id);
  }
}







//
//
// import 'package:blocmultiplestats/model/favourite/favourite_item_model.dart';
//
// class FavouriteRepository{Future<List<FavouriteItemModel>>fetchItem()async{
//   await Future.delayed(Duration(seconds: 3));
//   return List.of(_generateList(10));
//  }
//
//  List<FavouriteItemModel>_generateList(int length){
//   return List.generate(length, (index)=> FavouriteItemModel(id: index.toString(), value: 'Item: $index'));
//  }
//
// }


// class FavouriteRepository {
//   final List<FavouriteItemModel> _items = [];
//
//   Future<List<FavouriteItemModel>> fetchItem() async {
//     await Future.delayed(Duration(seconds: 3));
//     return List.of(_items);
//   }
//
//   void addItem(FavouriteItemModel item) {
//     _items.add(item);
//   }
//
//   void addItems(List<FavouriteItemModel> items) {
//     _items.addAll(items);
//   }
// }