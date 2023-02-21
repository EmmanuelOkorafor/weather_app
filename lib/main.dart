// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.





import 'package:flutter/material.dart';
import 'package:weather_app/presentation/states/weather_app.dart';
import 'package:weather_app/weather_app_injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const WeatherApp(),
    );
  }
}
