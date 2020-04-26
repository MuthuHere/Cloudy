import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/base/base_provider.dart';
import 'package:weatherapp/data/weather_response.dart';
import 'package:weatherapp/network/api_repository.dart';
import 'package:weatherapp/route/routes_constants.dart';
import 'package:weatherapp/utils/city_constants.dart';
import 'package:weatherapp/utils/string_constants.dart';
import 'package:weatherapp/utils/toast_message.dart';

///[HomeProvider] is handling all business logic and details
class HomeProvider extends BaseProvider {
  final _repository = ApiRepository();
  final BuildContext context;
  WeatherDetails _weatherResponse;
  List<WeatherDetails> _forecastWeatherResponse;
  String _searchCity;

  ///:::::::::::::: CONSTRUCTOR ::::::::::::::
  HomeProvider(this.context) {
    filterBy(CityList.cityList[0]);
    loadJson(context);
  }

  ///::::::::::::::API ==> https://api.openweathermap.org/data/2.5/::::::::::::::
  Future<void> getCurrentWeather(String city) async {
    super.isLoading = true;
    WeatherDetails response;
    response = await _repository.getCurrentWeather(city);
    super.isLoading = false;
    if (response != null) {
      //update data
      weatherResponse = response;
    } else {
      weatherResponse = null;
    }
  }

  ///::::::::::::::API ==> https://api.openweathermap.org/data/2.5/::::::::::::::
  Future<void> getForecastWeather(String city) async {
    super.isLoading = true;
    List<WeatherDetails> response;
    response = await _repository.getForecastWeather(city);
    super.isLoading = false;
    if (response != null) {
      forecastWeatherResponse = response;
    } else {
      forecastWeatherResponse = null;
    }
  }

  ///::::::::::::::FILTER BASED ON CITY SELECTION ::::::::::::::
  void filterBy(String searchCity) {
    this.searchCity = searchCity;
    getCurrentWeather(searchCity);
    getForecastWeather(searchCity);
  }

  ///::::::::::::::GETTING USER CURRENT LOCATION ::::::::::::::
  getUserLocation() async {
    super.isLoading = true;
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      getWeatherByLocation(position);
    } else {
      AppMessage.toast('Permission Denied!!');
      super.isLoading = false;
    }
  }

  ///::::::::::::::FILTER BASED ON USER CURRENT LOCATION ::::::::::::::
  Future<void> getWeatherByLocation(Position position) async {
    super.isLoading = true;
    WeatherDetails response;
    response = await _repository.getLocationByLocation(
        position.latitude, position.longitude);
    super.isLoading = false;
    if (response != null) {
      weatherResponse = response;
    } else {
      forecastWeatherResponse = null;
    }
  }

  ///::::::::::::::ENCAPSULATION VARIABLES::::::::::::::
  WeatherDetails get weatherResponse => _weatherResponse;

  set weatherResponse(WeatherDetails value) {
    _weatherResponse = value;
    notifyListeners();
  }

  List<WeatherDetails> get forecastWeatherResponse => _forecastWeatherResponse;

  set forecastWeatherResponse(List<WeatherDetails> value) {
    _forecastWeatherResponse = value;
    notifyListeners();
  }

  String get searchCity => _searchCity;

  set searchCity(String value) {
    _searchCity = value;
    notifyListeners();
  }

  ///LOAD JSON LIST FROM ASSET
  void loadJson(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString(JSON_CITIES_IN_MALAYSIA);
    final jsonResult = json.decode(data);
    print(jsonResult.toString());
  }

  void otherCityOnClicked() async {
    final result = await Navigator.pushNamed(context, ROUTE_SELECT_CITY);
    if (result != null) {
      filterBy(result);
    }
  }
}
