import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
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
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, item.id, item.value);
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

  void _showDeleteConfirmationDialog(BuildContext context, String taskId, String taskValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ToDoAppBloc>().add(HideItem(id: taskId, value: taskValue));
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
