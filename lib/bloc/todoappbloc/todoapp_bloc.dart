import 'package:bloc/bloc.dart';
import 'package:todoapptask/bloc/todoappbloc/todoapp_event.dart';
import 'package:todoapptask/bloc/todoappbloc/todoapp_state.dart';

import '../../model/todo_task_model.dart';
import '../../repository/todo_repository.dart';

class ToDoAppBloc extends Bloc<ToDoAppEvent, TodoappState> {
  List<TodoTaskModelModel> taskList = [];
  List<TodoTaskModelModel> tempFavouriteList = [];

  ToDoAppRepository toDoAppRepository;

  ToDoAppBloc(this.toDoAppRepository) : super(const TodoappState()) {
    on<FetchTaskList>(fetchList);
    on<AddTaskItem>(_handleAddTaskItem);
    on<FavouriteItem>(_addFavouriteItem);
    on<DeleteItem>(deleteItem);
    on<SelectItem>(selectedItem);
    on<UnSelectItem>(unSelectItem);
  }

  void selectedItem(SelectItem event, Emitter<TodoappState> emit) async {
    tempFavouriteList.add(event.item);
    emit(state.copyWith(tempFavouriteList: List.from(tempFavouriteList)));
  }

  void unSelectItem(UnSelectItem event, Emitter<TodoappState> emit) async {
    tempFavouriteList.remove(event.item);
    emit(state.copyWith(tempFavouriteList: List.from(tempFavouriteList)));
  }

  void fetchList(FetchTaskList event, Emitter<TodoappState> emit) async {
    taskList = await toDoAppRepository.fetchItems();
    emit(state.copyWith(
      favouriteItemList: List.from(taskList),
      listStatus: ListStatus.success,
    ));
  }

  void _addFavouriteItem(FavouriteItem event, Emitter<TodoappState> emit) async {
    final personIndex = taskList.indexWhere((person) => person.id == event.item.id);
    if (event.item.isFavourite) {
      if (tempFavouriteList.contains(taskList[personIndex])) {
        tempFavouriteList.remove(taskList[personIndex]);
        tempFavouriteList.add(event.item);
      }
    } else {
      if (tempFavouriteList.contains(taskList[personIndex])) {
        tempFavouriteList.remove(taskList[personIndex]);
        tempFavouriteList.add(event.item);
      }
    }
    taskList[personIndex] = event.item;
    emit(state.copyWith(
      favouriteItemList: List.from(taskList),
      tempFavouriteList: List.from(tempFavouriteList),
    ));
  }

  void deleteItem(DeleteItem event, Emitter<TodoappState> emit) async {
    for (int i = 0; i < tempFavouriteList.length; i++) {
      taskList.remove(tempFavouriteList[i]);
    }

    tempFavouriteList.clear();
    emit(state.copyWith(
      favouriteItemList: List.from(taskList),
      tempFavouriteList: List.from(tempFavouriteList),
    ));
  }

  void _handleAddTaskItem(AddTaskItem event, Emitter<TodoappState> emit) async {
    taskList.add(event.item);
    emit(state.copyWith(favouriteItemList: List.from(taskList)));
  }
}
