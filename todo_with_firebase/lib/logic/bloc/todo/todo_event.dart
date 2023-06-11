// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoEvent {}

class TodoFetched extends TodoEvent {}

class TodoCreated extends TodoEvent {
  final String title;
  final bool isComplete;

  TodoCreated({
    required this.title,
    required this.isComplete,
  });
}

class TodoUpdated extends TodoEvent {}

class TodoDeleted extends TodoEvent {}
