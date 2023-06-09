import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/pokemon.dart';
import '../../logic/blocs/pokemon/pokemon_bloc.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  static const String id = 'homePage';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex App'),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          // ! Loading
          if (state is PokemonFetchInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // ! Fetched
          else if (state is PokemonFetchSuccess) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.pokemons?.length ?? 0,
              itemBuilder: (context, index) {
                Pokemon? pokemon = state.pokemons?[index];
                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      Navigator.pushNamed(context, DetailPage.id,
                          arguments: pokemon!.id);
                    },
                    child: GridTile(
                      child: Column(
                        children: [
                          Image.network(pokemon?.imageUrl ?? ''),
                          Text(pokemon?.name ?? 'No Name'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          // ! Failed
          else if (state is PokemonFetchFailure) {
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
}
