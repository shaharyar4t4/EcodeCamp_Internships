import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import '../model/Todo.dart';

class toItem extends StatelessWidget {
  final Todo todo;
  final Function onTodoChange;
  final Function onTodoDelete;
  final Function onTodoEdit;

  const toItem({
    super.key,
    required this.todo,
    required this.onTodoChange,
    required this.onTodoDelete,
    required this.onTodoEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdblue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdblack,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // To align buttons properly
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: tdblue,
              onPressed: () {
                onTodoEdit(todo); // Call the edit function
              },
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.white,
                iconSize: 18,
                onPressed: () {
                  onTodoDelete(todo.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
