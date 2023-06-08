// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_bloc.dart';

abstract class PokemonEvent {}

class PokemonFetched extends PokemonEvent {
  final int limit;
  final int page;

  PokemonFetched({
    required this.limit,
    required this.page,
  });
}
