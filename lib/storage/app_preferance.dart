import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/data/data_city_list.dart';
import 'package:weatherapp/storage/pref_constants.dart';

class AppPref {
  static SharedPreferences prefs;
  static List<String> favoriteList;

  static void appPref() async {
    prefs = await SharedPreferences.getInstance();
    _initFavoriteList();
  }

  static setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  static void _initFavoriteList() {
    final List<String> list = prefs.getStringList(PREF_USER_FAVOURITE);
    favoriteList = list ?? [];
  }

  static getInt(String key) {
    return prefs.getInt(key);
  }

  static setString(String key, String value) {
    if (prefs == null) {
      appPref();
    }
    prefs.setString(key, value);
  }

  static setStringList(String key, List<String> list) {
    if (prefs == null) {
      appPref();
    }
    prefs.setStringList(key, list);
  }

  static getStringList(String key) {
    if (prefs == null) {
      appPref();
    }
    prefs.getStringList(key);
  }

  static getString(String key) {
    return prefs.getString(key);
  }

  Future<void> _saveFavoriteList() async {
    await prefs.setStringList(PREF_USER_FAVOURITE, favoriteList);
  }

  Future<void> removeFavoriteCountry(String country) async {
    favoriteList.remove(country);
    await _saveFavoriteList();
  }

  Future<void> addFavoriteCountry(String country) async {
    favoriteList.add(country);
    await _saveFavoriteList();
  }
}
