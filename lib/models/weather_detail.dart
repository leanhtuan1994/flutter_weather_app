import 'package:equatable/equatable.dart';

class WeatherDetail extends Equatable {
  final String weatherStatus;
  final double temp;
  final double realFeelTemp;
  final int relativeHumidity;
  final double dewPoint;
  final int uvIndex;
  final double visibility;
  final double pressure;

  WeatherDetail({
    this.weatherStatus,
    this.temp,
    this.realFeelTemp,
    this.relativeHumidity,
    this.dewPoint,
    this.uvIndex,
    this.visibility,
    this.pressure
  }) : super([
    weatherStatus,
    temp,
    realFeelTemp,
    relativeHumidity,
    dewPoint,
    uvIndex,
    visibility,
    pressure
  ]);

  static WeatherDetail fromJson(dynamic json) {
    final weatherDetailJson = json[0];
    print(weatherDetailJson);
    return WeatherDetail(
        weatherStatus : weatherDetailJson['WeatherText'],
        temp: weatherDetailJson['Temperature']['Metric']['Value'] as double,
        realFeelTemp: weatherDetailJson['RealFeelTemperature']['Metric']['Value'] as double,
        relativeHumidity: weatherDetailJson['RelativeHumidity'] as int,
        dewPoint: weatherDetailJson['DewPoint']['Metric']['Value'] as double,
        uvIndex: weatherDetailJson['UVIndex'] as int,
        visibility: weatherDetailJson['Visibility']['Metric']['Value'] as double,
        pressure: weatherDetailJson['Pressure']['Metric']['Value']
    );
  }
}