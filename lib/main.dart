import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meteomuse/pages/home.dart';
import 'package:meteomuse/pages/intro_page.dart';
import 'package:meteomuse/services/weather_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 760),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return  MaterialApp(
      debugShowCheckedModeBanner: false,
       routes: {
                '/home': (context) =>  WeatherScreen(),},
      home: const IntroScreen(),
    );
        });
  }
}
