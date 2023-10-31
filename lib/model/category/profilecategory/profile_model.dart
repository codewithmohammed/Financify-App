import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:typed_data';
part 'profile_model.g.dart';


@HiveType(typeId: 1)
class ProfileModel {
  @HiveField(0)
  final int id;

  // @HiveField(1)
  // final Uint8List? imageData;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String currencyCode;

  @HiveField(3)
  final String currencyCountry;

  ProfileModel(
      {required this.id,
      // required this.imageData,
      required this.name,
      required this.currencyCode,
      required this.currencyCountry});

  @override
  String toString() {
    return '$id $name $currencyCode $currencyCountry';
  }
}
