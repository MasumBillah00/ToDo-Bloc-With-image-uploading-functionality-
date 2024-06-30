import 'package:bloc/bloc.dart';
import 'package:todoapptask/bloc/todoappbloc/todoapp_event.dart';
import 'package:todoapptask/bloc/todoappbloc/todoapp_state.dart';
import '../../model/todo_task_model.dart';
import '../../repository/todo_repository.dart';

class ToDoAppBloc extends Bloc<ToDoAppEvent, TodoappState> {
  final ToDoAppRepository toDoAppRepository;

  ToDoAppBloc(this.toDoAppRepository) : super(const TodoappState()) {
    on<FetchTaskList>(_fetchList);
    on<AddTaskItem>(_handleAddTaskItem);
    on<FavouriteItem>(_handleFavouriteItem);
    on<DeleteItem>(_deleteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
  }

  void _selectItem(SelectItem event, Emitter<TodoappState> emit) async {
    final updatedList = List<TodoTaskModelModel>.from(state.tempFavouriteList)..add(event.item);
    emit(state.copyWith(tempFavouriteList: updatedList));
  }

  void _unSelectItem(UnSelectItem event, Emitter<TodoappState> emit) async {
    final updatedList = List<TodoTaskModelModel>.from(state.tempFavouriteList)..remove(event.item);
    emit(state.copyWith(tempFavouriteList: updatedList));
  }


  void _fetchList(FetchTaskList event, Emitter<TodoappState> emit) async {
    try {
      final taskList = await toDoAppRepository.fetchItems();
      emit(state.copyWith(
        favouriteItemList: List.from(taskList),
        listStatus: ListStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _handleFavouriteItem(FavouriteItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.updateItem(event.item.copyWith(isFavourite: !event.item.isFavourite));
      final taskList = await toDoAppRepository.fetchItems();
      emit(state.copyWith(
        favouriteItemList: List.from(taskList),
        tempFavouriteList: List.from(state.tempFavouriteList),
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }

  void _deleteItem(DeleteItem event, Emitter<TodoappState> emit) async {
    try {
      for (var item in state.tempFavouriteList) {
        await toDoAppRepository.deleteItem(item.id);
      }
      final taskList = await toDoAppRepository.fetchItems();
      emit(state.copyWith(
        favouriteItemList: List.from(taskList),
        tempFavouriteList: [],
      ));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }



  void _handleAddTaskItem(AddTaskItem event, Emitter<TodoappState> emit) async {
    try {
      await toDoAppRepository.addItem(event.item);
      final taskList = await toDoAppRepository.fetchItems();
      emit(state.copyWith(favouriteItemList: List.from(taskList)));
    } catch (_) {
      emit(state.copyWith(listStatus: ListStatus.failure));
    }
  }
}
