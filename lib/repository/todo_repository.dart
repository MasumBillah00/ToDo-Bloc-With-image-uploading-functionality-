


import '../model/todo_task_model.dart';

class ToDoAppRepository {
  List<TodoTaskModelModel> _favouriteItems = [];

  Future<List<TodoTaskModelModel>> fetchItems() async {
    await Future.delayed(Duration(seconds: 3));
    return List.from(_favouriteItems);
  }

  void addItem(TodoTaskModelModel item) {
    _favouriteItems.add(item);
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