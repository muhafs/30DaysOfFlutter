// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  double? selectedTip;
  String tipResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Text(
                tipResult,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: 100,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: '10K',
                ),
                textAlign: TextAlign.center,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),

            //

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 0.1,
                        groupValue: selectedTip,
                        onChanged: tipHandler,
                      ),
                      const Text('10%'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 0.15,
                        groupValue: selectedTip,
                        onChanged: tipHandler,
                      ),
                      const Text('15%'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 0.2,
                        groupValue: selectedTip,
                        onChanged: tipHandler,
                      ),
                      const Text('20%'),
                    ],
                  ),
                ],
              ),
            ),

            //

            SizedBox(
              width: 100,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                onPressed: calculateTip,
                child: const Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void tipHandler(val) => setState(() => selectedTip = val);

  void calculateTip() {
    if (controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please Enter total payment to make calculation.',
            textAlign: TextAlign.center,
          ),
        ),
      );

      return;
    }

    if (selectedTip == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please Select tip percentage to make calculation.',
            textAlign: TextAlign.center,
          ),
        ),
      );
      return;
    }

    setState(() {
      tipResult =
          '\n${(selectedTip! * double.parse(controller.text)).toStringAsFixed(2)}K';
    });
  }
}
