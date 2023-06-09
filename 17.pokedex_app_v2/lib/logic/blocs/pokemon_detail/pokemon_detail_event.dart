// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_detail_bloc.dart';

abstract class PokemonDetailEvent {}

class PokemonDetailFetched extends PokemonDetailEvent {
  final int id;

  PokemonDetailFetched({
    required this.id,
  });
}
