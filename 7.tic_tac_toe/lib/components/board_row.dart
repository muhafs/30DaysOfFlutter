import 'package:flutter/material.dart';

import 'board_item.dart';

class BoardRow extends StatelessWidget {
  const BoardRow({
    super.key,
    required this.items,
  });

  final List<BoardItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items,
    );
  }
}
