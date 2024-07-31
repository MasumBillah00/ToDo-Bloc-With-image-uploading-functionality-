import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapptask/view/todo_app_screen/todo_app_screen.dart';
import '../../bloc/imagepicker/imagepicker_bloc.dart';
import '../../bloc/imagepicker/imagepicker_event.dart';
import '../../bloc/imagepicker/imagepicker_state.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../../model/todo_task_model.dart';
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
  XFile? _selectedImage;

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
              Navigator.pop(context);
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
                        padding: const EdgeInsets.only(top: 15, right: 15, left: 15,),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      width: 3.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.amber.shade200,
                                      width: 2.0,
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
                                      width: 3.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.amber.shade200,
                                      width: 2.0,
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
                                          fontSize: 16
                                      ),
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
                              const SizedBox(height: 10),
                          
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ImagePickerBloc>().add(GalleryPicker());
                                },
                                child: const Text('Pick Image from Gallery',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),),
                              ),
                              SizedBox(height: 10,),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ImagePickerBloc>().add(CameraCapture());
                                },
                                child: const Text('Capture Image',
                                  style:TextStyle(
                                      fontSize: 20
                                  ) ,),
                              ),
                          
                          
                              const SizedBox(height: 20),
                              if (imagePickerState.file != null)
                                Image.file(
                                  File(imagePickerState.file!.path),
                                  height: 80,
                                  width: 80,
                                ),
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
                }
            );
          },
        ),
      ),
    );
  }
}


// class TaskAddScreen extends StatefulWidget {
//   const TaskAddScreen({super.key});
//
//   @override
//   State<TaskAddScreen> createState() => _TaskAddScreenState();
// }
//
// class _TaskAddScreenState extends State<TaskAddScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   DateTime? _selectedDate;
//   XFile? _selectedImage;
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
//
//   void _selectDate(BuildContext context) async {
//     final selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//
//     if (selectedDate != null) {
//       setState(() {
//         _selectedDate = selectedDate;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Add Task'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               context.read<ToDoAppBloc>().add(ClearErrorEvent());
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ToDoAppScreen()),
//               );
//             },
//           ),
//         ),
//         body: BlocConsumer<ToDoAppBloc, TodoappState>(
//           listener: (context, state) {
//             if (state.listStatus == ListStatus.failure && state.errorMessage.isNotEmpty) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.errorMessage),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             } else if (state.listStatus == ListStatus.success) {
//               Navigator.pop(context);
//             }
//           },
//           builder: (context, state) {
//             return BlocBuilder<ImagePickerBloc, ImagePickerState>(
//                 builder: (context, imagePickerState) {
//                   return Container(
//                     color: Colors.black.withOpacity(.2),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 15,right: 15,left: 15,),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         //crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           TextField(
//                             controller: _titleController,
//                             decoration: InputDecoration(
//                               labelText: 'Task',
//                               labelStyle: TextStyle(
//                                 color: Colors.amber[200],
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               hintText: 'Enter your task',
//                               hintStyle: TextStyle(
//                                 color: Colors.amber[200],
//                               ),
//                               filled: true,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide.none,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: Colors.amber.shade200,
//                                   width: 3.0,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: Colors.amber.shade200,
//                                   width: 2.0,
//                                 ),
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.task,
//                                 color: Colors.amber.shade200,
//                               ),
//                             ),
//                             style: const TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           TextField(
//                             controller: _descriptionController,
//                             decoration: InputDecoration(
//                               labelText: 'Description',
//                               labelStyle: TextStyle(
//                                 color: Colors.amber[200],
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               hintText: 'Enter task description',
//                               hintStyle: TextStyle(
//                                 color: Colors.amber[200],
//                               ),
//                               filled: true,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide.none,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: Colors.amber.shade200,
//                                   width: 3.0,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: Colors.amber.shade200,
//                                   width: 2.0,
//                                 ),
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.description,
//                                 color: Colors.amber.shade200,
//                               ),
//                             ),
//                             style: const TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//
//                           const SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   _selectedDate == null
//                                       ? 'No Date Chosen!'
//                                       : 'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
//                                   style: TextStyle(
//                                     color: Colors.amber[200],
//                                     fontSize: 16
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.calendar_month_outlined,
//                                   color: Colors.amber.shade200,
//                                   size: 50,
//                                 ),
//                                 onPressed: () => _selectDate(context),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//
//                           ElevatedButton(
//                             onPressed: () {
//                               context.read<ImagePickerBloc>().add(GalleryPicker());
//                             },
//                             child: const Text('Pick Image from Gallery',
//                               style: TextStyle(
//                                 fontSize: 20,
//                               ),),
//                           ),
//                           SizedBox(height: 10,),
//                           ElevatedButton(
//                             onPressed: () {
//                               context.read<ImagePickerBloc>().add(CameraCapture());
//                             },
//                             child: const Text('Capture Image',
//                               style:TextStyle(
//                                 fontSize: 20
//                               ) ,),
//                           ),
//
//
//                           const SizedBox(height: 20),
//                           if (imagePickerState.file != null)
//                             Image.file(
//                               File(imagePickerState.file!.path),
//                               height: 80,
//                               width: 80,
//
//                             ),
//                           //const SizedBox(height: 10),
//                           AddTaskButton(
//                             titleController: _titleController,
//                             descriptionController: _descriptionController,
//                             selectedDate: _selectedDate,
//                             image: imagePickerState.file?.path,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


