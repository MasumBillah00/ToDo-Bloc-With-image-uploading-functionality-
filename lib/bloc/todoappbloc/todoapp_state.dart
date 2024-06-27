import 'package:equatable/equatable.dart';

import '../../model/todo_task_model.dart';

enum ListStatus { loading, success, failure }

class TodoappState extends Equatable {
  final List<TodoTaskModelModel> favouriteItemList;
  final List<TodoTaskModelModel> tempFavouriteList;
  final ListStatus listStatus;

  const TodoappState({
    this.favouriteItemList = const [],
    this.listStatus = ListStatus.loading,
    this.tempFavouriteList = const [],
  });

  TodoappState copyWith({
    List<TodoTaskModelModel>? favouriteItemList,
    ListStatus? listStatus,
    List<TodoTaskModelModel>? tempFavouriteList,
  }) {
    return TodoappState(
      favouriteItemList: favouriteItemList ?? this.favouriteItemList,
      listStatus: listStatus ?? this.listStatus,
      tempFavouriteList: tempFavouriteList ?? this.tempFavouriteList,
    );
  }

  @override
  List<Object?> get props => [favouriteItemList, listStatus, tempFavouriteList];
}
