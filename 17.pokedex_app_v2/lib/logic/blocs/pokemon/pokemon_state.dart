// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_bloc.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonFetchInProgress extends PokemonState {}

class PokemonFetchSuccess extends PokemonState {
  List<Pokemon>? pokemons;
  bool? canLoadNext;

  PokemonFetchSuccess({
    required this.pokemons,
    required this.canLoadNext,
  });
}

class PokemonFetchFailure extends PokemonState {
  final Object message;

  PokemonFetchFailure({
    required this.message,
  });
}
