import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/auth/auth_cubit.dart';

class AuthPage extends StatelessWidget {
  static const String id = 'authPage';

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthCubit>().signIn();
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}
