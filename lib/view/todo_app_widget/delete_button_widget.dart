import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/todoappbloc/todoapp_bloc.dart';
import '../../bloc/todoappbloc/todoapp_event.dart';
import '../../bloc/todoappbloc/todoapp_state.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoAppBloc, TodoappState>(
      buildWhen: (previous, current) =>  previous.tempFavouriteList != current.tempFavouriteList,
      builder: (context, state) {
        return Visibility(
            visible: state.tempFavouriteList.isNotEmpty ?  true : false ,
            child: IconButton(onPressed: () {
              context.read<ToDoAppBloc>().add(DeleteItem());
            },
                icon: const Icon(
                  Icons.delete_outline ,
                  color: Colors.red,
                  size: 35,))
        );
      },
    );
  }
}