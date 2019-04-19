import '../models/models.dart';

import 'weather_api_client.dart';
import 'package:meta/meta.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient}) :
        assert(weatherApiClient != null);

  Future<Weather> getWeather(int locationId) async {
    return await weatherApiClient.fetchWeather(locationId);
  }

}