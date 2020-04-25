import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weatherapp/base/base_provider.dart';
import 'package:weatherapp/data/data_city_list.dart';
import 'package:weatherapp/data/fav_city.dart';
import 'package:weatherapp/utils/string_constants.dart';

class CitySelectionProvider extends BaseProvider {
  BuildContext context;
  List<CityListData> _listOfAllCity;
  Box<FavCity> favCityBox;


  CitySelectionProvider(this.context) {
    super.isLoading = true;
    initBoxes();
    loadJson();
  }

  ///LOAD JSON LIST FROM ASSET
  Future<void> loadJson() async {
    ///checking whether already data inserted
    ///if not insert new all cities from assets json file
    if (favCityBox.length == 0) {
      String data = await DefaultAssetBundle.of(context)
          .loadString(JSON_CITIES_IN_MALAYSIA);
      final cityJson = json.decode(data);
      listOfAllCity = CityListData.fromJsonToList(cityJson);
      listOfAllCity.forEach((item) {
        addToHive(FavCity(item.city, item.admin, item.country, item.lat,
            item.lng, item.isFavourite));
      });
    }else{

    }
    super.isLoading = false;
  }

  ///adding data to [Hive] data base
  ///adding [FavCity] from add 1st time and updating favourite array
  void addToHive(FavCity item) async {
    await favCityBox.put(item.city, item);
    notifyListeners();
  }

  List<CityListData> get listOfAllCity => _listOfAllCity;

  set listOfAllCity(List<CityListData> value) {
    _listOfAllCity = value;
    notifyListeners();
  }


  void initBoxes() async {
    favCityBox = Hive.box<FavCity>(BOX_NAME);
    await Hive.openBox<FavCity>(BOX_NAME);
  }
}
