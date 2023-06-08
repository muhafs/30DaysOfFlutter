import 'package:flutter/material.dart';

import 'data_services.dart';
import 'models/weather.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
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
  final TextEditingController _cityController = TextEditingController();

  final DataServices _dataServices = DataServices();

  Weather? _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: [
                  if (_response!.weatherIcon != null)
                    Image.network(_response!.weatherIcon!),
                  Text(
                    _response!.tempInfo?.temp?.toString() ?? 'Error',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _response!.weatherInfo?[0].description ?? 'Error',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50),
              width: 150,
              child: TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // !
            ElevatedButton(
              onPressed: _search,
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

  void _search() async {
    if (_cityController.text.trim().isNotEmpty) {
      Weather weatherResponse =
          await _dataServices.getWeatherByCity(_cityController.text);

      setState(() {
        _response = weatherResponse;
      });
    }
  }
}
