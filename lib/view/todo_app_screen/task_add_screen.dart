import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/view/todo_app_screen/todo_app_screen.dart';
import '../../bloc/imagepicker/imagepicker_bloc.dart';
import '../../bloc/imagepicker/imagepicker_event.dart'; // Import the events
import '../../bloc/imagepicker/imagepicker_state.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../component/image_design.dart';
import '../component/textfield_widget.dart';
import '../todo_app_widget/button_widget.dart';
import '../todo_app_widget/custom_drop_down_widget.dart';

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ToDoAppScreen(),
                ),
              );
            },
          ),
        ),
        body: BlocConsumer<ToDoAppBloc, TodoappState>(
          listener: (context, state) {
            if (state.listStatus == ListStatus.failure &&
                state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state.listStatus == ListStatus.success) {
              context
                  .read<ToDoAppBloc>()
                  .add(FetchTaskList()); // Re-fetch tasks
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          },
          builder: (context, state) {
            return BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, imagePickerState) {
                return SingleChildScrollView(
                  child: Container(
                    color: Colors.black.withOpacity(.2),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        right: 15,
                        left: 15,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedDate == null
                                        ? ''
                                        : 'Selected Date: ${_selectedDate!.toLocal()}'
                                            .split(' ')[0],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.amber.shade200,
                                    size: 50,
                                  ),
                                  onPressed: () => _selectDate(context),
                                ),
                              ],
                            ),
                            CustomTextField(
                              controller: _titleController,
                              labelText: 'Task',
                              hintText: 'Enter your task',
                              icon: Icons.task,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: _descriptionController,
                              labelText: 'Description',
                              hintText: 'Enter task description',
                              icon: Icons.description,
                            ),
                            const SizedBox(height: 20),
                            const CustomDropdownButton(),
                            const SizedBox(height: 20),
                            if (imagePickerState.file !=
                                null) // Only show if file exists
                              Stack(
                                children: [
                                  ImageDesign(
                                      imageFile:
                                          File(imagePickerState.file!.path)),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.red),
                                      onPressed: () {
                                        context
                                            .read<ImagePickerBloc>()
                                            .add(ClearImageEvent());
                                        print("ClearImageEvent dispatched");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 25),
                            AddTaskButton(
                              titleController: _titleController,
                              descriptionController: _descriptionController,
                              selectedDate: _selectedDate,
                              image: imagePickerState.file?.path,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
