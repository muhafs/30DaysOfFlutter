part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthUknown extends AuthState {}

class Authenticated extends AuthState {
  final String userId;

  Authenticated({required this.userId});
}

class Unauthenticated extends AuthState {}
