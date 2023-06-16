import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/todo_repository.dart';
import '../logic/bloc/todo/todo_bloc.dart';
import '../logic/cubit/auth/auth_cubit.dart';
import 'pages/auth_page.dart';
import 'pages/home_page.dart';
import 'pages/loading_page.dart';

class AppNavigator extends StatelessWidget {
  final TodoRepository todoRepository = TodoRepository();

  AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is AuthUknown) const MaterialPage(child: LoadingPage()),
            if (state is Authenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => TodoBloc(
                      todoRepository: todoRepository, userId: state.userId)
                    ..add(TodoFetched())
                    ..add(TodoWatched()),
                  child: const HomePage(),
                ),
              ),
            if (state is Unauthenticated) const MaterialPage(child: AuthPage()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   final TodoRepository todoRepository = TodoRepository();

  //   switch (settings.name) {
  //     case LoadingPage.id:
  //       return MaterialPageRoute(builder: (context) => const LoadingPage());
  //     case AuthPage.id:
  //       return MaterialPageRoute(builder: (context) => const AuthPage());
  //     case HomePage.id:
  //       return MaterialPageRoute(
  //         builder: (context) => BlocProvider(
  //           create: (context) =>
  //               TodoBloc(todoRepository: todoRepository, userId: )
  //                 ..add(TodoFetched())
  //                 ..add(TodoWatched()),
  //           child: const HomePage(),
  //         ),
  //       );
  //     default:
  //       return MaterialPageRoute(
  //         builder: (context) => Scaffold(
  //           body: Center(
  //             child: Text('No route defined for ${settings.name}'),
  //           ),
  //         ),
  //       );
  //   }
  // }
}
