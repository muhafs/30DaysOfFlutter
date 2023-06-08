import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemons.dart';

class PokemonRepo {
  final String baseUrl = 'pokeapi.co';

  Future<Pokemons> fetchPokemon(int limitPage, int pageNumber) async {
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
}
