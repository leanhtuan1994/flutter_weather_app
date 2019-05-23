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
  final List<int> tempNextHours;

  WeatherDetail({
    this.weatherStatus,
    this.temp,
    this.realFeelTemp,
    this.relativeHumidity,
    this.dewPoint,
    this.uvIndex,
    this.visibility,
    this.pressure,
    this.tempNextHours
  }) : super([
    weatherStatus,
    temp,
    realFeelTemp,
    relativeHumidity,
    dewPoint,
    uvIndex,
    visibility,
    pressure,
    tempNextHours
  ]);

  static int _convertFtoC(int temp) {
    return (temp-32) ~/ 1.8;
  }

  static WeatherDetail fromJson(dynamic json, dynamic nextHoursJson) {
    final weatherDetailJson = json[0];
    List<int> tempList = List();

    for(int i = 0; i < 12; i++) {
      double temp = nextHoursJson[i]['Temperature']['Value'];
      print('temp$i: $temp');
      tempList.add(_convertFtoC(temp.toInt()));
    }

    print(weatherDetailJson);
    return WeatherDetail(
        weatherStatus : weatherDetailJson['WeatherText'],
        temp: weatherDetailJson['Temperature']['Metric']['Value'] as double,
        realFeelTemp: weatherDetailJson['RealFeelTemperature']['Metric']['Value'] as double,
        relativeHumidity: weatherDetailJson['RelativeHumidity'] as int,
        dewPoint: weatherDetailJson['DewPoint']['Metric']['Value'] as double,
        uvIndex: weatherDetailJson['UVIndex'] as int,
        visibility: weatherDetailJson['Visibility']['Metric']['Value'] as double,
        pressure: weatherDetailJson['Pressure']['Metric']['Value'],
        tempNextHours: tempList
    );
  }
}