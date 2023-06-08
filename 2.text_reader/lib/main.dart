import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text Reader',
      home: TextReaderWidget(),
    );
  }
}

class TextReaderWidget extends StatefulWidget {
  const TextReaderWidget({
    super.key,
  });

  @override
  State<TextReaderWidget> createState() => _TextReaderWidgetState();
}

class _TextReaderWidgetState extends State<TextReaderWidget> {
  double fontSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: TextField(
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            Slider(
              value: fontSize,
              onChanged: (value) {
                setState(() {
                  fontSize = value;
                });
              },
              min: 30,
              max: 100,
            ),
          ],
        ),
      ),
    );
  }
}
