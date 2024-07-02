import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapptask/view/login_screen/login_screen.dart';
import 'package:todoapptask/view/todo_app_screen/task_add_screen.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../todo_app_widget/delete_button_widget.dart';
import '../todo_app_widget/drawer_widget.dart';


class ToDoAppScreen extends StatefulWidget {
  const ToDoAppScreen({Key? key}) : super(key: key);

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

    if (index == 3) {
      // Navigate to the HiddenTasksScreen when "RecyleBin" tab is tapped
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>const NewLoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const Text(
            'TODO APP',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 35,
            ),
          ),
          centerTitle: true,
          actions: const [
            DeleteButtonWidget(), // Include DeleteButtonWidget here
          ],
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
                  itemCount: state.favouriteItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.favouriteItemList[index];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: state.tempFavouriteList.contains(item),
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
                            decoration: state.tempFavouriteList.contains(item)
                                ? TextDecoration.none
                                : TextDecoration.none,
                            color: state.tempFavouriteList.contains(item)
                                ? Colors.red
                                : Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
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
                                size: 35,
                              ),
                            ),
                            IconButton(
                              icon:const Icon(Icons.delete, color: Colors.red,
                              size: 35,),
                              onPressed: () {
                                context.read<ToDoAppBloc>().add(HideItem(id: item.id, value: item.value));
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child:const Icon(
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
        ),
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
            //   label: 'RecyleBin',
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
    );
  }
}

