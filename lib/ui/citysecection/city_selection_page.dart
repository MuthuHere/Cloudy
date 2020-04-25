import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/data/fav_city.dart';
import 'package:weatherapp/provider/city_selection_provider.dart';
import 'package:weatherapp/ui/citysecection/city_body_widget.dart';
import 'package:weatherapp/ui/widgets/app_text.dart';
import 'package:weatherapp/utils/string_constants.dart';

class CitySelectionPage extends StatefulWidget {
  @override
  _CitySelectionPageState createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CitySelectionProvider>(
      create: (BuildContext context) => CitySelectionProvider(context),
      child: Consumer<CitySelectionProvider>(
        builder:
            (BuildContext context, CitySelectionProvider value, Widget child) {
          return ModalProgressHUD(
            inAsyncCall: value.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: AppText(text: CITY_SELECTION_TITLE),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      value.favCityBox != null && value.favCityBox.length > 0
                          ? showSearch(
                              context: context,
                              delegate: SearchCityDelegate(value),
                            )
                          : Container();
                    },
                  ),
                ],
              ),
              body: CityBody(
                provider: value,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// search list of cities
class SearchCityDelegate extends SearchDelegate {
  final CitySelectionProvider provider;
  List<FavCity> searchCityList = [];

  SearchCityDelegate(this.provider) {
    final keyList = provider.favCityBox.keys.toList();
    keyList.forEach((key) {
      searchCityList.add(provider.favCityBox.get(key));
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _tempList = query.isEmpty
        ? searchCityList
        : searchCityList
            .where((element) =>
                element.city.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _tempList.length,
      itemBuilder: (BuildContext context, int position) {
        FavCity favCity = _tempList[position];
        return ListTile(
            onTap: () {
              favCity.isFavourite = !favCity.isFavourite;
              provider.addToHive(favCity);
              close(context, null);
              showResults(context);
            },
            title: Text(_tempList[position].city),
            trailing: IconButton(
              onPressed: () {
                favCity.isFavourite = !favCity.isFavourite;
                provider.addToHive(favCity);
                close(context, null);
              },
              icon: Icon(
                Icons.favorite_border,
                color: favCity.isFavourite ? Colors.green : Colors.grey,
              ),
            ));
      },
    );
  }
}
