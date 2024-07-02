import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Items',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: BlocBuilder<ToDoAppBloc, TodoappState>(
        builder: (context, state) {
          if (state.listStatus == ListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.listStatus == ListStatus.failure) {
            return const Center(child: Text('Failed to load tasks'));
          } else if (state.FavouriteList.isEmpty) {
            return const Center(child: Text('No favorite items'));
          } else {
            return ListView.builder(
              itemCount: state.FavouriteList.length,
              itemBuilder: (context, index) {
                final item = state.FavouriteList[index];
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
                        fontSize: 20,
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
    );
  }
}
