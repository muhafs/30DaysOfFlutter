// import 'dart:convert';

// import 'package:http/http.dart' as http;

// void main() {
//   Future<dynamic> fetchPokemonDetail(int pokemonId) async {
//     final Uri url = Uri.https('pokeapi.co', '/api/v2/pokemon/$pokemonId');

//     try {
//       var response = await http.get(url);

//       var data = json.decode(response.body);

//       print(data);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   fetchPokemonDetail(132);
// }
