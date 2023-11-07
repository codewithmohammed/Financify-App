// import 'package:financify/db/expense_transaction_db.dart';
// import 'package:financify/db/income_transactions_db.dart';
// import 'package:financify/db/transfer_transactiond_db.dart';
// import 'package:financify/model/category/transactioncategory/transaction_model.dart';
// import 'package:flutter/material.dart';

// class RecordDataNotifier extends ChangeNotifier {
//   List<dynamic> listcombinedata = [];

//   void addlisttocombine() async {
//     final transferTransactionDB = TransferTransactionDB();
//     final listoftransferdata =
//         await transferTransactionDB.getTransferTransaction();
//     final expenseTransactionDB = ExpenseTransactionDB();
//     final listofexpensedata =
//         await expenseTransactionDB.getExpenseTransaction();
//     final incomeTransactionDB = IncomeTransactionDB();
//     final listofincomedata = await incomeTransactionDB.getIncomeTransaction();
//     listcombinedata.clear();
//     listcombinedata.addAll(listofincomedata);
//     listcombinedata.addAll(listoftransferdata);
//     listcombinedata.addAll(listofexpensedata);
//     print(listcombinedata);
//     listcombinedata.sort((a, b) {
//       if (a is IncomeTransactionModel && b is ExpenseTransactionModel) {
//         return a.transactiondate.compareTo(b.transactiondate);
//       } else if (a is ExpenseTransactionModel && b is ExpenseTransactionModel) {
//         return a.transactiondate.compareTo(b.transactiondate);
//       } else if (a is TransferTransactionModel &&
//           b is ExpenseTransactionModel) {
//         return a.transactiondate.compareTo(b.transactiondate);
//       } else {
//         return 0;
//       }
//     });
//     notifyListeners();
//   }
// }
