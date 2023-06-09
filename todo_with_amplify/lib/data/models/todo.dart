class Todo {
  String id;
  String title;
  bool isComplete;

  Todo({
    required this.id,
    required this.title,
    required this.isComplete,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        title: json['title'],
        isComplete: json['isComplete'],
      );
}
