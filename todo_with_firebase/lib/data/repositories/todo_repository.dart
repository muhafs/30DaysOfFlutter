import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/todo.dart';

class TodoRepository {
  final db = FirebaseFirestore.instance;

  Future<List<Todo>> get() async {
    List<Todo> todos = [];
    try {
      var td = await db.collection('todos').get();

      for (var todo in td.docs) {
        todos.add(Todo.fromJson(todo.data()));
      }

      return todos;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(
            'Failed with error: \nCode : ${e.code}. \nMessage: ${e.message}.');
      }

      return todos;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
