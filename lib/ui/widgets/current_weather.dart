import 'package:flutter/material.dart';
import 'package:weatherapp/data/weather_response.dart';
import 'package:weatherapp/ui/widgets/app_text.dart';
import 'package:weatherapp/ui/widgets/value_tile.dart';
import 'package:weatherapp/utils/colors_constant.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  final WeatherDetails weather;

  const CurrentConditions({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: pureWhite,
          size: 50,
        ),
        SizedBox(
          height: 10,
        ),
        AppText(
          text: '${this.weather.temperature.celsius}°',
          fontSize: 17,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile(
            "max",
            '${this.weather.maxTemperature.celsius}°',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: Container(
                width: 1,
                height: 30,
                color: pureWhite,
              ),
            ),
          ),
          ValueTile("min", '${this.weather.minTemperature.celsius}°'),
        ]),
      ],
    );
  }
}
