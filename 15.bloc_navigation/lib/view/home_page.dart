import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/post.dart';
import '../logic/bloc/post_bloc.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  static const String id = 'homePage';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Navigation'),
        centerTitle: true,
      ),
      //! Cubit Starts
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          //! Cubit Initial
          if (state is PostFetchInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //! Cubit Loaded
          else if (state is PostFetchSuccess) {
            List<Post> posts = state.posts;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Post post = posts[index];

                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    DetailPage.id,
                    arguments: post,
                  ),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Center(
                          child: Text(post.id?.toString() ?? 'Error'),
                        ),
                      ),
                      title: Text(post.title ?? 'Error'),
                    ),
                  ),
                );
              },
            );
          }
          //! Cubit Error
          else if (state is PostFetchFailure) {
            return Center(
              child: Text(
                '${state.message}',
                textAlign: TextAlign.center,
              ),
            );
          }
          //! Else
          else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
