import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';
import '../todo_app_widget/drawer_widget.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finished Task',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),),
          centerTitle: true,
        ),
      
        drawer:const ToDo_Drawer(),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: BlocBuilder<ToDoAppBloc, TodoappState>(
            builder: (context, state) {
              if (state.selectedList.isEmpty) {
                return const Center(child: Text('No completed task yet'));
              }
              return ListView.builder(
                itemCount: state.selectedList.length,
                itemBuilder: (context, index) {
                  final item = state.selectedList[index];
                  return Card(
                    color: Colors.grey[800],
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(item.value,style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
