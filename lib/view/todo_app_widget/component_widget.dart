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
        color: isSelected ? Colors.red : Colors.amber.shade800,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}





class DCustomText extends StatefulWidget {
  final String text;
  final bool isSelected;

  const DCustomText({
    required this.text,
    this.isSelected = false,
  });

  @override
  _DCustomTextState createState() => _DCustomTextState();
}

class _DCustomTextState extends State<DCustomText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<String> words = widget.text.split(' ');
    String displayText = words.take(2).join(' '); // Display first two words initially

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isExpanded ? widget.text : displayText,
          style: TextStyle(
            color: widget.isSelected ? Colors.amber.shade100 : Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (words.length > 2) // Display 'See more' button if more than two words
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'See less' : 'See more',
              style: TextStyle(color: Colors.blue),
            ),
          ),
      ],
    );
  }
}





