import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'account_model.g.dart';

@HiveType(typeId: 2)
class AccountModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String accName;

  @HiveField(2)
  final String accBalance;

  AccountModel({required this.id, required this.accName, required this.accBalance});

  @override
  String toString() {
    return '$id $accName $accBalance';
  }
}
