import 'package:hive/hive.dart';

part 'fav_city.g.dart';

@HiveType(typeId: 0)
class FavCity extends HiveObject{
  @HiveField(0)
  String city;
  @HiveField(1)
  String admin;
  @HiveField(2)
  String country;
  @HiveField(3)
  String lat;
  @HiveField(4)
  String lng;
  @HiveField(5)
  bool isFavourite;

  FavCity(this.city, this.admin, this.country, this.lat, this.lng,
      this.isFavourite);

  @override
  Future<void> save() {
    return super.save();
  }
}
