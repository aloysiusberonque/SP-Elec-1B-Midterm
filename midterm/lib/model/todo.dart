class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

// Creation of array of items
  static List<ToDo> todoList() {
    return[
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Check Emails'),
      ToDo(id: '04', todoText: 'Check Emails'),
      ToDo(id: '05', todoText: 'Check Emails'),
      ToDo(id: '06', todoText: 'Attend birthday party'),
    ];
  }
}
