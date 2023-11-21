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
@HiveType(typeId: 5)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String amount;
  @HiveField(2)
  final String accountname;
   @HiveField(3)
  final String toaccountname;
  @HiveField(4)
  final String transactiondate;
   @HiveField(5)
  final String fromaccountname;
  @HiveField(6)
  final String categoryname;
  @HiveField(7)
  final String accountnote;
  @HiveField(8)
  final TransactionCategoryType type;

  TransactionModel(
      {required this.id,
      required this.amount,
      required this.accountname,
      required this.toaccountname,
      required this.transactiondate,
      required this.fromaccountname,
      required this.categoryname,
      required this.accountnote,
      required this.type});
}