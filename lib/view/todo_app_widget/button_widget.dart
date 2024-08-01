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
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime? selectedDate;
  final String? image;

  const AddTaskButton({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    this.selectedDate,
    this.image,
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
            image: image ?? '',
          );

          context.read<ToDoAppBloc>().add(AddTaskItem(item: newTask));

          // Pop the current screen and navigate back to the ToDoAppScreen
          Navigator.popUntil(context, (route) => route.isFirst);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all fields and select a date'),
            ),
          );
        }
      },
      child: const Text('Add Task', style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.amber,  // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 40.0), // Padding inside the button
        elevation: 5, // Shadow effect
        side: BorderSide(color: Colors.amber.shade700, width: .1), // Border
      ),
    );
  }
}


// class AddTaskButton extends StatelessWidget {
//   final TextEditingController titleController;
//   final TextEditingController descriptionController;
//   final DateTime? selectedDate;
//   final String? image;
//
//   const AddTaskButton({
//     Key? key,
//     required this.titleController,
//     required this.descriptionController,
//     this.selectedDate,
//     this.image,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         final title = titleController.text;
//         final description = descriptionController.text;
//
//         if (title.isNotEmpty && description.isNotEmpty && selectedDate != null) {
//           final newTask = TodoTaskModel(
//             id: DateTime.now().toString(),
//             value: title,
//             description: description,
//             date: selectedDate!,
//             image: image ??'',
//           );
//
//           context.read<ToDoAppBloc>().add(AddTaskItem(item: newTask));
//           Navigator.of(context).pop(); // Close the screen after adding the task
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Please fill all fields and select a date'),
//             ),
//           );
//         }
//       },
//       child: const Text('Add Task',style: TextStyle(
//         fontSize: 20
//       ),),
//     );
//   }
// }