// import 'package:financify/model/category/transactioncategory/transaction_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// const TRANSACTION_DB_NAME = 'transfer_transaction_db';

// abstract class TransferTransactionDBFunctions {
//   Future<void> insertTransferTransaction(TransferTransactionModel value);
//   Future<List<TransferTransactionModel>> getTransferTransaction();
//   Future<void> clearTransferTransaction();
// }

// class TransferTransactionDB implements TransferTransactionDBFunctions {
//   @override
//   Future<void> clearTransferTransaction() async {
//     final transferTransactionDB =
//         await Hive.openBox<TransferTransactionModel>(TRANSACTION_DB_NAME);
//     await transferTransactionDB.clear();
//   }

//   @override
//   Future<List<TransferTransactionModel>> getTransferTransaction() async {
//     final transferTransactionDB =
//         await Hive.openBox<TransferTransactionModel>(TRANSACTION_DB_NAME);
//     return transferTransactionDB.values.toList();
//   }

//   @override
//   Future<void> insertTransferTransaction(TransferTransactionModel value) async {
//     final transferTransactionDB =
//         await Hive.openBox<TransferTransactionModel>(TRANSACTION_DB_NAME);
//     transferTransactionDB.put(value.id, value);
//   }
// }
