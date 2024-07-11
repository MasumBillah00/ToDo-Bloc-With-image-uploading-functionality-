import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../component/allert_dialog.dart';
import '../component/icon_button_widget.dart';
import '../todo_app_widget/component_widget.dart';
import '../todo_app_widget/drawer_widget.dart';

class DeletedItemScreen extends StatelessWidget {
  //const DeletedItemScreen({super.key});
  final ValueChanged<int> onItemTapped;

  const DeletedItemScreen({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Recycle Bin',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
        ),
        drawer: ToDo_Drawer(
          onItemTapped: onItemTapped,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: BlocBuilder<ToDoAppBloc, TodoappState>(
            builder: (context, state) {
              if (state.listStatus == ListStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.listStatus == ListStatus.failure) {
                return const Center(child: Text('Failed to load tasks'));
              } else if (state.hiddenTaskList.isEmpty) {
                return const Center(child: Text('Empty RecycleBin'));
              } else {
                return ListView.builder(
                  itemCount: state.hiddenTaskList.length,
                  itemBuilder: (context, index) {
                    final task = state.hiddenTaskList[index];
                    return Card(
                      color: Colors.grey[800],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                          title: CustomText(
                            text: task.value,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomIconButton(
                                icon: Icons.restore_from_trash,
                                //size: 30,
                                color: Colors.white,
                                onPressed: () {
                                  context.read<ToDoAppBloc>().add(RestoreItem(id: task.id));
                                },
                              ),
                              const SizedBox(width: 8),
                              CustomIconButton(
                                icon: Icons.delete_forever,
                                //size: 30,
                                color: Colors.red,
                                onPressed: () {
                                  _showDeleteConfirmationDialog(context, task.id);
                                },
                              ),
                            ],
                          )),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String taskId) {
    showConfirmationDialog(
      context: context,
      title: 'Confirm Deletion',
      content: 'Are you sure you want to delete permanently?',
      onConfirm: () {
        context.read<ToDoAppBloc>().add(DeleteItem(id: taskId));
      },
    );
  }
}
