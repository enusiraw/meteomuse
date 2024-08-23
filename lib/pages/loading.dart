import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meteomuse/includes/colors.dart';
import 'package:meteomuse/pages/home.dart';
import 'package:meteomuse/services/location_service.dart';
import 'package:meteomuse/services/weather_service.dart';

const apiKey = 'your-api';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    LocationService location = LocationService();
    await location.getCurrentLocation();

    WeatherService weatherservice = WeatherService();
    weatherservice.fetchWeather("");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColors.backgroungPrimary,
      body: const Center(
          child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
