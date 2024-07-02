import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/view/login_screen/login_screen.dart';
import 'package:todoapptask/view/todo_app_screen/favoruite_item_screen.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../todo_app_widget/button_widget.dart';
import '../todo_app_widget/drawer_widget.dart';


class ToDoAppScreen extends StatefulWidget {
  const ToDoAppScreen({super.key});

  @override
  State<ToDoAppScreen> createState() => _ToDoAppScreenState();
}

class _ToDoAppScreenState extends State<ToDoAppScreen> {
  int _selectedIndex = 0; // Define _selectedIndex here

  @override
  void initState() {
    super.initState();
    context.read<ToDoAppBloc>().add(FetchTaskList());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update _selectedIndex here
    });

    if (index == 0) {
      // Navigate to the HiddenTasksScreen when "RecycleBin" tab is tapped
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ToDoAppScreen(),
        ),
      );
    }

    if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>const NewLoginScreen(),
        ),
      );
    }
    if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FavouriteScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12),
        child: Scaffold(
          appBar: AppBar(
            title:const Text(
              'TODO APP',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            centerTitle: true,
            // actions: const [
            //   DeleteButtonWidget(), // Include DeleteButtonWidget here
            // ],
          ),
          drawer:const ToDo_Drawer(),
          body: BlocBuilder<ToDoAppBloc, TodoappState>(
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
                      return Card(
                        color: Colors.grey[900], // Dark background color
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: state.FavouriteList.contains(item),
                            onChanged: (bool? value) {
                              if (value == true) {
                                context.read<ToDoAppBloc>().add(SelectItem(item: item));
                              } else {
                                context.read<ToDoAppBloc>().add(UnSelectItem(item: item));
                              }
                            },
                          ),
                          title: Text(
                            item.value,
                            style: TextStyle(
                              decoration: state.FavouriteList.contains(item)
                                  ? TextDecoration.none
                                  : TextDecoration.none,
                              color: state.FavouriteList.contains(item)
                                  ? Colors.red
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.read<ToDoAppBloc>().add(FavouriteItem(item: item));
                                },
                                icon: Icon(
                                  item.isFavourite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Colors.amberAccent,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),

                              IconButton(
                                icon:const Icon(Icons.delete, color: Colors.red,
                                size: 30,),
                                onPressed: () {
                                  _showHideConfirmationDialog(context, item.id, item.value);

                                  //context.read<ToDoAppBloc>().add(HideItem(id: item.id, value: item.value));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
              }
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
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.delete_outline, color: Colors.amber[200], size: 35),
              //   activeIcon: Icon(Icons.delete_outline, color: Colors.amber[600], size: 35),
              //   label: 'RecycleBin',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout, color: Colors.amber[200], size: 35),
                activeIcon: Icon(Icons.logout, color: Colors.amber[600], size: 35),
                label: 'Logout',
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ToDoAppBloc>().add(HideItem(id: taskId, value: taskValue));
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}



