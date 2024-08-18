class WeatherModel {
  final String cityName;
  final String description;
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final String weatherIcon;
  final int conditionId;

  WeatherModel({
    required this.conditionId,
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    required this.weatherIcon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toInt(),
      feelsLike: json['main']['feels_like'].toDouble(),
      minTemperature: json['main']['temp_min'].toInt(),
      maxTemperature: json['main']['temp_max'].toInt(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'],
      visibility: json['visibility'],
      weatherIcon: json['weather'][0]['icon'],
      conditionId: json['weather'][0]['id'],
    );
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌨️';
    } else if (condition < 400) {
      return '🌨️';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '❄️';
    } else if (condition < 800) {
      return '🌫️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍♀️';
    }
  }
}
