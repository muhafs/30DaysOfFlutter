import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/post_bloc.dart';
import 'view/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc()..add(PostFetched()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Upgrade To Bloc',
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
