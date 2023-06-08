import 'package:flutter/material.dart';

import '../constants.dart';

class BoardItem extends StatelessWidget {
  const BoardItem({
    super.key,
    this.type = BoardTypes.e,
    required this.onPressed,
  });

  final BoardTypes type;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: type != BoardTypes.e
            ? Image.asset('assets/${type == BoardTypes.o ? 'o' : 'x'}.png')
            : const SizedBox(),
      ),
    );
  }
}
