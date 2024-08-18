class WeatherDetail {
  final DateTime dateTime;
  final double temperature;
  final String weatherIcon;

  WeatherDetail({
    required this.dateTime,
    required this.temperature,
    required this.weatherIcon,
  });

  factory WeatherDetail.fromJson(Map<String, dynamic> json) {
    return WeatherDetail(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      weatherIcon: json['weather'][0]['icon'],
    );
  }
  
}
