// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoEvent {}

class TodoFetched extends TodoEvent {}

class TodoCreated extends TodoEvent {
  final String title;

  TodoCreated({
    required this.title,
  });
}

class TodoUpdated extends TodoEvent {
  Todo todo;
  bool isComplete;

  TodoUpdated({
    required this.todo,
    required this.isComplete,
  });
}

class TodoDeleted extends TodoEvent {}
