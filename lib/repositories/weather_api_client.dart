import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class WeatherApiClient {
  static const baseUrlMetaWeather = 'https://www.metaweather.com';
  static const apiKey = 'MK0TRDzTVOksTCCF6UZjbqZJbDvGAT0T';
  static const baseUrlAcCuWeather = 'http://dataservice.accuweather.com';
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrlMetaWeather/api/location/search/?query=$city';
    final locationResponse   = await this.httpClient.get(locationUrl);

    if(locationResponse  .statusCode != 200) {
      throw Exception('Error getting locationId for $city City: ');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrlMetaWeather/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);
    if(weatherResponse.statusCode != 200) {
      throw Exception('Error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weather.fromJson(weatherJson);
  }

  Future<WeatherDetail> fetchWeatherDetail(int locationId) async {
    print('fetchWeatherDetail');
    final weatherDetailUrl = '$baseUrlAcCuWeather/currentconditions/v1/$locationId?apikey=$apiKey&details=true';
    final weatherDetailResponse = await this.httpClient.get(weatherDetailUrl);
    if(weatherDetailResponse.statusCode != 200) {
      throw Exception('Error getting weather detail for location');
    }
    print('fetchWeatherDetail weatherDetailResponse OK');
    final weatherDetailJson = jsonDecode(weatherDetailResponse.body);
    return WeatherDetail.fromJson(weatherDetailJson);
  }
}
