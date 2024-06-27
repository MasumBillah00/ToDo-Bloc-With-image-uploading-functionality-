import 'package:equatable/equatable.dart';

import '../../model/todo_task_model.dart';

abstract class ToDoAppEvent extends Equatable {
  const ToDoAppEvent();
  @override
  List<Object?> get props => [];
}

class FetchTaskList extends ToDoAppEvent {}

class AddTaskItem extends ToDoAppEvent {
  final TodoTaskModelModel item;
  const AddTaskItem({required this.item});

  @override
  List<Object?> get props => [item];
}

class FavouriteItem extends ToDoAppEvent {
  final TodoTaskModelModel item;
  const FavouriteItem({required this.item});

  @override
  List<Object?> get props => [item];
}

class SelectItem extends ToDoAppEvent {
  final TodoTaskModelModel item;
  const SelectItem({required this.item});

  @override
  List<Object?> get props => [item];
}

class UnSelectItem extends ToDoAppEvent {
  final TodoTaskModelModel item;
  const UnSelectItem({required this.item});

  @override
  List<Object?> get props => [item];
}

class DeleteItem extends ToDoAppEvent {}
