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
}
