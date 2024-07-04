import 'package:flutter/material.dart';

import '../../model/todo_task_model.dart';



class Card_Widget extends StatelessWidget {
  const Card_Widget({
    super.key,
    required this.item,
    //required this.title,
  });



  final TodoTaskModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text_Widget(item: item),
      ),
    );
  }
}


class Text_Widget extends StatelessWidget {
  const Text_Widget({
    super.key,
    required this.item,
  });

  final TodoTaskModel item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.value,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
