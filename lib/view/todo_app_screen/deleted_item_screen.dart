import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/view/todo_app_widget/delete_button_widget.dart';

import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';

class HiddenTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Recycle Bin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,
          horizontal: 12),
          child: BlocBuilder<ToDoAppBloc, TodoappState>(
            builder: (context, state) {
              if (state.listStatus == ListStatus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.listStatus == ListStatus.failure) {
                return Center(child: Text('Failed to load tasks'));
              } else if (state.hiddenTaskList.isEmpty) {
                return Center(child: Text('No hidden tasks'));
              } else {
                return ListView.builder(
                  itemCount: state.hiddenTaskList.length,
                  itemBuilder: (context, index) {
                    final task = state.hiddenTaskList[index];
                    return Card(
                      color: Colors.grey[600], // Dark background color
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          task.value,
                          style: TextStyle(color: Colors.white,
                              fontSize: 30,
                          fontWeight: FontWeight.bold),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.restore_from_trash,
                                size: 45,
                                color: Colors.white, // Change restore button color
                              ),
                              onPressed: () {
                                context.read<ToDoAppBloc>().add(RestoreItem(id: task.id));
                              },
                            ),
                            SizedBox(width: 8), // Add spacing between buttons
                            // IconButton(
                            //   icon: Icon(
                            //     Icons.delete_forever,
                            //     size: 35,
                            //     color: Colors.red,
                            //   ),
                            //   onPressed: () {
                            //     context.read<ToDoAppBloc>().add(DeleteItem());
                            //   },
                            // ),
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
}
