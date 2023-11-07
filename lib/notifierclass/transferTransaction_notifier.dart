// import 'package:financify/db/account_db.dart';
// import 'package:financify/db/transfer_transactiond_db.dart';
// import 'package:financify/model/category/accountcategory/account_model.dart';
// import 'package:financify/model/category/transactioncategory/transaction_model.dart';
// import 'package:flutter/material.dart';

// class TransferTransactionDataProvider extends ChangeNotifier {
//   List<TransferTransactionModel> accountList = [];
//   String id = DateTime.now().millisecondsSinceEpoch.toString();
//   TransactionCategoryType type = TransactionCategoryType.transfer;
//   TextEditingController transferAmountController = TextEditingController();
//   TextEditingController transferToAccountController = TextEditingController();
//   TextEditingController transferDateController = TextEditingController();
//   TextEditingController transferFromAccountController = TextEditingController();
//   TextEditingController noteController = TextEditingController();

//   void setid() {
//     id = DateTime.now().millisecondsSinceEpoch.toString();
//   }

//   void setTransactionDate(String selectedDate) {
//     transferDateController.text = selectedDate;
//     notifyListeners();
//   }

//   void updateAccountList(String value) {}

//   Future<void> transferTransactionToDB() async {
//     final transferTransaction = TransferTransactionModel(
//       id: id,
//       accountBalance: transferAmountController.text,
//       fromaccountname: transferFromAccountController.text,
//       transactiondate: transferDateController.text,
//       toaccountname: transferToAccountController.text,
//       accountnote:
//           noteController.text.isEmpty ? 'No Notes' : noteController.text,
//       type: type,
//     );
//     final transferTransactionDB = TransferTransactionDB();
//     await transferTransactionDB.insertTransferTransaction(transferTransaction);
//     await calculateAccountAmount(transferAmountController.text,
//         transferToAccountController.text, transferFromAccountController.text);
//     await dBtotransferTransaction();
//     notifyListeners();
//   }

//   Future<void> dBtotransferTransaction() async {
//     final transferTransactionDB = TransferTransactionDB();
//     final listoftransferTransaction =
//         await transferTransactionDB.getTransferTransaction();
//     accountList.clear();
//     accountList = listoftransferTransaction.reversed.toList();
//     notifyListeners();
//   }

//   Future<void> calculateAccountAmount(String transferToBecalculated,
//       String toaccountName, String fromaccountName) async {
//     final accountDB = AccountDB();
//     List<AccountModel> listofaccountmodel = await accountDB.getAccount();
//     for (var account in listofaccountmodel) {
//       if (account.accName == toaccountName) {
//         double accountBalance = double.parse(account.accBalance);
//         double transfercalculated = double.parse(transferToBecalculated);
//         final sum = (accountBalance + transfercalculated).toString();
//         final accountmodel = AccountModel(
//             id: account.id, accName: account.accName, accBalance: sum);
//         await accountDB.insertAccount(accountmodel);
//       }
//       if (account.accName == fromaccountName) {
//         double accountBalance = double.parse(account.accBalance);
//         double transfercalculated = double.parse(transferToBecalculated);
//         final sum = (accountBalance - transfercalculated).toString();
//         final accountmodel = AccountModel(
//             id: account.id, accName: account.accName, accBalance: sum);
//         await accountDB.insertAccount(accountmodel);
//       } else {
//         return;
//       }
//     }
//   }

//   void clearAll() {
//     transferAmountController.clear();
//     transferToAccountController.clear();
//     transferDateController.clear();
//     transferFromAccountController.clear();
//     noteController.clear();
//     notifyListeners();
//   }
// }
