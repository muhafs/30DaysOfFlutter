class Weather {
  String? cityName;
  TemperatorInfo? tempInfo;
  List<WeatherInfo>? weatherInfo;

  String? get weatherIcon {
    if (weatherInfo?[0] != null) {
      return 'https://openweathermap.org/img/wn/${weatherInfo![0].icon}@2x.png';
    } else {
      return null;
    }
  }

  Weather({
    this.cityName,
    this.tempInfo,
    this.weatherInfo,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        cityName: json["name"],
        tempInfo: json["main"] == null
            ? null
            : TemperatorInfo.fromJson(
                json["main"],
              ),
        weatherInfo: json["weather"] == null
            ? []
            : List<WeatherInfo>.from(
                json["weather"]!.map(
                  (x) => WeatherInfo.fromJson(x),
                ),
              ),
      );
}

class TemperatorInfo {
  double? temp;

  TemperatorInfo({this.temp});

  factory TemperatorInfo.fromJson(Map<String, dynamic> json) => TemperatorInfo(
        temp: json["temp"]?.toDouble(),
      );
}

class WeatherInfo {
  String? description;
  String? icon;

  WeatherInfo({
    this.description,
    this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => WeatherInfo(
        description: json["description"],
        icon: json["icon"],
      );
}
