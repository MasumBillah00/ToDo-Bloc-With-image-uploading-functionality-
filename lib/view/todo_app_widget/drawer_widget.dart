import 'package:flutter/material.dart';

import '../todo_app_screen/deleted_item_screen.dart';

class ToDo_Drawer extends StatelessWidget {
  const ToDo_Drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home',style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
            ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to home screen or handle logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favourite',style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
            ),),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to favourite screen or handle logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.restore_from_trash),
            title: Text('Recyclebin',style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
            ),),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HiddenTasksScreen(),
                ),
              );
              // Navigate to favourite screen or handle logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout',style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500
            ),),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Implement logout logic here
            },
          ),
        ],
      ),
    );
  }
}
