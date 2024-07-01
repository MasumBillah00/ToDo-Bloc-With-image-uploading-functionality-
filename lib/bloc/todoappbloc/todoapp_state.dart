import 'package:equatable/equatable.dart';
import '../../model/todo_task_model.dart';

enum ListStatus { loading, success, failure }

class TodoappState extends Equatable {
  final List<TodoTaskModelModel> favouriteItemList;
  final List<TodoTaskModelModel> hiddenTaskList; // Added hiddenTaskList
  final List<TodoTaskModelModel> tempFavouriteList;
  final ListStatus listStatus;

  const TodoappState({
    this.favouriteItemList = const [],
    this.hiddenTaskList = const [], // Initialized hiddenTaskList
    this.listStatus = ListStatus.loading,
    this.tempFavouriteList = const [],
  });

  TodoappState copyWith({
    List<TodoTaskModelModel>? favouriteItemList,
    List<TodoTaskModelModel>? hiddenTaskList, // Added hiddenTaskList in copyWith
    ListStatus? listStatus,
    List<TodoTaskModelModel>? tempFavouriteList,
  }) {
    return TodoappState(
      favouriteItemList: favouriteItemList ?? this.favouriteItemList,
      hiddenTaskList: hiddenTaskList ?? this.hiddenTaskList, // Updated copyWith
      tempFavouriteList: tempFavouriteList ?? this.tempFavouriteList,
      listStatus: listStatus ?? this.listStatus,
    );
  }

  @override
  List<Object?> get props => [favouriteItemList, hiddenTaskList, listStatus, tempFavouriteList]; // Added hiddenTaskList in props
}
