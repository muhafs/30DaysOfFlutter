import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/pokemon_detail.dart';
import '../../logic/blocs/pokemon_detail/pokemon_detail_bloc.dart';

class DetailPage extends StatelessWidget {
  static const String id = 'detailPage';

  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    int args = ModalRoute.of(context)?.settings.arguments as int;

    BlocProvider.of<PokemonDetailBloc>(context)
        .add(PokemonDetailFetched(id: args));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex App'),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
        builder: (context, state) {
          // ! Loading
          if (state is PokemonDetailFetchInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // ! Fetched
          else if (state is PokemonDetailFetchSuccess) {
            PokemonDetail pokemon = state.pokemonDetail;

            return Center(
              child: Center(
                  child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(pokemon.imgUrl),
                            Text(pokemon.name),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: pokemon.types
                                  .map((type) => _pokemonTypeView(type))
                                  .toList(),
                            ),
                            Text(
                                'ID: ${pokemon.id}  -  Weight: ${pokemon.weight}  -  Height: ${pokemon.height}')
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              pokemon.description.split('\n').join(' '),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ))
                ],
              )),
            );
          }
          // ! Failed
          else if (state is PokemonDetailFetchFailure) {
            return Center(
              child: Text(
                state.message.toString(),
                textAlign: TextAlign.center,
              ),
            );
          }
          // ! Other
          else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _pokemonTypeView(String type) {
    Color color;

    switch (type) {
      case 'normal':
        color = const Color(0xFFF9E65E);
        break;
      case 'poison':
        color = const Color(0xFF995E98);
        break;
      case 'psychic':
        color = const Color(0xFFE96EB0);
        break;
      case 'grass':
        color = const Color(0xFF9CD363);
        break;
      case 'ground':
        color = const Color(0xFFE3C969);
        break;
      case 'ice':
        color = const Color(0xFFAFF4FD);
        break;
      case 'fire':
        color = const Color(0xFFE7614D);
        break;
      case 'rock':
        color = const Color(0xFFCBBD7C);
        break;
      case 'dragon':
        color = const Color(0xFF8475F7);
        break;
      case 'water':
        color = const Color(0xFF6DACF8);
        break;
      case 'bug':
        color = const Color(0xFFC5D24A);
        break;
      case 'dark':
        color = const Color(0xFF886958);
        break;
      case 'fighting':
        color = const Color(0xFF9E5A4A);
        break;
      case 'ghost':
        color = const Color(0xFF7774CF);
        break;
      case 'steel':
        color = const Color(0xFFC3C3D9);
        break;
      case 'flying':
        color = const Color(0xFF81A2F8);
        break;
      case 'fairy':
        color = const Color(0xFFEEB0FA);
        break;
      default:
        color = Colors.black;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Text(
          type.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
