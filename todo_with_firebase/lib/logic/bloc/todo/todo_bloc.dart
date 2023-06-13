import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/todo.dart';
import '../../../data/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<TodoFetched>(_todoFetched);

    on<TodoCreated>(_todoCreated);

    on<TodoUpdated>(_todoUpdated);
  }

  FutureOr<void> _todoFetched(TodoFetched event, Emitter emit) async {
    emit(TodoFetchInProgress());

    try {
      List<Todo> todos = await todoRepository.get();

      emit(TodoFetchSuccess(todos: todos));
    } catch (e) {
      emit(TodoFetchFailure(message: e.toString()));
    }
  }

  FutureOr<void> _todoCreated(TodoCreated event, Emitter emit) async {
    emit(TodoFetchInProgress());

    try {
      await todoRepository.create(event.title);

      add(TodoFetched());
    } catch (e) {
      emit(TodoFetchFailure(message: e.toString()));
    }
  }

  FutureOr<void> _todoUpdated(TodoUpdated event, Emitter emit) async {
    emit(TodoFetchInProgress());

    try {
      await todoRepository.update(event.todo, event.isComplete);

      add(TodoFetched());
    } catch (e) {
      emit(TodoFetchFailure(message: e.toString()));
    }
  }
}
