// import 'package:financify/db/account_db.dart';
// import 'package:financify/db/expense_transaction_db.dart';
// import 'package:financify/model/category/accountcategory/account_model.dart';
// import 'package:financify/model/category/transactioncategory/transaction_model.dart';
// import 'package:flutter/Material.dart';

// class ExpenseTransactionDataProvider extends ChangeNotifier {
//   List<ExpenseTransactionModel> accountList = [];
//   String id = DateTime.now().millisecondsSinceEpoch.toString();
//   TransactionCategoryType type = TransactionCategoryType.expense;
//   TextEditingController expenseAmountController = TextEditingController();
//   TextEditingController expenseAccountController = TextEditingController();
//   TextEditingController expenseDateController = TextEditingController();
//   TextEditingController categoryController = TextEditingController();
//   TextEditingController noteController = TextEditingController();

//   void setid() {
//     id = DateTime.now().millisecondsSinceEpoch.toString();
//   }

//   void setTransactionDate(String selectedDate) {
//     expenseDateController.text = selectedDate;
//     notifyListeners();
//   }

//   Future<void> expenseTransactionToDB() async {
//     final expenseTransaction = ExpenseTransactionModel(
//       id: id,
//       accountBalance: expenseAmountController.text,
//       accountname: expenseAccountController.text,
//       transactiondate: expenseDateController.text,
//       categoryname: categoryController.text,
//       accountnote:
//           noteController.text.isEmpty ? 'No Notes' : noteController.text,
//       type: type,
//     );
//     final expenseTransactionDB = ExpenseTransactionDB();
//     await expenseTransactionDB.insertExpenseTransaction(expenseTransaction);
//     await calculateAccountAmount(
//         expenseAmountController.text, expenseAccountController.text);
//     await dBtoExpenseTransaction();
//     notifyListeners();
//   }

//   Future<void> dBtoExpenseTransaction() async {
//     final expenseTransactionDB = ExpenseTransactionDB();
//     final listofExpenseTransaction =
//         await expenseTransactionDB.getExpenseTransaction();
//     accountList.clear();
//     accountList = listofExpenseTransaction.reversed.toList();
//     notifyListeners();
//   }

//   Future<void> calculateAccountAmount(
//       String expenseToBeSubstract, String accountName) async {
//     final accountDB = AccountDB();
//     List<AccountModel> listofaccountmodel = await accountDB.getAccount();
//     for (var account in listofaccountmodel) {
//       if (account.accName == accountName) {
//         double accountBalance = double.parse(account.accBalance);
//         double expenseSubstract = double.parse(expenseToBeSubstract);
//         final sum = (accountBalance - expenseSubstract).toString();
//         final accountmodel = AccountModel(
//             id: account.id, accName: account.accName, accBalance: sum);
//         await accountDB.insertAccount(accountmodel);
//       }
//     }
//   }

//   void clearAll() {
//     expenseAccountController.clear();
//     expenseAmountController.clear();
//     expenseDateController.clear();
//     categoryController.clear();
//     noteController.clear();
//     notifyListeners();
//   }
// }
