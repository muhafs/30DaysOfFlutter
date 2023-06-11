import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/Todo.dart';
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
    emit(TodoLoading());

    try {
      List<Todo> todos = await todoRepository.fetch();

      emit(TodoFetchSuccess(todos: todos));
    } catch (e) {
      emit(TodoFetchFailure(message: e));
    }
  }

  FutureOr<void> _todoCreated(TodoCreated event, Emitter emit) async {
    emit(TodoLoading());

    try {
      await todoRepository.create(event.title);

      add(TodoFetched());
    } catch (e) {
      emit(TodoCreateFailure(message: e));
    }
  }

  FutureOr<void> _todoUpdated(TodoUpdated event, Emitter emit) async {
    emit(TodoLoading());

    try {
      await todoRepository.update(event.todo, event.isComplete);

      add(TodoFetched());
    } catch (e) {
      emit(TodoUpdateFailure(message: e));
    }
  }
}
