import 'package:flutter/material.dart';
import '../models/quiz_model.dart';

class QuizProvider with ChangeNotifier {
  final List<Quiz> _quizes = [
    Quiz(
      question: 'What is Bloc stand for?',
      answer: 'Business Logic Compoent',
    ),
    Quiz(
      question: 'Which country is pizza from?',
      answer: 'Pizza is from Italy',
    ),
    Quiz(
      question: 'Who\'s the last Prophet?',
      answer: 'Prophet Muhammad -Peace and Blessings of Allah be upon him-',
    ),
  ];
  List<Quiz> get quizes => _quizes;

  int _currIdx = 0;
  int get currIdx => _currIdx;

  void prevCard() {
    if (currIdx == 0) {
      _currIdx = _quizes.length - 1;
    } else {
      _currIdx = _currIdx - 1;
    }

    notifyListeners();
  }

  void nextCard() {
    if (_currIdx == _quizes.length - 1) {
      _currIdx = 0;
    } else {
      _currIdx = _currIdx + 1;
    }

    notifyListeners();
  }
}
