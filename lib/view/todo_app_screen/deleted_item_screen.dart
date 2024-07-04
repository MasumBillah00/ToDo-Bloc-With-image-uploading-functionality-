import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
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
        drawer:  ToDo_Drawer(onItemTapped: onItemTapped,),
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
                        title: Text(
                          task.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.restore_from_trash,
                                size: 30,
                                color: Colors.white, // Change restore button color
                              ),
                              onPressed: () {
                                context.read<ToDoAppBloc>().add(RestoreItem(id: task.id));
                              },
                            ),
                            const SizedBox(width: 8), // Add spacing between buttons
                            IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                size: 30,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _showDeleteConfirmationDialog(context, task.id);
                              },
                            ),
                          ],
                        ),
                      ),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete permanently?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ToDoAppBloc>().add(DeleteItem(id: taskId));
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
