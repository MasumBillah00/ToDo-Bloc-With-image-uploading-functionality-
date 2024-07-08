

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../model/todo_task_model.dart';
import '../todo_app_screen/task_add_screen.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.black,
        size: 32,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TaskAddScreen(),
          ),
        );
      },
    );
  }
}

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
  })  : _titleController = titleController,
        _descriptionController = descriptionController;

  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final taskValue = _titleController.text;
        final taskDescription = _descriptionController.text;
        if (taskValue.isNotEmpty) {
          final newTask = TodoTaskModel(
            id: DateTime.now().toString(),
            value: taskValue,
            description: taskDescription,
          );
          context.read<ToDoAppBloc>().add(AddTaskItem(item: newTask));
          Navigator.pop(context);
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.amber,
        shadowColor: Colors.amberAccent,
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: const Text(
        'Add Task',
      ),
    );
  }
}
