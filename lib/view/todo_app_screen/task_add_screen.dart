import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../model/todo_task_model.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Task'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Task',
                  labelStyle: TextStyle(
                    color: Colors.amber[200],
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Enter your task',
                  hintStyle: TextStyle(
                    color: Colors.amber[200],
                  ),
                  filled: true,
                  //fillColor: Colors.grey.shade800,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.amber.shade200,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.amber.shade200,
                      width: 1.0,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.task,
                    color: Colors.amber.shade200,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final taskValue = _controller.text;
                  if (taskValue.isNotEmpty) {
                    final newTask = TodoTaskModelModel(
                      id: DateTime.now().toString(),
                      value: taskValue,
                    );
                    context.read<ToDoAppBloc>().add(AddTaskItem(item: newTask));
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.amber, // Text color
                  shadowColor: Colors.amberAccent, // Shadow color
                  elevation: 5, // Elevation
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  textStyle: TextStyle(
                    fontSize: 20, // Text size
                    fontWeight: FontWeight.w600, // Text weight
                  ),
                ),
                child: Text('Add Task',),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
