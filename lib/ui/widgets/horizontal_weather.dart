import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/data/weather_response.dart';
import 'package:weatherapp/ui/widgets/app_text.dart';
import 'package:weatherapp/utils/colors_constant.dart';

/// horizontal scrolling list of weather conditions
/// Shows DateTime, Weather Condition icon and Temperature
class ForecastHorizontalList extends StatelessWidget {
  const ForecastHorizontalList({
    Key key,
    @required this.weatherList,
  }) : super(key: key);

  final List<WeatherDetails> weatherList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: weatherList.length,
        separatorBuilder: (context, index) => Divider(
          height: 100,
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = weatherList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: itemViews(
                DateFormat('E, ha').format(
                  DateTime.fromMillisecondsSinceEpoch(item.time * 1000),
                ),
                '${item.temperature.celsius.toStringAsFixed(1)}',
                item.getIconData(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget itemViews(String label, String value, IconData iconData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: label,
        ),
        SizedBox(
          height: 5,
        ),
        iconData != null
            ? Icon(
                iconData,
                size: 20,
                color: pureWhite,
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        AppText(
          text: value,
        ),
      ],
    );
  }
}
