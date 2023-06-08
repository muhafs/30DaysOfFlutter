import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post.dart';
import '../../data/services/data_service.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final DataService _dataService = DataService();

  PostCubit() : super(PostInitial()) {
    getPosts();
  }

  void getPosts() async {
    try {
      emit(PostInitial());

      List<Post> posts = await _dataService.getPosts();

      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostLoadFailed());
    }
  }
}
