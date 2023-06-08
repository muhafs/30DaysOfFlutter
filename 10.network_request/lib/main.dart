import 'package:flutter/material.dart';

import 'data_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Network Request',
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DataService _dataService = DataService();
  String? _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Builder(
          builder: (_) {
            if (_response != null) {
              return Text(_response!);
            } else {
              return ElevatedButton(
                onPressed: fetchData,
                child: const Text('Fetch Data'),
              );
            }
          },
        ),
      ),
    );
  }

  void fetchData() async {
    _response = await _dataService.getUserData();

    setState(() {});
  }
}
