// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoFetchInProgress extends TodoState {}

class TodoFetchSuccess extends TodoState {
  List<Todo> todos;

  TodoFetchSuccess({
    required this.todos,
  });
}

class TodoFetchFailure extends TodoState {
  Object message;
  TodoFetchFailure({
    required this.message,
  });
}
