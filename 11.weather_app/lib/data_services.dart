import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/weather.dart';

class DataServices {
  final String baseUrl = 'api.openweathermap.org';
  final String pathUrl = '/data/2.5/weather';

  Future<Weather> getWeatherByCity(String cityName) async {
    final Uri url = Uri.https(
      baseUrl,
      pathUrl,
      {
        'q': cityName,
        'appid': '168f19ffb05420184e5f02278cc53e04',
        'units': 'metric',
      },
    );

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      Weather weatherData = Weather.fromJson(data);

      return weatherData;
    } else {
      throw Exception('something went error wihle fetching data');
    }
  }
}
