import 'package:flutter/material.dart';
import 'package:flutter_weather_app/home.dart';
import './repositories/repositories.dart';


class App extends StatefulWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
    : assert(weatherRepository != null),
  super(key : key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(weatherRepository: widget.weatherRepository),
    );
  }
}