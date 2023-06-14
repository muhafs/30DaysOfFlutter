import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/todo.dart';
import '../../../data/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<TodoWatched>(_todoWatched);

    on<TodoFetched>(_todoFetched);

    on<TodoCreated>(_todoCreated);

    on<TodoUpdated>(_todoUpdated);
  }

  FutureOr<void> _todoWatched(TodoWatched event, Emitter emit) {
    try {
      final Stream<QuerySnapshot<Map<String, dynamic>>> todoStream =
          todoRepository.watch();

      todoStream.listen((_) => add(TodoFetched()));
    } catch (e) {
      emit(TodoFetchFailure(message: e));
    }
  }

  FutureOr<void> _todoFetched(TodoFetched event, Emitter emit) async {
    if (state is TodoFetchSuccess == false) emit(TodoFetchInProgress());

    try {
      List<Todo> todos = await todoRepository.get();

      emit(TodoFetchSuccess(todos: todos));
    } catch (e) {
      emit(TodoFetchFailure(message: e.toString()));
    }
  }

  FutureOr<void> _todoCreated(TodoCreated event, Emitter emit) async {
    try {
      await todoRepository.create(event.title);
    } catch (e) {
      emit(TodoFetchFailure(message: e.toString()));
    }
  }

  FutureOr<void> _todoUpdated(TodoUpdated event, Emitter emit) async {
    try {
      await todoRepository.update(event.todo, event.isComplete);
    } catch (e) {
      emit(TodoFetchFailure(message: e.toString()));
    }
  }
}
