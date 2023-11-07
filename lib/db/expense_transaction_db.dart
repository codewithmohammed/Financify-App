// import 'package:financify/model/category/transactioncategory/transaction_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// const TRANSACTION_DB_NAME = 'expense_transaction_db';

// abstract class ExpenseTransactionDBFunctions {
//   Future<void> insertExpenseTransaction(ExpenseTransactionModel value);
//   Future<List<ExpenseTransactionModel>> getExpenseTransaction();
//   Future<void> clearExpenseTransaction();
// }

// class ExpenseTransactionDB implements ExpenseTransactionDBFunctions {
//   @override
//   Future<void> clearExpenseTransaction() async {
//     final expenseTransactionDB =
//         await Hive.openBox<ExpenseTransactionModel>(TRANSACTION_DB_NAME);
//     await expenseTransactionDB.clear();
//   }

//   @override
//   Future<List<ExpenseTransactionModel>> getExpenseTransaction() async {
//     final expenseTransactionDB =
//         await Hive.openBox<ExpenseTransactionModel>(TRANSACTION_DB_NAME);
//     return expenseTransactionDB.values.toList();
//   }

//   @override
//   Future<void> insertExpenseTransaction(ExpenseTransactionModel value) async {
//     final expenseTransactionDB =
//         await Hive.openBox<ExpenseTransactionModel>(TRANSACTION_DB_NAME);
//     expenseTransactionDB.put(value.id, value);
//   }
// }


