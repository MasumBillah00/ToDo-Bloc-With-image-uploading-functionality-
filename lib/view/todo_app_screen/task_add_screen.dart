import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/view/todo_app_screen/todo_app_screen.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../todo_app_widget/button_widget.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<ToDoAppBloc>().add(ClearErrorEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ToDoAppScreen()),
              );
            },
          ),
        ),
        body: BlocConsumer<ToDoAppBloc, TodoappState>(
          listener: (context, state) {
            if (state.listStatus == ListStatus.failure && state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state.listStatus == ListStatus.success) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _titleController,
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
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        color: Colors.amber[200],
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'Enter task description',
                      hintStyle: TextStyle(
                        color: Colors.amber[200],
                      ),
                      filled: true,
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
                        Icons.description,
                        color: Colors.amber.shade200,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            color: Colors.amber[200],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.amber.shade200,
                          size: 25,
                        ),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AddTaskButton(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    selectedDate: _selectedDate,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
