import 'dart:async';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/Todo.dart';
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
      final Stream<SubscriptionEvent<Todo>> todoStream = todoRepository.watch();

      todoStream.listen((_) => add(TodoFetched()));
    } catch (e) {
      emit(TodoFetchFailure(message: e));
    }
  }

  FutureOr<void> _todoFetched(TodoFetched event, Emitter emit) async {
    if (state is TodoFetchSuccess == false) emit(TodoLoading());

    try {
      List<Todo> todos = await todoRepository.fetch();

      emit(TodoFetchSuccess(todos: todos));
    } catch (e) {
      emit(TodoFetchFailure(message: e));
    }
  }

  FutureOr<void> _todoCreated(TodoCreated event, Emitter emit) async {
    try {
      await todoRepository.create(event.title);
    } catch (e) {
      emit(TodoCreateFailure(message: e));
    }
  }

  FutureOr<void> _todoUpdated(TodoUpdated event, Emitter emit) async {
    try {
      await todoRepository.update(event.todo, event.isComplete);
    } catch (e) {
      emit(TodoUpdateFailure(message: e));
    }
  }
}
