import 'dart:convert';

import 'package:weatherapp/base/base_repository.dart';
import 'package:weatherapp/data/weather_response.dart';
import 'package:weatherapp/network/urls.dart';

import 'api_methods.dart';

///api repository for general api call
class ApiRepository extends BaseRepository {
  ApiRepository._internal();

  static final ApiRepository _userRepositoryInstance =
      new ApiRepository._internal();

  factory ApiRepository() => _userRepositoryInstance;

  ///api ==> https://api.openweathermap.org/data/2.5/
  ///query param ==> q-> location
  ///query param ==> appId-> Weather API_KEY
  ///returns [WeatherDetails]
  Future<WeatherDetails> getCurrentWeather(String cityParam) async {
    final response = await networkProvider.callWebService(
        method: ApiMethod.GET,
        path: GET_CURRENT_WEATHER + 'q=$cityParam&appid=$WEATHER_API_KEY',
        headers: header);
    if (response != null) {
      final weatherJson = json.decode(response.body);
      final currentWeatherResponse = WeatherDetails.fromJson(weatherJson);
      return currentWeatherResponse;
    } else {
      return null;
    }
  }

  ///api ==> https://api.openweathermap.org/data/2.5/
  ///query param ==> q-> location
  ///query param ==> appId-> Weather API_KEY
  ///returns list of [weatherDetails]
  Future<List<WeatherDetails>> getForecastWeather(String cityParam) async {
    final response = await networkProvider.callWebService(
        method: ApiMethod.GET,
        path: GET_FORECAST_WEATHER + 'q=$cityParam&appid=$WEATHER_API_KEY',
        headers: header);
    if (response != null) {
      final weatherJson = json.decode(response.body);
      List<WeatherDetails> forecast =
          WeatherDetails.fromForecastJson(weatherJson);
      return forecast;
    } else {
      return null;
    }
  }

  ///api ==> https://api.openweathermap.org/data/2.5/
  ///query param ==> lat-> location's latitude
  ///query param ==> lon-> location's longitude
  ///query param ==> appid -> weather api key
  ///returns [WeatherDetails]
  Future<WeatherDetails> getLocationByLocation(
      double latitude, double longitude) async {
    final response = await networkProvider.callWebService(
        method: ApiMethod.GET,
        path: GET_CURRENT_WEATHER +
            'lat=$latitude&lon=$longitude&appid=$WEATHER_API_KEY',
        headers: header);
    if (response != null) {
      final weatherJson = json.decode(response.body);
      final currentWeatherResponse = WeatherDetails.fromJson(weatherJson);
      return currentWeatherResponse;
    } else {
      return null;
    }
  }
}
