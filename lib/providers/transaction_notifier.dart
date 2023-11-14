import 'package:financify/db/account_db.dart';
import 'package:financify/db/transaction_db.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionDataProvider extends ChangeNotifier {
  double accExpense = 0;
  List<TransactionModel> accountList = [];
  List<TransactionModel> searchaccountList = [];
  List<TransactionModel> fromaccounts = [];
  List<TransactionModel> filteredaccountList = [];
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

  final List<String> filtertype = [
    'Income',
    'Expense',
    'Transfer',
  ];
  TransactionCategoryType? filteringtype;
  TextEditingController selectedaccountValue = TextEditingController();
  TextEditingController selectedaDateValue = TextEditingController();
  TextEditingController selectedaCategoryValue = TextEditingController();

  filterSelection() {
    if (filteringtype != null ||
        selectedaccountValue.text.isNotEmpty ||
        selectedaDateValue.text.isNotEmpty ||
        selectedaCategoryValue.text.isNotEmpty) {
      searchaccountList.clear();
      filterByFilteringType();
      filterByAccountName();
      filterByDateValue();
      filterByCategoryName();
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   // Combination 1
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.transactiondate == selectedaDateValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // if (filteringtype != null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   // Combination 2
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.transactiondate == selectedaDateValue.text);
      // }

      // if (filteringtype != null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   // Combination 3
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // if (filteringtype != null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   // Combination 4
      //   searchaccountList.where(
      //       (element) => element.accountname == selectedaccountValue.text);
      // }
      // // Combination 5
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where((element) =>
      //       element.transactiondate == selectedaDateValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 6
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList.where(
      //       (element) => element.transactiondate == selectedaDateValue.text);
      // }

      // // Combination 7
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where(
      //       (element) => element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 8
      // if (filteringtype != null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList;
      // }

      // // Combination 9
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.transactiondate == selectedaDateValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 10
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.transactiondate == selectedaDateValue.text);
      // }

      // // Combination 11
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where((element) =>
      //       element.accountname == selectedaccountValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 12
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isNotEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList.where(
      //       (element) => element.accountname == selectedaccountValue.text);
      // }

      // // Combination 13
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where((element) =>
      //       element.transactiondate == selectedaDateValue.text &&
      //       element.categoryname == selectedaCategoryValue.text);
      // }

      // // Combination 14
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isNotEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList.where(
      //       (element) => element.transactiondate == selectedaDateValue.text);
      // }

      // // Combination 15
      // if (filteringtype == null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isNotEmpty) {
      //   searchaccountList.where(
      //       (element) => element.categoryname == selectedaCategoryValue.text);
      // }

      // if (filteringtype == null &&
      //     selectedaccountValue.text.isEmpty &&
      //     selectedaDateValue.text.isEmpty &&
      //     selectedaCategoryValue.text.isEmpty) {
      //   searchaccountList;
      // }
    } else {
      searchaccountList.addAll(accountList);
    }
    filteredaccountList = searchaccountList.toSet().toList();
    notifyListeners();
  }

  filterClear() {
    filteringtype = null;
    selectedaccountValue.clear();
    selectedaDateValue.clear();
    selectedaCategoryValue.clear();
    notifyListeners();
  }

  filterByFilteringType() {
    if (filteringtype != null) {
      searchaccountList.addAll(accountList
          .where((element) => element.type == filteringtype)
          .toList());
    } else {
      return;
    }
  }

  filterByAccountName() {
    if (selectedaccountValue.text.isNotEmpty) {
      searchaccountList.addAll(accountList
          .where((element) => element.accountname == selectedaccountValue.text)
          .toList());
    } else {
      return;
    }
  }

  filterByDateValue() {
    if (selectedaDateValue.text.isNotEmpty) {
      searchaccountList.addAll(accountList
          .where(
              (element) => element.transactiondate == selectedaDateValue.text)
          .toList());
    } else {
      return;
    }
  }

  filterByCategoryName() {
    if (selectedaCategoryValue.text.isNotEmpty) {
      searchaccountList.addAll(accountList
          .where(
              (element) => element.categoryname == selectedaCategoryValue.text)
          .toList());
    } else {
      return;
    }
  }

  setSelectedtypeValue(String value) {
    if (value == 'Income') {
      filteringtype = TransactionCategoryType.income;
    } else if (value == 'Expense') {
      filteringtype = TransactionCategoryType.expense;
    } else {
      filteringtype = TransactionCategoryType.transfer;
    }
  }

  setSelecteddateValue(String value) {
    selectedaDateValue.text = value;
    notifyListeners();
  }

  setSelectedAccountValue(String value) {
    selectedaccountValue.text = value;
    print(selectedaccountValue.text);
    notifyListeners();
  }

  setSelectedCategoryValue(String value) {
    selectedaCategoryValue.text = value;
    notifyListeners();
  }

  void setid() {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void setTransactionDate(String selectedDate) {
    dateController.text = selectedDate;
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.trim().isEmpty) {
      searchaccountList = accountList;
    } else {
      searchaccountList = accountList
          .where((element) =>
              element.accountname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.accountnote
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.categoryname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.fromaccountname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.toaccountname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.transactiondate
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.amount
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    filteredaccountList = searchaccountList.toSet().toList();
    notifyListeners();
  }

  cancelSearch() {
    filteredaccountList = accountList;
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

  Future<void> deleteTransaction(String deleteID) async {
    final transactionDB = TransactionDB();
    transactionDB.deleteTransaction(deleteID);
     await dBtoTransaction();
  }

  Future<void> dBtoTransaction() async {
    final transactionDB = TransactionDB();
    final listofTransaction = await transactionDB.getTransaction();
    accountList.clear();
    incomeaccountList.clear();
    expenseaccountList.clear();
    transferaccountList.clear();
    filteredaccountList = accountList = listofTransaction.toList();
    accountList.sort((first, second) {
      return second.transactiondate.compareTo(first.transactiondate);
    });
    filteredaccountList.sort((first, second) {
      return second.transactiondate.compareTo(first.transactiondate);
    });
    incomeaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.income)
        .toList();
    expenseaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.expense)
        .toList();
    accExpense = sumofAccounts();
    transferaccountList = listofTransaction
        .where((element) => element.type == TransactionCategoryType.transfer)
        .toList();
    notifyListeners();
  }

  double sumofAccounts() {
    final accountbalances = expenseaccountList
        .map((account) => double.parse(account.amount))
        .toList();
    double sum = accountbalances.fold(
        0, (previousValue, element) => previousValue + element);
    return sum;
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
      try {
        double accountBalance = double.parse(account.accBalance);
        double transfercalculated = double.parse(amounttoBeOperated);
        final sum = (accountBalance + transfercalculated).toString();
        final accountmodel = AccountModel(
            id: account.id, accName: account.accName, accBalance: sum);
        await accountDB.insertAccount(accountmodel);
      } catch (e) {
        // print('Error parsing values for toaccount: $e');
      }
    }
  }

  for (var account in listofaccountmodel) {
    if (account.accName == fromaccountname) {
      try {
        double accountBalance = double.parse(account.accBalance);
        double transfercalculated = double.parse(amounttoBeOperated);
        final sum = (accountBalance - transfercalculated).toString();
        final accountmodel = AccountModel(
            id: account.id, accName: account.accName, accBalance: sum);
        await accountDB.insertAccount(accountmodel);
      } catch (e) {
        // print('Error parsing values for fromaccount: $e');
      }
    }
  }
}

  }

  void clearAll() {
    accountnameController.clear();
    amountController.clear();
    toaccountnameController.clear();
    fromaccountnameController.clear();
    dateController.clear();
    categoryController.clear();
    noteController.clear();
    notifyListeners();
  }

  void disposecontrollers() {
    accountnameController.dispose();
    amountController.dispose();
    toaccountnameController.dispose();
    fromaccountnameController.dispose();
    dateController.dispose();
    categoryController.dispose();
    noteController.dispose();
    notifyListeners();
  }
}
