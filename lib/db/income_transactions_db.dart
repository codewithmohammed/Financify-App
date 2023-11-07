// import 'package:financify/model/category/transactioncategory/transaction_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// const TRANSACTION_DB_NAME = 'transaction_db';

// abstract class IncomeTransactionDBFunctions {
//   Future<void> insertIncomeTransaction(IncomeTransactionModel value);
//   Future<List<IncomeTransactionModel>> getIncomeTransaction();
//   Future<void> clearIncomeTransaction();
// }

// class IncomeTransactionDB implements IncomeTransactionDBFunctions {
//   @override
//   Future<void> clearIncomeTransaction() async {
//     final incomeTransactionDB =
//         await Hive.openBox<IncomeTransactionModel>(TRANSACTION_DB_NAME);
//     await incomeTransactionDB.clear();
//   }

//   @override
//   Future<List<IncomeTransactionModel>> getIncomeTransaction() async {
//     final incomeTransactionDB =
//         await Hive.openBox<IncomeTransactionModel>(TRANSACTION_DB_NAME);
//     return incomeTransactionDB.values.toList();
//   }

//   @override
//   Future<void> insertIncomeTransaction(IncomeTransactionModel value) async {
//     final incomeTransactionDB =
//         await Hive.openBox<IncomeTransactionModel>(TRANSACTION_DB_NAME);
//     incomeTransactionDB.put(value.id, value);
//   }
// }


