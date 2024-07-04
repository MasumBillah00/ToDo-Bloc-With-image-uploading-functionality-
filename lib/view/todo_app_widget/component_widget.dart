import 'package:flutter/material.dart';

import '../../model/todo_task_model.dart';



// class Card_Widget extends StatelessWidget {
//   const Card_Widget({
//     super.key,
//     required this.item,
//     //required this.title,
//   });
//
//
//
//   final TodoTaskModel item;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.grey[800],
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ListTile(
//         title: Text_Widget(item: item),
//       ),
//     );
//   }
// }



class CustomText extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CustomText({
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: isSelected ? Colors.red : Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

