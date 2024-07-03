import 'package:flutter/material.dart';
import 'package:todoapptask/view/todo_app_screen/complete_task_screen.dart';
import 'package:todoapptask/view/todo_app_screen/favoruite_item_screen.dart';
import 'package:todoapptask/view/todo_app_screen/todo_app_screen.dart';

import '../todo_app_screen/deleted_item_screen.dart';
import '../todo_app_screen/home_screen.dart';

class ToDo_Drawer extends StatelessWidget {
  const ToDo_Drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.white.withOpacity(.12),
          child: ListView(
            padding: const EdgeInsets.only(right: 10,top: 8,),
            children: <Widget>[
               SizedBox(
                height: 90,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.amber[900],
                    borderRadius: BorderRadius.circular(13)
                  ),
                  child: const Text(
                    'ToDo App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.black26,
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ToDoAppScreen(),
                      ),
                    );
                    // Navigate to home screen or handle logic here
                  },
                ),
              ),
              Card(
                color: Colors.black26,
                child: ListTile(
                  leading: const Icon(Icons.favorite),
                  title:const Text('Favourite',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FavouriteScreen(),
                      ),
                    );
                    // Navigate to favourite screen or handle logic here
                  },
                ),
              ),
              Card(
                color: Colors.black26,
                child: ListTile(
                  leading: const Icon(Icons.check_box),
                  title:const Text('Complete Task',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CompleteTasksScreen(),
                      ),
                    );
                    // Navigate to favourite screen or handle logic here
                  },
                ),
              ),
              Card(
                color: Colors.black26,
                child: ListTile(
                  leading:const Icon(Icons.restore_from_trash),
                  title:const Text('Recyclebin',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DeletedItemScreen(),
                      ),
                    );
                    // Navigate to favourite screen or handle logic here
                  },
                ),
              ),
              SizedBox(height: 10,),
              Card(
                child: ListTile(
                  leading:const Icon(Icons.logout),
                  title:const Text('Logout',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    // Implement logout logic here
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
