import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../todo_app_widget/delete_button_widget.dart';

class HiddenTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RecyleBin'),

      ),
      body: BlocBuilder<ToDoAppBloc, TodoappState>(
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
                return ListTile(
                  title: Text(
                    task.value,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.restore,
                      size: 35,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      context.read<ToDoAppBloc>().add(RestoreItem(id: task.id));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
