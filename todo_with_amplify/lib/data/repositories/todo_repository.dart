import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/Todo.dart';

class TodoRepository {
  final DataStoreCategory db = Amplify.DataStore;

  Future<List<Todo>> fetch() async {
    try {
      List<Todo> todos = await db.query(Todo.classType);

      // ignore: avoid_print
      print(todos);

      return todos;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> create(String title) async {
    final todo = Todo(title: title, isComplete: false);

    try {
      await db.save(todo);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(Todo todo, bool isComplete) async {
    final updatedTodo = todo.copyWith(isComplete: isComplete);

    try {
      await db.save(updatedTodo);
    } catch (e) {
      rethrow;
    }
  }

  Stream<SubscriptionEvent<Todo>> watch() {
    return db.observe(Todo.classType);
  }
}
