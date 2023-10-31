import 'package:hive_flutter/hive_flutter.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 4)
enum TransactionCategoryType { 
  @HiveField(0)
  income, 
  @HiveField(1)
  expense, 
  @HiveField(2)
  transfer 
  }

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String accountname;
  @HiveField(2)
  final String toAccount;
  @HiveField(3)
  final String transactiondate;
  @HiveField(4)
  final String fromAccount;
  @HiveField(5)
  final String categoryname;
  @HiveField(6)
  final TransactionCategoryType type;

  TransactionModel(
      {required this.id,
      required this.accountname,
      required this.toAccount,
      required this.transactiondate,
      required this.fromAccount,
      required this.categoryname,
      required this.type});
}
