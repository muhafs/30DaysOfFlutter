import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static const String id = 'detailPage';

  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex App'),
        centerTitle: true,
      ),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}
