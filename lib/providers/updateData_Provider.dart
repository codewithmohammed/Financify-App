import 'package:financify/db/account_db.dart';
import 'package:financify/db/transaction_db.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:flutter/material.dart';

class UpdateDataProvider extends ChangeNotifier {
  late String id;
  late String categoryName;
  late String accountName;
  late String fromaccountName;
  late String toaccountName;
  late String accountAmount;
  late String transactionDate;
  late String transactionNote;
  late TransactionCategoryType type;

  late String initialAmount;

  void updateDataProvider(
      String ide,
      String categoryname,
      String accountname,
      String fromaccount,
      String toaccount,
      String accountamount,
      String date,
      String note,
      TransactionCategoryType updatetype) {
    id = ide;
    categoryName = categoryname;
    accountName = accountname;
    fromaccountName = fromaccount;
    toaccountName = toaccount;
    initialAmount = accountAmount = accountamount;
    transactionDate = date;
    transactionNote = note;
    type = updatetype;
    notifyListeners();
  }

  Future<void> updatetransactionToDB() async {
    final transaction = TransactionModel(
      id: id,
      amount: accountAmount,
      accountname: accountName,
      toaccountname: toaccountName,
      transactiondate: transactionDate,
      fromaccountname: fromaccountName,
      categoryname: categoryName,
      accountnote: transactionNote,
      type: type,
    );
    final transactionDB = TransactionDB();
    await transactionDB.insertTransaction(transaction);
    await calculateAccountAmount();
    notifyListeners();
  }

  Future<void> calculateAccountAmount() async {
    final accountDB = AccountDB();
    List<AccountModel> listofaccountmodel = await accountDB.getAccount();
    final double initial = double.parse(initialAmount);
    final double updatedamount = double.parse(accountAmount);
    final double amounttoBeOperated = (initial - updatedamount).abs();
    print(amounttoBeOperated);
    String? sum;
    if (type == TransactionCategoryType.expense) {
      for (var account in listofaccountmodel) {
        if (account.accName == accountName) {
          double accountBalance = double.parse(account.accBalance);
          if (initial < updatedamount) {
            sum = (accountBalance - amounttoBeOperated).toString();
          } else if (initial > updatedamount) {
            sum = (accountBalance + amounttoBeOperated).toString();
          } else {
            return;
          }
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        }
      }
    } else if (type == TransactionCategoryType.income) {
      for (var account in listofaccountmodel) {
        if (account.accName == accountName) {
          double accountBalance = double.parse(account.accBalance);
          if (initial < updatedamount) {
            sum = (accountBalance + amounttoBeOperated).toString();
          } else if (initial > updatedamount) {
            sum = (accountBalance - amounttoBeOperated).toString();
          } else {
            return;
          }
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        }
      }
    } else if (type == TransactionCategoryType.transfer) {
      for (var account in listofaccountmodel) {
        if (account.accName == fromaccountName) {
          double accountBalance = double.parse(account.accBalance);
          if (initial < updatedamount) {
            sum = (accountBalance - amounttoBeOperated).toString();
          } else if (initial > updatedamount) {
            sum = (accountBalance + amounttoBeOperated).toString();
          } else {
            return;
          }
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        }
        if (account.accName == toaccountName) {
          double accountBalance = double.parse(account.accBalance);
          if (initial < updatedamount) {
            sum = (accountBalance + amounttoBeOperated).toString();
          } else if (initial > updatedamount) {
            sum = (accountBalance - amounttoBeOperated).toString();
          } else {
            return;
          }
          final accountmodel = AccountModel(
              id: account.id, accName: account.accName, accBalance: sum);
          await accountDB.insertAccount(accountmodel);
        } else {
          return;
        }
      }
    }
  }

  void setTransactionupdateDate(String selectedDate) {
    transactionDate = selectedDate;
    notifyListeners();
  }

  setUpdatedCategory(String updatedCategory) {
    categoryName = updatedCategory;
    notifyListeners();
  }

  updateAccountName(String updatedAccountName) {
    accountName = updatedAccountName;
    notifyListeners();
  }

  updatefromAccountName(String updatedfromAccountName) {
    fromaccountName = updatedfromAccountName;
    notifyListeners();
  }

  updatetoAccountName(String updatedtoAccountName) {
    toaccountName = updatedtoAccountName;
    notifyListeners();
  }

  updateAccountBalance(String updatedtoAccountBalance) {
    accountAmount = updatedtoAccountBalance;
    notifyListeners();
  }

  updateAccountNote(String updatedtoAccountNote) {
    transactionNote = updatedtoAccountNote;
    notifyListeners();
  }
}
