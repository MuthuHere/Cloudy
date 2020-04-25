import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:weatherapp/route/router.dart';
import 'package:weatherapp/route/routes_constants.dart';
import 'package:weatherapp/ui/dashboard/home_page.dart';
import 'package:weatherapp/utils/colors_constant.dart';
import 'package:weatherapp/utils/string_constants.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'data/fav_city.dart';

///initial view started
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentPath = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentPath.path);
  Hive.openBox<FavCity>(BOX_NAME);
  Hive.registerAdapter(FavCityAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: colorPrimaryDark));
    return MaterialApp(
      title: APP_NAME,
      initialRoute: ROUTE_HOME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: colorPrimary, fontFamily: 'Exo'),
      home: HomePage(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
