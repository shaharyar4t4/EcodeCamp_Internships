class Todo {
  String id; // Make this non-nullable
  String todoText; // Make this non-nullable
  late bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todolist() {
    return [
      Todo(id: '01', todoText: 'Morning Walking', isDone: true),
      Todo(id: '02', todoText: 'Breakfast', isDone: true),
      Todo(id: '03', todoText: 'Going to University '),
      Todo(id: '04', todoText: 'Attend the Class'),
      Todo(id: '05', todoText: 'Back to Home'),
      Todo(id: '06', todoText: 'buy groceries'),
    ];
  }
}
