import 'package:flutter/material.dart';
import 'package:weatherapp/provider/home_provider.dart';
import 'package:weatherapp/ui/widgets/app_text.dart';

///[LoadingFailedWidget] is shown when the data failed

class LoadingFailedWidget extends StatelessWidget {
  final HomeProvider homeProvider;

  const LoadingFailedWidget({
    @required this.homeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        child: AppText(text: 'Loading weather failed try again!'),
        onPressed: () {
          homeProvider.filterBy(homeProvider.searchCity);
        },
      ),
    );
  }
}
