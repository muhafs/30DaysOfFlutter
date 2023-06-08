import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post.dart';
import '../../data/services/data_service.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final DataService _dataService = DataService();

  PostBloc() : super(PostFetchInProgress()) {
    on<PostFetched>((event, emit) async {
      try {
        List<Post> posts = await _dataService.fetchPosts();

        emit(PostFetchSuccess(posts: posts));
      } catch (e) {
        emit(PostFetchFailure(message: e));
      }
    });
  }
}
