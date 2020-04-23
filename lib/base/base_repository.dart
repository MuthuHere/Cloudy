import 'package:weatherapp/network/service_provider.dart';

///[BaseRepository] for all api's
///here is all base repositories for api header and all
class BaseRepository {
  final networkProvider = ServiceProvider();

  Map<String, String> header = {
    "Content-Type": "application/json",
  };
}
