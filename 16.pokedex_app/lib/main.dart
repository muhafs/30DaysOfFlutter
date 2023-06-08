import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/pokemon_bloc.dart';
import 'view/pages/detail_page.dart';
import 'view/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc()
        ..add(
          PokemonFetched(limit: 100, page: 0),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex App',
        theme: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.red,
            secondary: Colors.redAccent,
          ),
        ),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => const HomePage(),
          DetailPage.id: (context) => const DetailPage(),
        },
      ),
    );
  }
}
