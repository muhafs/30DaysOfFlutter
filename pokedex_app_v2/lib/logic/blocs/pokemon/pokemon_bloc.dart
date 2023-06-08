import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/pokemon.dart';
import '../../../data/models/pokemons.dart';
import '../../../data/repositories/pokemon_repo.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepo _pokemonRepo = PokemonRepo();

  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonFetched>(_pokemonFetched);
  }

  FutureOr<void> _pokemonFetched(PokemonFetched event, Emitter emit) async {
    emit(PokemonFetchInProgress());

    try {
      Pokemons response = await _pokemonRepo.fetchPokemonList(
        event.limit,
        event.page,
      );

      emit(PokemonFetchSuccess(
        pokemons: response.pokemons,
        canLoadNext: response.canLoadNext,
      ));
    } catch (e) {
      emit(PokemonFetchFailure(message: e));
    }
  }
}
