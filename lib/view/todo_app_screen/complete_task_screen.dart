import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/view/constant.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../component/allert_dialog.dart';
import '../component/icon_button_widget.dart';
import '../todo_app_widget/drawer_widget.dart';

class CompleteTasksScreen extends StatelessWidget {
  final ValueChanged<int> onItemTapped;

  const CompleteTasksScreen({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Finished Task',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          drawer: ToDo_Drawer(onItemTapped: onItemTapped),
          body: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: BlocBuilder<ToDoAppBloc, TodoappState>(
              builder: (context, state) {
                if (state.selectedList.isEmpty) {
                  return const Center(child: Text('No completed task yet'));
                }
                return ListView.builder(
                  itemCount: state.selectedList.length,
                  itemBuilder: (context, index) {
                    final item = state.selectedList[index];
                    return Card(
                      color: Colors.grey[800],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          item.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: CustomIconButton(
                          icon: Icons.delete,
                         // size: 30,
                          color: AppColors.deleteColor,
                          onPressed: () {
                            _showHideConfirmationDialog(context, item.id, item.value);
                          },
                        ),

                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showHideConfirmationDialog(BuildContext context, String taskId, String taskValue) {
    showConfirmationDialog(
      context: context,
      title: 'Confirm Delete',
      content: 'Are you sure you want to delete?',
      onConfirm: () {
        context.read<ToDoAppBloc>().add(HideItem(id: taskId, value: taskValue));
      },
    );
  }
}



