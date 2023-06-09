import 'pokemon.dart';

class Pokemons {
  List<Pokemon>? pokemons;
  bool? canLoadNext;

  Pokemons({
    this.pokemons,
    this.canLoadNext,
  });

  factory Pokemons.fromJson(Map<String, dynamic> json) => Pokemons(
        pokemons: (json['results'] as List)
            .map((pokemon) => Pokemon.fromJson(pokemon))
            .toList(),
        canLoadNext: json["next"] != null,
      );
}
