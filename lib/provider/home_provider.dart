import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/base/base_provider.dart';
import 'package:weatherapp/data/weather_response.dart';
import 'package:weatherapp/network/api_repository.dart';
import 'package:weatherapp/utils/city_constants.dart';

///[HomeProvider] is handling all business logic and details
class HomeProvider extends BaseProvider {
  final _repository = ApiRepository();
  WeatherDetails _weatherResponse;
  List<WeatherDetails> _forecastWeatherResponse;
  String _searchCity;

  ///constructor
  HomeProvider() {
    filterBy(CityList.cityList[0]);
  }

  ///::::::::::::::api ==> https://api.openweathermap.org/data/2.5/::::::::::::::
  Future<void> getCurrentWeather(String city) async {
    super.isLoading = true;
    WeatherDetails response;
    response = await _repository.getCurrentWeather(city);
    super.isLoading = false;
    if (response != null) {
      //update meter
      weatherResponse = response;
    } else {
      weatherResponse = null;
    }
  }

  ///::::::::::::::api ==> https://api.openweathermap.org/data/2.5/::::::::::::::
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

  ///::::::::::::::filter based on city selection::::::::::::::
  void filterBy(String searchCity) {
    this.searchCity = searchCity;
    getCurrentWeather(searchCity);
    getForecastWeather(searchCity);
  }

  ///::::::::::::::Getting user current location ::::::::::::::
  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      getWeatherByLocation(position);
    }
  }

  ///::::::::::::::filter based on user current location ::::::::::::::
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

  ///::::::::::::::Encapsulation variables::::::::::::::
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
}
