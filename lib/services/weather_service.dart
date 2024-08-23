import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteomuse/model/weatherModel.dart';

const apiKey = 'your-api';

class WeatherService with ChangeNotifier {
  WeatherModel? _currentWeather;

  WeatherModel? get currentWeather => _currentWeather;

  Future<void> fetchWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('API Response: $data'); 
        _currentWeather = WeatherModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (error) {
      print('Error fetching weather: $error');
    }
  }
}
