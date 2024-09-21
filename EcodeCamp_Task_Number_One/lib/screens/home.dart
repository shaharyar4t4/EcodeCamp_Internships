import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import '../model/Todo.dart';
import '../widgets/toItem.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final todolist = Todo.todolist();
  List<Todo> _foundToDo = [];
  final todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundToDo = todolist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGcolor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "To Do",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                      for (Todo todoo in _foundToDo.reversed)
                        toItem(
                          todo: todoo,
                          onTodoChange: _handleToDo,
                          onTodoDelete: _deleteToDo,
                          onTodoEdit: _showEditDialog, // Add this line
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new Task',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addlist(todoController.text);
                    },
                    child: Text(
                      '>',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdblue,
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGcolor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,

          ),
          Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                child: Image.asset('assets/image/logo.png'),
                borderRadius: BorderRadius.circular(20),
              ))
        ],
      ),
    );
  }

  // Search
  void Filter(String enterkey) {
    List<Todo> result = [];
    if (enterkey.isEmpty) {
      result = todolist;
    } else {
      result = todolist
          .where((item) =>
          item.todoText!.toLowerCase().contains(enterkey.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }

  // Is done or not
  void _handleToDo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  // For delete
  void _deleteToDo(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  void _addlist(String todo) {
    setState(() {
      todolist.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });

    todoController.clear();
  }

  // For updating a todo item
  void _updateToDo(String id, String newText) {
    setState(() {
      var todo = todolist.firstWhere((item) => item.id == id);
      todo.todoText = newText;
    });
  }

  // Show dialog for editing todo
  void _showEditDialog(Todo todo) {
    TextEditingController editController = TextEditingController(text: todo.todoText);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update List", ),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              label: Text("Update your List"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _updateToDo(todo.id, editController.text);
                Navigator.of(context).pop();
              },
              child: Text("Update", style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
              backgroundColor: tdblue,
              elevation: 10,
            ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => Filter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdblack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdgrey),
        ),
      ),
    );
  }
}
