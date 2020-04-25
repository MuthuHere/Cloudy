import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider/home_provider.dart';
import 'home_widget_brain.dart';

///home page for the weather application[HomePage] called from [MyApp]
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeWidget _homeWidget;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext context) => HomeProvider(context),
      child: Consumer<HomeProvider>(
        builder:
            (BuildContext context, HomeProvider homeProvider, Widget child) {
              _homeWidget = HomeWidget(homeProvider,context);
          return ModalProgressHUD(
            inAsyncCall: homeProvider.isLoading,
            child: Scaffold(
              appBar: _homeWidget.appBar(),
              body: _homeWidget.homeBody(),
            ),
          );
        },
      ),
    );
  }
}

