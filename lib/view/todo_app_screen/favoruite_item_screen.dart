import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../todo_app_widget/drawer_widget.dart';

class FavouriteScreen extends StatelessWidget {
 // const FavouriteScreen({super.key});
  final ValueChanged<int> onItemTapped;

  const FavouriteScreen({super.key, required this.onItemTapped});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Favorite Item',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          drawer:  ToDo_Drawer(onItemTapped: onItemTapped),
          body: Padding(

            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: BlocBuilder<ToDoAppBloc, TodoappState>(
              builder: (context, state) {
                if (state.listStatus == ListStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.listStatus == ListStatus.failure) {
                  return const Center(child: Text('Failed to load tasks'));
                } else if (state.favouriteList.isEmpty) {
                  return const Center(child: Text('No favorite items'));
                } else {
                  return ListView.builder(
                    itemCount: state.favouriteList.length,
                    itemBuilder: (context, index) {
                      final item = state.favouriteList[index];
                      return Card(
                        color: Colors.grey[800],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            item.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
