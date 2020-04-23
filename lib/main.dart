import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/route/routes_constants.dart';
import 'package:weatherapp/ui/dashboard/home_page.dart';
import 'package:weatherapp/utils/colors_constant.dart';

///initial view started
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: colorPrimaryDark));
    return MaterialApp(
      title: 'Cloudy',
      initialRoute: ROUTE_HOME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: colorPrimary, fontFamily: 'Exo'),
      home: HomePage(),
    );
  }
}
