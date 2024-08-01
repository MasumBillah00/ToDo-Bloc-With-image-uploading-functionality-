import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapptask/model/todo_task_model.dart';
import 'package:todoapptask/view/todo_app_screen/complete_task_screen.dart';
import 'package:todoapptask/view/todo_app_screen/deleted_item_screen.dart';
import 'package:todoapptask/view/todo_app_screen/favoruite_item_screen.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../component/allert_dialog.dart';
import '../todo_app_widget/icon_button_widget.dart';
import '../login_registration/login_screen/login_screen.dart';
import '../todo_app_widget/button_widget.dart';
import '../component/component_widget.dart';
import '../todo_app_widget/drawer_widget.dart';


class ToDoAppScreen extends StatefulWidget {
  const ToDoAppScreen({super.key});

  @override
  State<ToDoAppScreen> createState() => _ToDoAppScreenState();
}

class _ToDoAppScreenState extends State<ToDoAppScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ToDoAppBloc>().add(FetchTaskList());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 1:
        return FavouriteScreen(onItemTapped: _onItemTapped);
      case 2:
        return CompleteTasksScreen(onItemTapped: _onItemTapped);
      case 3:
        return DeletedItemScreen(onItemTapped: _onItemTapped);
      case 4:
        return const LoginScreen();
      default:
        return BlocBuilder<ToDoAppBloc, TodoappState>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ListStatus.failure:
                return const Center(child: Text('Something went wrong'));
              case ListStatus.success:
                return ListView.builder(
                  itemCount: state.taskItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.taskItemList[index];
                    final isSelected = state.selectedList.contains(item);
                    String formattedDate = DateFormat.MMMd().format(item.date);

                    // return Card(
                    //   color: Colors.grey[900],
                    //   elevation: 4,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //
                    //      Checkbox(
                    //       value: isSelected,
                    //       onChanged: (bool? value) {
                    //         if (value == true) {
                    //           context.read<ToDoAppBloc>().add(SelectItem(item: item));
                    //         } else {
                    //           context.read<ToDoAppBloc>().add(UnSelectItem(item: item));
                    //         }
                    //       },
                    //     ),
                    //      SizedBox(
                    //        width: 150,
                    //        child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               CustomText(
                    //                 text: item.value,
                    //                 isSelected: isSelected,
                    //               ),
                    //               //Text(formattedDate),
                    //             ],
                    //           ),
                    //           const SizedBox(height: 5),
                    //
                    //           DCustomText(
                    //             text: item.description,
                    //             isSelected: isSelected,
                    //             showSeeMore: true,
                    //           ),
                    //
                    //
                    //           if (item.image.isNotEmpty) ...[
                    //             const SizedBox(height: 5),
                    //             Container(
                    //               height: 150,
                    //               width: 140,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(12), // Adjust the border radius as needed
                    //                 border: Border.all(
                    //                   color: Colors.blue, // Set the border color
                    //                   width: 2, // Set the border width
                    //                 ),
                    //                 shape: BoxShape.rectangle, // Can be BoxShape.circle for circular images
                    //               ),
                    //               child: ClipRRect(
                    //                 borderRadius: BorderRadius.circular(12), // Match the border radius here
                    //                 child: Image.file(
                    //                   File(item.image),
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //
                    //         ],
                    //                                ),
                    //      ),
                    //
                    //      Container(
                    //        child: Column(
                    //          mainAxisAlignment: MainAxisAlignment.start,
                    //          crossAxisAlignment: CrossAxisAlignment.start,
                    //          children: [
                    //            Text(formattedDate),
                    //            Row(
                    //              mainAxisSize: MainAxisSize.min,
                    //              children: [
                    //
                    //                IconButton(
                    //                  onPressed: () {
                    //                    context.read<ToDoAppBloc>().add(FavouriteItem(item: item));
                    //                  },
                    //                  icon: Icon(
                    //                    item.isFavourite ? Icons.favorite : Icons.favorite_outline,
                    //                    color: Colors.amberAccent,
                    //                    size: 30,
                    //                  ),
                    //                ),
                    //                const SizedBox(width: 15),
                    //                CustomIconButton(
                    //                  icon: Icons.delete,
                    //                  color: Colors.red,
                    //                  onPressed: () {
                    //                    _showHideConfirmationDialog(context, item.id, item.value);
                    //                  },
                    //                ),
                    //              ],
                    //            ),
                    //          ],
                    //        ),
                    //      ),
                    //   ],
                    //     // leading: Checkbox(
                    //     //   value: isSelected,
                    //     //   onChanged: (bool? value) {
                    //     //     if (value == true) {
                    //     //       context.read<ToDoAppBloc>().add(SelectItem(item: item));
                    //     //     } else {
                    //     //       context.read<ToDoAppBloc>().add(UnSelectItem(item: item));
                    //     //     }
                    //     //   },
                    //     // ),
                    //     // title: Column(
                    //     //   crossAxisAlignment: CrossAxisAlignment.start,
                    //     //   children: [
                    //     //     Row(
                    //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     //       children: [
                    //     //         CustomText(
                    //     //           text: item.value,
                    //     //           isSelected: isSelected,
                    //     //         ),
                    //     //         Text(formattedDate),
                    //     //       ],
                    //     //     ),
                    //     //     const SizedBox(height: 5),
                    //     //
                    //     //     DCustomText(
                    //     //       text: item.description,
                    //     //       isSelected: isSelected,
                    //     //       showSeeMore: true,
                    //     //     ),
                    //     //
                    //     //
                    //     //     if (item.image.isNotEmpty) ...[
                    //     //       const SizedBox(height: 5),
                    //     //       Container(
                    //     //         height: 150,
                    //     //         width: 140,
                    //     //         decoration: BoxDecoration(
                    //     //           borderRadius: BorderRadius.circular(12), // Adjust the border radius as needed
                    //     //           border: Border.all(
                    //     //             color: Colors.blue, // Set the border color
                    //     //             width: 2, // Set the border width
                    //     //           ),
                    //     //           shape: BoxShape.rectangle, // Can be BoxShape.circle for circular images
                    //     //         ),
                    //     //         child: ClipRRect(
                    //     //           borderRadius: BorderRadius.circular(12), // Match the border radius here
                    //     //           child: Image.file(
                    //     //             File(item.image),
                    //     //             fit: BoxFit.cover,
                    //     //           ),
                    //     //         ),
                    //     //       ),
                    //     //     ],
                    //     //
                    //     //   ],
                    //     // ),
                    //     // trailing: Container(
                    //     //   child: Column(
                    //     //     children: [
                    //     //       Text(formattedDate),
                    //     //       Row(
                    //     //         mainAxisSize: MainAxisSize.min,
                    //     //         children: [
                    //     //
                    //     //           IconButton(
                    //     //             onPressed: () {
                    //     //               context.read<ToDoAppBloc>().add(FavouriteItem(item: item));
                    //     //             },
                    //     //             icon: Icon(
                    //     //               item.isFavourite ? Icons.favorite : Icons.favorite_outline,
                    //     //               color: Colors.amberAccent,
                    //     //               size: 30,
                    //     //             ),
                    //     //           ),
                    //     //           const SizedBox(width: 15),
                    //     //           CustomIconButton(
                    //     //             icon: Icons.delete,
                    //     //             color: Colors.red,
                    //     //             onPressed: () {
                    //     //               _showHideConfirmationDialog(context, item.id, item.value);
                    //     //             },
                    //     //           ),
                    //     //         ],
                    //     //       ),
                    //     //     ],
                    //     //   ),
                    //     // ),
                    //   ),
                    // );
                    return Card(
                      color: Colors.grey[900],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      context.read<ToDoAppBloc>().add(SelectItem(item: item));
                                    } else {
                                      context.read<ToDoAppBloc>().add(UnSelectItem(item: item));
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: item.value,
                                            isSelected: isSelected,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      DCustomText(
                                        text: item.description,
                                        isSelected: isSelected,
                                        showSeeMore: true,
                                      ),
                                      if (item.image.isNotEmpty) ...[
                                        const SizedBox(height: 5),
                                        Image_Design(item: item),
                                      ],
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context.read<ToDoAppBloc>().add(FavouriteItem(item: item));
                                          },
                                          icon: Icon(
                                            item.isFavourite ? Icons.favorite : Icons.favorite_outline,
                                            color: Colors.amberAccent,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        CustomIconButton(
                                          icon: Icons.delete,
                                          color: Colors.red,
                                          onPressed: () {
                                            _showHideConfirmationDialog(context, item.id, item.value);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 10.0,
                            right: 15.0,
                            child: Text(
                              formattedDate,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                  },
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Scaffold(
          appBar: _selectedIndex == 0
              ? AppBar(
            title: const Text(
              'TODO APP',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            centerTitle: true,
          )
              : null,
          drawer: ToDo_Drawer(onItemTapped: _onItemTapped),
          body: BlocConsumer<ToDoAppBloc, TodoappState>(
            listener: (context, state) {
              if (state.listStatus == ListStatus.failure && state.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return _getBody();
            },
          ),
          floatingActionButton: const FloatingActionButtonWidget(),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.amber[200], size: 35),
                activeIcon: Icon(Icons.home, color: Colors.amber[600], size: 35),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, color: Colors.amber[200], size: 35),
                activeIcon: Icon(Icons.favorite, color: Colors.amber[600], size: 35),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box, color: Colors.amber[200], size: 35),
                activeIcon: Icon(Icons.check_box, color: Colors.amber[600], size: 35),
                label: 'Completed Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restore_from_trash, color: Colors.amber[200], size: 35),
                activeIcon: Icon(Icons.restore_from_trash, color: Colors.amber[600], size: 35),
                label: 'RecycleBin',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _showHideConfirmationDialog(BuildContext context, String taskId, String taskValue) {
    final currentDate = DateTime.now();
    showConfirmationDialog(
      context: context,
      title: 'Confirm Delete',
      content: 'Are you sure you want to delete?',
      onConfirm: () {
        context.read<ToDoAppBloc>().add(
            HideItem(id: taskId, value: taskValue, description: '', date: currentDate));
      },
    );
  }
}

class Image_Design extends StatelessWidget {
  const Image_Design({
    super.key,
    required this.item,
  });

  final TodoTaskModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        shape: BoxShape.rectangle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(item.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
