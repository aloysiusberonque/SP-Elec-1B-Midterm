import 'package:flutter/material.dart';

// Relative path
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Create a variable todosList to iterate the values in the List<ToDo>
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    // Assign the default values of List<ToDo> in todosList to _foundToDo to serve as the default value on initial state
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Render ToDoItem inside a forloop
                      // The right todo in ToDoItem is the todo inside Todo which we are getting from the list
                      // While the left todo in ToDoItem is from todo_item.dart where it is expected

                      // for (ToDo todo in todosList)
                      //   ToDoItem(
                      //     todo: todo,
                      //     onToDoChanged: _handleToDoChange,
                      //     onDeleteItem: _deleteToDoItem,
                      //   ),

                      // Instead of rendering the values from todosList, we now would then render from _foundToDo
                      // The purpose of .reversed is to reverse the list so that everytime we add, items added will be on top
                      for (ToDo todo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
                // Adding of todo items container
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      // Textfield Container
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(bottom: 20, right: 20, left: 0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(85, 158, 158, 158),
                                offset: Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.0)
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                              hintText: 'Add a new todo item',
                              border: InputBorder.none),
                        ),
                      )),
                      // Button Container
                      Container(
                        margin: EdgeInsets.only(bottom: 20, right: 0),
                        child: ElevatedButton(
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          onPressed: () {
                            // To make sure that it does not accept empty values
                            if (_todoController.text.isNotEmpty) {
                              _addToDoItem(_todoController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: tdBlue,
                            minimumSize: Size(60, 60),
                            elevation: 10,
                            shadowColor: Color.fromARGB(85, 158, 158, 158),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ]));
  }

  void _handleToDoChange(ToDo todo) {
    // To see the changes, we need to put it in a setState
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    // To see the changes, we need to put it in a setState
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    // List with the type of ToDo
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      // Inside todosList, it will check for the todoText and check if it contains the enteredKeyword, then convert it to List since results is a List type
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        // Detect every keystroke and then run the _runFilter function
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        // Allow icon to be in the right side
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpg'),
            ),
          )
        ],
      ),
    );
  }
}
