// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

abstract class PostState {}

class PostFetchInProgress extends PostState {}

class PostFetchSuccess extends PostState {
  List<Post> posts;

  PostFetchSuccess({
    required this.posts,
  });
}

class PostFetchFailure extends PostState {
  Object message;

  PostFetchFailure({
    required this.message,
  });
}
