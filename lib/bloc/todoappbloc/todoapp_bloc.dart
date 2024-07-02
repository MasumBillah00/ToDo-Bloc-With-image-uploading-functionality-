import 'package:bloc/bloc.dart';
import 'package:todoapptask/bloc/todoappbloc/todoapp_event.dart';
import 'package:todoapptask/bloc/todoappbloc/todoapp_state.dart';
import '../../model/todo_task_model.dart';
import '../../repository/todo_repository.dart';

class ToDoAppBloc extends Bloc<ToDoAppEvent, TodoappState> {
  final ToDoAppRepository toDoAppRepository;

  ToDoAppBloc(this.toDoAppRepository) : super(const TodoappState()) {
    on<FetchTaskList>(_fetchList);
    on<FetchHiddenTasks>(_fetchHiddenTasks); // Add this line
    on<AddTaskItem>(_handleAddTaskItem);
    on<FavouriteItem>(_handleFavouriteItem);
    on<DeleteItem>(_deleteItem);
    on<HideItem>(_hideItem);
    on<RestoreItem>(_restoreItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
  }

  void _fetchList(FetchTaskList event, Emitter<TodoappState> emit) async {
    try {
      final taskList = await toDoAppRepository.fetchItems();
      emit(state.copyWith(
        taskItemList: List.from(taskList),
        listStatus: ListStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }






  void _handleAddTaskItem(AddTaskItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.addItem(event.item);
      final taskList = await toDoAppRepository.fetchItems();
      emit(state.copyWith(taskItemList: List.from(taskList)));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _handleFavouriteItem(FavouriteItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.updateItem(event.item.copyWith(isFavourite: !event.item.isFavourite));
      final taskList = await toDoAppRepository.fetchItems();
      emit(state.copyWith(
        taskItemList: List.from(taskList),
        FavouriteList: List.from(state.FavouriteList),
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }



  // void _handleFavouriteItem(FavouriteItem event, Emitter<TodoappState> emit) async {
  //   try {
  //     await toDoAppRepository.updateItem(event.item.copyWith(isFavourite: !event.item.isFavourite));
  //     final taskList = await toDoAppRepository.fetchItems();
  //     final favouriteItems = taskList.where((item) => item.isFavourite).toList();
  //     emit(state.copyWith(
  //       tempFavouriteList: taskList,
  //       favouriteItemList: favouriteItems,
  //     ));
  //   } catch (_) {
  //     emit(state.copyWith(listStatus: ListStatus.failure));
  //   }
  // }


  // void _deleteItem(DeleteItem event, Emitter<TodoappState> emit) async {
  //   try {
  //     for (var item in state.tempFavouriteList) {
  //       await toDoAppRepository.hideItem(item.id);
  //     }
  //     final taskList = await toDoAppRepository.fetchItems();
  //     emit(state.copyWith(
  //       favouriteItemList: List.from(taskList),
  //       tempFavouriteList: [],
  //     ));
  //   } catch (_) {
  //     emit(state.copyWith(listStatus: ListStatus.failure));
  //   }
  // }
  void _deleteItem(DeleteItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.deleteItemPermanently(event.id);
      final taskList = await toDoAppRepository.fetchItems(includeDeleted: true);
      final filteredHiddenTasks = taskList.where((task) => task.isDeleting).toList();

      emit(state.copyWith(
        taskItemList: List.from(taskList),
        hiddenTaskList: List.from(filteredHiddenTasks),
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  // void _hideItem(HideItem event, Emitter<TodoappState> emit) async {
  //   try {
  //     await toDoAppRepository.hideItem(event.id);
  //     final taskList = await toDoAppRepository.fetchItems();
  //     emit(state.copyWith(
  //       favouriteItemList: List.from(taskList),
  //       hiddenTaskList: List.from(state.hiddenTaskList)..add(event.item),
  //     ));
  //   } catch (_) {
  //     emit(state.copyWith(listStatus: ListStatus.failure));
  //   }
  // }

  void _hideItem(HideItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.hideItem(event.id);

      final taskList = await toDoAppRepository.fetchItems();
      final hiddenItem = taskList.firstWhere(
            (item) => item.id == event.id,
        orElse: () => TodoTaskModelModel(id: event.id, value: event.value, isFavourite: false, isDeleting: true),
      );

      emit(state.copyWith(
        taskItemList: List.from(taskList),
        hiddenTaskList: List.from(state.hiddenTaskList)..add(hiddenItem),
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }





  void _fetchHiddenTasks(FetchHiddenTasks event, Emitter<TodoappState> emit) async {
    try {
      final hiddenTaskList = await toDoAppRepository.fetchItems(includeDeleted: true);
      //print('Hidden Task List fetched: $hiddenTaskList');
      final filteredHiddenTasks = hiddenTaskList.where((task) => task.isDeleting).toList();
      //print('Filtered Hidden Tasks: $filteredHiddenTasks');
      emit(state.copyWith(
        hiddenTaskList: List.from(filteredHiddenTasks),
        listStatus: ListStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }



  void _restoreItem(RestoreItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.restoreItem(event.id);
      final taskList = await toDoAppRepository.fetchItems();
      emit(state.copyWith(
        taskItemList: List.from(taskList),
        hiddenTaskList: List.from(state.hiddenTaskList)..removeWhere((task) => task.id == event.id),
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _selectItem(SelectItem event, Emitter<TodoappState> emit) async {
    final updatedList = List<TodoTaskModelModel>.from(state.FavouriteList)..add(event.item);
    emit(state.copyWith(FavouriteList: updatedList));
  }

  void _unSelectItem(UnSelectItem event, Emitter<TodoappState> emit) async {
    final updatedList = List<TodoTaskModelModel>.from(state.FavouriteList)..remove(event.item);
    emit(state.copyWith(FavouriteList: updatedList));
  }
}
