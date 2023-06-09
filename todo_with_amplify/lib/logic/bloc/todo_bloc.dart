import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final db = FirebaseFirestore.instance;

  TodoBloc() : super(TodoInitial()) {
    on<TodoFetched>(_todoFetched);
  }

  FutureOr<void> _todoFetched(TodoFetched event, Emitter emit) async {
    emit(TodoFetchInProgress());

    try {
      var event = await db.collection("todos").get();

      emit(TodoFetchSuccess(todos: event.docs));
    } catch (e) {
      emit(TodoFetchFailure(message: e));
    }
  }
}
