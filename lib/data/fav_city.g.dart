// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_city.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavCityAdapter extends TypeAdapter<FavCity> {
  @override
  final typeId = 0;

  @override
  FavCity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavCity(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FavCity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.admin)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.lat)
      ..writeByte(4)
      ..write(obj.lng)
      ..writeByte(5)
      ..write(obj.isFavourite);
  }
}
