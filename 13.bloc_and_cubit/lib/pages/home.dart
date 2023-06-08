import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/post.dart';
import '../logic/cubit/post_cubit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc & Cubit'),
        centerTitle: true,
      ),
      //! Cubit Starts
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          //! Cubit Initial
          if (state is PostInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //! Cubit Loaded
          else if (state is PostLoaded) {
            List<Post> posts = state.posts;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Center(
                        child: Text(posts[index].id?.toString() ?? 'Error'),
                      ),
                    ),
                    title: Text(posts[index].title ?? 'Error'),
                  ),
                );
              },
            );
          }
          //! Cubit Error
          else if (state is PostLoadFailed) {
            return const Center(
              child:
                  Text('There is something went error, Please try again later'),
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
