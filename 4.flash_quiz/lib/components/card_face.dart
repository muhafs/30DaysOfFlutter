import 'package:flutter/material.dart';

class CardFace extends StatelessWidget {
  const CardFace({super.key, required this.text, this.front = false});

  final String text;
  final bool front;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (front)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Quiz',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
