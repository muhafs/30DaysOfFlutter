part of 'todo_bloc.dart';

abstract class TodoEvent {}

class TodoFetched extends TodoEvent {}

class TodoCreated extends TodoEvent {}

class TodoUpdated extends TodoEvent {}

class TodoDeleted extends TodoEvent {}
