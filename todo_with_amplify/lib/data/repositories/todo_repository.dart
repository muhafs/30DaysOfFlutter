import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/Todo.dart';

class TodoRepository {
  final DataStoreCategory db = Amplify.DataStore;

  Future<List<Todo>> fetch(String userId) async {
    try {
      List<Todo> todos = await db.query(
        Todo.classType,
        where: Todo.USERID.eq(userId),
      );

      // ignore: avoid_print
      print(todos);

      return todos;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> create(String title, String userId) async {
    final todo = Todo(
      title: title,
      isComplete: false,
      userId: userId,
    );

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

  Stream<SubscriptionEvent<Todo>> watch(String userId) {
    return db.observe(
      Todo.classType,
      where: Todo.USERID.eq(userId),
    );
  }
}
