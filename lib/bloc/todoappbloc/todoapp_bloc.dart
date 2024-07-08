import 'package:bloc/bloc.dart';
import 'package:todoapptask/bloc/todoappbloc/todoapp_event.dart';
import 'package:todoapptask/bloc/todoappbloc/todoapp_state.dart';
import '../../model/todo_task_model.dart';
import '../../repository/todo_repository.dart';

class ToDoAppBloc extends Bloc<ToDoAppEvent, TodoappState> {
  final ToDoAppRepository toDoAppRepository;

  ToDoAppBloc(this.toDoAppRepository) : super(const TodoappState()) {
    on<FetchTaskList>(_fetchList);
    on<FetchHiddenTasks>(_fetchHiddenTasks);
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
      final favouriteItems = taskList.where((item) => item.isFavourite).toList();
      emit(state.copyWith(
        taskItemList: List.from(taskList),
        favouriteList: favouriteItems,
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
      final favouriteItems = taskList.where((item) => item.isFavourite).toList();
      emit(state.copyWith(taskItemList: List.from(taskList), favouriteList: favouriteItems));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _handleFavouriteItem(FavouriteItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.updateItem(event.item.copyWith(isFavourite: !event.item.isFavourite));
      final taskList = await toDoAppRepository.fetchItems();
      final favouriteItems = taskList.where((item) => item.isFavourite).toList();
      emit(state.copyWith(
        taskItemList: List.from(taskList),
        favouriteList: favouriteItems,
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

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

  void _hideItem(HideItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.hideItem(event.id);

      final taskList = await toDoAppRepository.fetchItems();
      final hiddenItem = taskList.firstWhere(
            (item) => item.id == event.id,
        orElse: () => TodoTaskModel(
          id: event.id,
          value: event.value,
          description: event.description, // Handle description
          isFavourite: false,
          isDeleting: true,
        ),
      );

      final updatedSelectedList = List<TodoTaskModel>.from(state.selectedList)
        ..removeWhere((item) => item.id == event.id);

      emit(state.copyWith(
        taskItemList: List.from(taskList),
        hiddenTaskList: List.from(state.hiddenTaskList)..add(hiddenItem),
        selectedList: updatedSelectedList,
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _fetchHiddenTasks(FetchHiddenTasks event, Emitter<TodoappState> emit) async {
    try {
      final hiddenTaskList = await toDoAppRepository.fetchItems(includeDeleted: true);
      final filteredHiddenTasks = hiddenTaskList.where((task) => task.isDeleting).toList();
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
    final updatedList = List<TodoTaskModel>.from(state.selectedList)..add(event.item);
    emit(state.copyWith(selectedList: updatedList));
  }

  void _unSelectItem(UnSelectItem event, Emitter<TodoappState> emit) async {
    final updatedList = List<TodoTaskModel>.from(state.selectedList)..remove(event.item);
    emit(state.copyWith(selectedList: updatedList));
  }
}
