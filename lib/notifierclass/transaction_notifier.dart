import 'package:financify/db/account_db.dart';
import 'package:financify/db/transaction_db.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionDataProvider extends ChangeNotifier {
  List<TransactionModel> accountList = [];
  List<TransactionModel> incomeaccountList = [];
  List<TransactionModel> expenseaccountList = [];
  List<TransactionModel> transferaccountList = [];
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  TransactionCategoryType type = TransactionCategoryType.income;
  TextEditingController amountController = TextEditingController();
  TextEditingController accountnameController = TextEditingController();
  TextEditingController toaccountnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fromaccountnameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  void setid() {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void setTransactionDate(String selectedDate) {
    dateController.text = selectedDate;
    notifyListeners();
  }

  Future<void> transactionToDB() async {
    final transaction = TransactionModel(
      id: id,
      amount: amountController.text,
      accountname: accountnameController.text,
      toaccountname: toaccountnameController.text,
      transactiondate: dateController.text,
      fromaccountname: fromaccountnameController.text,
      categoryname: categoryController.text,
      accountnote:
          noteController.text.isEmpty ? 'No Notes' : noteController.text,
      type: type,
    );
    final transactionDB = TransactionDB();
    await transactionDB.insertTransaction(transaction);
    await calculateAccountAmount(
        amounttoBeOperated: amountController.text,
        accountName: accountnameController.text,
        toaccountname: toaccountnameController.text,
        fromaccountname: fromaccountnameController.text,
        type: type);
    await dBtoTransaction();
    notifyListeners();
  }

  Future<void> dBtoTransaction() async {
    final transactionDB = TransactionDB();
    final listofTransaction = await transactionDB.getTransaction();
    accountList.clear();
    incomeaccountList.clear();
    expenseaccountList.clear();
    transferaccountList.clear();
    accountList = listofTransaction.reversed.toList();
    incomeaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.income)
        .toList();
    expenseaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.expense)
        .toList();
    transferaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.transfer)
        .toList();
    notifyListeners();
  }

  Future<void> calculateAccountAmount(
      {required String amounttoBeOperated,
      String? accountName,
      String? fromaccountname,
      String? toaccountname,
      required TransactionCategoryType type}) async {
    final accountDB = AccountDB();
    List<AccountModel> listofaccountmodel = await accountDB.getAccount();
    if (type == TransactionCategoryType.expense) {
      for (var account in listofaccountmodel) {
        if (account.accName == accountName) {
          double accountBalance = double.parse(account.accBalance);
          double substract = double.parse(amounttoBeOperated);
          final sum = (accountBalance - substract).toString();
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        }
      }
    } else if (type == TransactionCategoryType.income) {
      for (var account in listofaccountmodel) {
        if (account.accName == accountName) {
          double accountBalance = double.parse(account.accBalance);
          double incomeAdded = double.parse(amounttoBeOperated);
          final sum = (accountBalance + incomeAdded).toString();
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        }
      }
    } else if (type == TransactionCategoryType.transfer) {
      for (var account in listofaccountmodel) {
        if (account.accName == toaccountname) {
          double accountBalance = double.parse(account.accBalance);
          double transfercalculated = double.parse(amounttoBeOperated);
          final sum = (accountBalance + transfercalculated).toString();
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        }
        if (account.accName == fromaccountname) {
          double accountBalance = double.parse(account.accBalance);
          double transfercalculated = double.parse(amounttoBeOperated);
          final sum = (accountBalance - transfercalculated).toString();
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        } else {
          return;
        }
      }
    }
  }

  void clearAll() {
    accountnameController.clear();
    amountController.clear();
    dateController.clear();
    categoryController.clear();
    noteController.clear();
    notifyListeners();
  }
}
