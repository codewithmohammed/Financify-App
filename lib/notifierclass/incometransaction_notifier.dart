// import 'package:financify/db/account_db.dart';
// import 'package:financify/db/income_transactions_db.dart';
// import 'package:financify/model/category/accountcategory/account_model.dart';
// import 'package:financify/model/category/transactioncategory/transaction_model.dart';
// import 'package:flutter/material.dart';

// class IncomeTransactionDataProvider extends ChangeNotifier {
//   List<IncomeTransactionModel> accountList = [];
//   String id = DateTime.now().millisecondsSinceEpoch.toString();
//   TransactionCategoryType type = TransactionCategoryType.income;
//   TextEditingController incomeAmountController = TextEditingController();
//   TextEditingController incomeAccountController = TextEditingController();
//   TextEditingController incomeDateController = TextEditingController();
//   TextEditingController categoryController = TextEditingController();
//   TextEditingController noteController = TextEditingController();

//   void setid() {
//     id = DateTime.now().millisecondsSinceEpoch.toString();
//   }

//   void setTransactionDate(String selectedDate) {
//     incomeDateController.text = selectedDate;
//     notifyListeners();
//   }

//   Future<void> incomeTransactionToDB() async {
//     final incomeTransaction = IncomeTransactionModel(
//         id: id,
//         accountBalance: incomeAmountController.text,
//         accountname: incomeAccountController.text,
//         transactiondate: incomeDateController.text,
//         categoryname: categoryController.text,
//         accountnote: noteController.text.isEmpty ? 'No Notes' : noteController.text,
//         type: type,
//         );
//     final incomeTransactionDB = IncomeTransactionDB();
//     await incomeTransactionDB.insertIncomeTransaction(incomeTransaction);
//     await calculateAccountAmount(
//         incomeAmountController.text, incomeAccountController.text);
//     await dBtoincomeTransaction();
//     notifyListeners();
//   }

//   Future<void> dBtoincomeTransaction() async {
//     final incomeTransactionDB = IncomeTransactionDB();
//     final listofincomeTransaction =
//         await incomeTransactionDB.getIncomeTransaction();
//     accountList.clear();
//     accountList = listofincomeTransaction.reversed.toList();
//     notifyListeners();
//   }

//   Future<void> calculateAccountAmount(
//       String incomeToBeAdded, String accountName) async {
//     final accountDB = AccountDB();
//     List<AccountModel> listofaccountmodel = await accountDB.getAccount();
//     for (var account in listofaccountmodel) {
//       if (account.accName == accountName) {
//         double accountBalance = double.parse(account.accBalance);
//         double incomeAdded = double.parse(incomeToBeAdded);
//         final sum = (accountBalance + incomeAdded).toString();
//         final accountmodel = AccountModel(
//             id: account.id, accName: account.accName, accBalance: sum);
//         await accountDB.insertAccount(accountmodel);
//       }
//     }
//   }

//   void clearAll() {
//     incomeAccountController.clear();
//     incomeAmountController.clear();
//     incomeDateController.clear();
//     categoryController.clear();
//     noteController.clear();
//     notifyListeners();
//   }
// }
// class TransferTransactionDataProvider extends ChangeNotifier {
//   String id = DateTime.now().millisecondsSinceEpoch.toString();
//   String toAccountName = 'Select Account';
//   String? transactionDate = '';
//   String fromAccountName = 'Select Account';
//   TransactionCategoryType type = TransactionCategoryType.transfer;

//   void setid() {
//     id = DateTime.now().millisecondsSinceEpoch.toString();
//   }

//   void setToAccountName(String selectedToAccount) {
//     toAccountName = selectedToAccount;
//     notifyListeners();
//   }

//   void setTransactionDate(String selectedTransactionDate) {
//     transactionDate = selectedTransactionDate;
//     notifyListeners();
//   }

//   void setFromAccount(String selectedFromAccount) {
//     fromAccountName = selectedFromAccount;
//     notifyListeners();
//   }
// }
