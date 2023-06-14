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
        Map<String, dynamic> data = {
          'id': todo.id,
          'title': todo.data()['title'],
          'isComplete': todo.data()['isComplete'],
        };

        todos.add(Todo.fromJson(data));
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

  Future<void> create(String title) async {
    try {
      await db.collection('todos').add({
        'title': title,
        'isComplete': false,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(
            'Failed with error: \nCode : ${e.code}. \nMessage: ${e.message}.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> update(Todo todo, bool isComplete) async {
    try {
      await db.collection('todos').doc(todo.id).update({
        'isComplete': isComplete,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(
            'Failed with error: \nCode : ${e.code}. \nMessage: ${e.message}.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watch() {
    return db.collection('todos').snapshots();
  }
}
