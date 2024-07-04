import 'package:flutter/material.dart';
import '../todo_app_widget/button_widget.dart';

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
          title: const Text('Add Task'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              AddTaskButton(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}
