import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../login_registration/login_screen/login_screen.dart';

class ToDo_Drawer extends StatelessWidget {
  final ValueChanged<int> onItemTapped;

  const ToDo_Drawer({
    super.key,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.white.withOpacity(.12),
          child: ListView(
            padding: const EdgeInsets.only(
              right: 10,
              top: 8,
            ),
            children: <Widget>[
              SizedBox(
                height: 90,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.amber[900], borderRadius: BorderRadius.circular(13)),
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
                  title: const Text(
                    'Home',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    onItemTapped(0);
                    Navigator.of(context).pop(); // Close the drawer
                  },
                ),
              ),
              Card(
                color: Colors.black26,
                child: ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.amber[900],
                  ),
                  title: const Text(
                    'Favourite',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    onItemTapped(1);
                    Navigator.of(context).pop(); // Close the drawer
                  },
                ),
              ),
              Card(
                color: Colors.black26,
                child: ListTile(
                  leading: const Icon(Icons.check_box),
                  title: const Text(
                    'Complete Task',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    onItemTapped(2);
                    Navigator.of(context).pop(); // Close the drawer
                  },
                ),
              ),
              Card(
                color: Colors.black26,
                child: ListTile(
                  leading: const Icon(Icons.restore_from_trash),
                  title: const Text(
                    'Recyclebin',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    onItemTapped(3);
                    Navigator.of(context).pop(); // Close the drawer
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    context.read<LoginBloc>().add(Logout());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
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
