import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_app/app.dart';
import './repositories/repositories.dart';
import 'package:http/http.dart' as http;


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
  }
}

void main() {

    // Init WeatherRepon
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(httpClient: http.Client())
  );

  //Init Bloc delegate
  BlocSupervisor().delegate = SimpleBlocDelegate();

  runApp(App(weatherRepository: weatherRepository));
  
  SystemChrome.setEnabledSystemUIOverlays([]);
}

