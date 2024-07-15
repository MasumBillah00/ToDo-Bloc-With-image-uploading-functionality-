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

// class AddTaskButton extends StatelessWidget {
//   const AddTaskButton({
//     super.key,
//     required TextEditingController titleController,
//     required TextEditingController descriptionController,
//     required this.selectedDate,
//   })  : _titleController = titleController,
//         _descriptionController = descriptionController;
//
//   final TextEditingController _titleController;
//   final TextEditingController _descriptionController;
//   final DateTime? selectedDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         final taskValue = _titleController.text;
//         final taskDescription = _descriptionController.text;
//         if (taskValue.isNotEmpty) {
//           final newTask = TodoTaskModel(
//             id: DateTime.now().toString(),
//             value: taskValue,
//             description: taskDescription,
//           );
//           context.read<ToDoAppBloc>().add(AddTaskItem(item: newTask));
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.amber,
//         shadowColor: Colors.amberAccent,
//
//         elevation: 8,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       child: const Text('Add Task'),
//     );
//   }
// }



class AddTaskButton extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime? selectedDate;

  const AddTaskButton({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final title = titleController.text;
        final description = descriptionController.text;

        if (title.isNotEmpty && description.isNotEmpty && selectedDate != null) {
          final newTask = TodoTaskModel(
            id: DateTime.now().toString(),
            value: title,
            description: description,
            date: selectedDate!,
          );

          context.read<ToDoAppBloc>().add(AddTaskItem(item: newTask));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all fields and select a date'),
            ),
          );
        }
      },
      child: const Text('Add Task'),
    );
  }
}

