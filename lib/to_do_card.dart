import 'package:todo/to_do_data.dart';
import 'package:flutter/material.dart';
import 'constants/app_color.dart';

class ToDoCard extends StatelessWidget {
  final ToDoData data;
  final Function() delete;
  final Function() onTap;
  const ToDoCard({
    Key? key,
    required this.data,
    required this.delete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          data.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: purpleCR,
          size: 27.5,
        ),
        tileColor: whiteCR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          data.task!,
          style: TextStyle(
              decoration: data.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          margin: EdgeInsets.only(right: 8),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: redCR,
          ),
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: delete,
            color: whiteCR,
            iconSize: 20,
          ),
        ),
      ),
    );
  }
}
