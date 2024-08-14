import 'package:flutter/material.dart';
import 'package:meteomuse/model/weatherModel.dart';
import 'package:meteomuse/services/weather_service.dart';
import 'package:provider/provider.dart';


class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    weatherService.fetchWeather(_controller.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (weatherService.currentWeather != null)
              WeatherInfo(weather: weatherService.currentWeather!),
          ],
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;

  WeatherInfo({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(
          weather.description,
          style: TextStyle(fontSize: 24),
        ),
        Text(
          '${weather.temperature}°C',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Feels Like'),
                Text('${weather.feelsLike}°C'),
              ],
            ),
            Column(
              children: [
                Text('Wind Speed'),
                Text('${weather.windSpeed} m/s'),
              ],
            ),
          ],
        ),
        // Add more weather details here
      ],
    );
  }
}
