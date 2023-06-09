// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_detail_bloc.dart';

abstract class PokemonDetailState {}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailFetchInProgress extends PokemonDetailState {}

class PokemonDetailFetchSuccess extends PokemonDetailState {
  PokemonDetail pokemonDetail;

  PokemonDetailFetchSuccess({
    required this.pokemonDetail,
  });
}

class PokemonDetailFetchFailure extends PokemonDetailState {
  Object message;

  PokemonDetailFetchFailure({
    required this.message,
  });
}
