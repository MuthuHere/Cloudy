

class CityListData {
  String city;
  String admin;
  String country;
  String lat;
  String lng;
  bool isFavourite;

  CityListData({this.city, this.admin, this.country, this.lat, this.lng});

  CityListData.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    admin = json['admin'];
    country = json['country'];
    lat = json['lat'];
    lng = json['lng'];
    isFavourite = false;
  }

  static List<CityListData> fromJsonToList(List<dynamic> list) {
    final weathers = List<CityListData>();
    for (int i = 0; i < list.length; i++) {
      weathers.add(
        CityListData.fromJson(list[i]),
      );
    }
    return weathers;
  }
}
