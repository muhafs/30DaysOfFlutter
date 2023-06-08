part of 'post_cubit.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  List<Post> posts;

  PostLoaded({required this.posts});
}

class PostLoadFailed extends PostState {}
