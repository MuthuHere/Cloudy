import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatherapp/data/fav_city.dart';
import 'package:weatherapp/provider/city_selection_provider.dart';
import 'package:weatherapp/ui/widgets/app_text.dart';
import 'package:weatherapp/utils/colors_constant.dart';

class CityBody extends StatelessWidget {
  final CitySelectionProvider provider;

  const CityBody({
    @required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    var searchCityList = [];
    return ValueListenableBuilder(
      valueListenable: provider.favCityBox.listenable(),
      builder: (BuildContext context, Box<FavCity> allCities, Widget child) {
        ///sorting
        final keyList = provider.favCityBox.keys.toList();
        keyList.forEach((key) {
          searchCityList.add(provider.favCityBox.get(key));
        });
        var sortedList = [];
        sortedList =
            searchCityList.where((cities) => cities.isFavourite).toList();
        if (sortedList.length == 0) {
          return Center(
            child: AppText(
                text: 'No Favourite city selected. Search & add cities',textColor: colorPrimary,),
          );
        }
        return ListView.separated(
          itemBuilder: (context, position) {
            FavCity value = sortedList[position];
            return ListTile(
              title: Text(value.city),
              onTap: () {
                Navigator.pop(context, value.city);
              },
              trailing: IconButton(
                onPressed: () {
                  value.isFavourite = !value.isFavourite;
                  provider.addToHive(value);
                },
                icon: Icon(
                  Icons.favorite_border,
                  color: value.isFavourite ? Colors.green : Colors.grey,
                ),
              ),
            );
          },
          itemCount: sortedList.length,
          separatorBuilder: (_, index) => Divider(
            height: 2,
          ),
        );
      },
    );
  }
}
