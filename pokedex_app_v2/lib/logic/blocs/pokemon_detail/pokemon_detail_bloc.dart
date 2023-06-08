import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/pokemon_detail.dart';
import '../../../data/repositories/pokemon_repo.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final PokemonRepo _pokemonRepo = PokemonRepo();

  PokemonDetailBloc() : super(PokemonDetailInitial()) {
    on<PokemonDetailFetched>(_pokemonDetailFetched);
  }

  FutureOr<void> _pokemonDetailFetched(
      PokemonDetailFetched event, Emitter emit) async {
    emit(PokemonDetailFetchInProgress());

    try {
      PokemonDetail pokemonDetail =
          await _pokemonRepo.fetchPokemonDetail(event.id);

      emit(PokemonDetailFetchSuccess(pokemonDetail: pokemonDetail));
    } catch (e) {
      emit(PokemonDetailFetchFailure(message: e));
    }
  }
}
