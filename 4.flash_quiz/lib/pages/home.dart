import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/card_face.dart';
import '../components/card_switcher.dart';
import '../providers/quiz_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Quiz'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _QuizFlash(),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardSwitcher(
                      onPressed: context.read<QuizProvider>().prevCard,
                      text: 'Prev'),
                  CardSwitcher(
                      onPressed: context.read<QuizProvider>().nextCard,
                      text: 'Next'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _QuizFlash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QuizProvider provider = context.watch<QuizProvider>();

    return FlashCard(
      key: const Key('1'),
      backWidget: CardFace(
        text: provider.quizes[provider.currIdx].question,
        front: true,
      ),
      frontWidget: CardFace(
        text: provider.quizes[provider.currIdx].answer,
      ),
    );
  }
}
