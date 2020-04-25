import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatherapp/data/fav_city.dart';
import 'package:weatherapp/provider/city_selection_provider.dart';

class CityBody extends StatelessWidget {
  final CitySelectionProvider provider;

  const CityBody({
    @required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: provider.favCityBox.listenable(),
      builder: (BuildContext context, Box<FavCity> allCities, Widget child) {
        return ListView.separated(
          itemBuilder: (context, position) {
            final key = allCities.keys.toList()[position];
            FavCity value = allCities.get(key);
            return ListTile(
              title: Text(value.city),
              onTap: () {
                Navigator.pop(
                  context,
                );
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
          itemCount: allCities.keys.toList().length,
          separatorBuilder: (_, index) => Divider(
            height: 2,
          ),
        );
      },
    );
  }
}
