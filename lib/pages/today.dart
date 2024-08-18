import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meteomuse/includes/colors.dart';
import 'package:meteomuse/includes/dotline.dart';
import 'package:meteomuse/services/location_service.dart';
import 'package:provider/provider.dart';
import '../services/weather_service.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final TextEditingController _controller = TextEditingController();
  LocationService location = LocationService();
  late String temperature;

  @override
  void initState() {
    super.initState();
    // You might want to fetch the weather data for the initial location here.
    // For example:
    // updateUI(location.getLocationWeather());
  }

  void updateUI(dynamic weatherData) {
    if (weatherData != null) {
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt().toString();
    } else {
      temperature = 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: MyColors.linearGradient),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter City name...",
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: MyColors.primaryColor,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: MyColors.lighttextcolor,
                    ),
                    onPressed: () {
                      weatherService.fetchWeather(_controller.text);
                    },
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Expanded(
              child: Consumer<WeatherService>(
                builder: (context, weatherService, child) {
                  final weather = weatherService.currentWeather;

                  if (weather == null) {
                    return const Center(child: Text('No data available'));
                  }

                  var condition = weather.conditionId;

                  return Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              weather.getWeatherIcon(condition).toString(),
                              style:
                                  TextStyle(fontSize: 80, color: Colors.white),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${weather.temperature}°'.toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 74.sp,
                                      color: MyColors.lighttextcolor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  weather.description,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 10.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${weather.temperature}°C | Feels like ${weather.feelsLike}°C"
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  color: MyColors.lighttextcolor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('wind ${weather.windSpeed} km/h WSW',
                                style: GoogleFonts.poppins(
                                    fontSize: 10.sp,
                                    color: MyColors.lighttextcolor,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 22.h),
                          child:
                              CustomPaint(painter: DrawDottedhorizontalline()),
                        ),
                        //
                        // Text('City: ${weather.cityName}'),
                        // //Text(
                        //    // 'Temperature: ${weather.temperature.toStringAsFixed(1)}°C ${weather.getWeatherIcon(condition)}'),
                        // Text('Humidity: ${weather.humidity}%'),
                        // Text('Description: ${weather.description}'),
                        // // Display the weather icon or an appropriate message if it's unavailable
                        // weather.weatherIcon.isNotEmpty
                        //     ? Image.network(
                        //         'http://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png')
                        //     : const Text('No icon available'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
