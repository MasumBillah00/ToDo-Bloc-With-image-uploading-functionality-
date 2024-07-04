

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
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final taskValue = _controller.text;
        if (taskValue.isNotEmpty) {
          final newTask = TodoTaskModel(
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        textStyle: const TextStyle(
          fontSize: 20, // Text size
          fontWeight: FontWeight.w600, // Text weight
        ),
      ),
      child: const Text(
        'Add Task',
      ),
    );
  }
}
