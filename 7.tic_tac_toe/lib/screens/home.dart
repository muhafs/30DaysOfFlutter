import 'package:flutter/material.dart';

import '../components/board_tile.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/board.png'),
          const BoardTile(),
        ],
      ),
    );
  }
}
