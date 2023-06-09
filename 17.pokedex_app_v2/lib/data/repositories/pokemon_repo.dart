import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon_detail.dart';
import '../models/pokemons.dart';

class PokemonRepo {
  final String baseUrl = 'pokeapi.co';

  Future<Pokemons> fetchPokemonList(int limitPage, int pageNumber) async {
    final Uri url = Uri.https(baseUrl, '/api/v2/pokemon', {
      'limit': limitPage.toString(),
      'offset': (pageNumber * limitPage).toString(),
    });

    try {
      var response = await http.get(url);

      var data = json.decode(response.body);

      return Pokemons.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(int pokemonId) async {
    final Uri pokemonUrl = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');
    final Uri pokemonSpeciesUrl =
        Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');

    try {
      var responses = await Future.wait([
        http.get(pokemonUrl),
        http.get(pokemonSpeciesUrl),
      ]);

      Map<String, dynamic> data = {}
        ..addAll(json.decode(responses[0].body))
        ..addAll(json.decode(responses[1].body));

      return PokemonDetail.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<dynamic> fetchPokemonSpeciesDetail(int pokemonId) async {
  //   final Uri url = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');

  //   try {
  //     var response = await http.get(url);

  //     var data = json.decode(response.body);

  //     print(data);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
