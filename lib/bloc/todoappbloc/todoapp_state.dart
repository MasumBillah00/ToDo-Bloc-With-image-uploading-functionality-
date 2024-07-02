import 'package:equatable/equatable.dart';
import '../../model/todo_task_model.dart';

enum ListStatus { loading, success, failure }

class TodoappState extends Equatable {
  final List<TodoTaskModelModel> taskItemList;
  final List<TodoTaskModelModel> hiddenTaskList; // Added hiddenTaskList
  final List<TodoTaskModelModel> FavouriteList;
  final ListStatus listStatus;

  const TodoappState({
    this.taskItemList = const [],
    this.hiddenTaskList = const [], // Initialized hiddenTaskList
    this.listStatus = ListStatus.loading,
    this.FavouriteList = const [],
  });

  TodoappState copyWith({
    List<TodoTaskModelModel>? taskItemList,
    List<TodoTaskModelModel>? hiddenTaskList, // Added hiddenTaskList in copyWith
    ListStatus? listStatus,
    List<TodoTaskModelModel>? FavouriteList,
  }) {
    return TodoappState(
      taskItemList: taskItemList ?? this.taskItemList,
      hiddenTaskList: hiddenTaskList ?? this.hiddenTaskList, // Updated copyWith
      FavouriteList: FavouriteList ?? this.FavouriteList,
      listStatus: listStatus ?? this.listStatus,
    );
  }

  @override
  List<Object?> get props => [taskItemList, hiddenTaskList, listStatus, FavouriteList]; // Added hiddenTaskList in props
}
