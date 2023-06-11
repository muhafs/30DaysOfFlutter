// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoState {}

abstract class TodoFailure extends TodoState {
  Object message;
  TodoFailure({
    required this.message,
  });
}

class TodoInitial extends TodoState {}

// ! Loading
class TodoLoading extends TodoState {}

// ! Fetch
class TodoFetchSuccess extends TodoState {
  List<Todo> todos;

  TodoFetchSuccess({
    required this.todos,
  });
}

class TodoFetchFailure extends TodoFailure {
  TodoFetchFailure({required super.message});
}

// ! Create
class TodoCreateSuccess extends TodoState {}

class TodoCreateFailure extends TodoFailure {
  TodoCreateFailure({required super.message});
}

// ! Update
class TodoUpdateSuccess extends TodoState {}

class TodoUpdateFailure extends TodoFailure {
  TodoUpdateFailure({required super.message});
}
