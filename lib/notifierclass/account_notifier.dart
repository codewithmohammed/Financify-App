import 'package:financify/db/account_db.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:flutter/Material.dart';

class AccountDataProvider extends ChangeNotifier {
  List<AccountModel> accountList = [];
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  String accName = 'Cash';
  String accBalance = '0';

  void setId() {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void accNameSet(String accountName) {
    accName = accountName;
    notifyListeners();
  }

  void accBalanaceSet(String accountBalance) {
    accBalance = accountBalance;
    notifyListeners();
  }

  Future<void> dBToAccount() async {
    final accountDB = AccountDB();
    final accountLists = await accountDB.getAccount();
    print(accountLists);
    accountList.clear();
    accountList = accountLists;
    notifyListeners();
  }

  Future<void> accountToDB() async {
    final accountvalue =
        AccountModel(id: id, accName: accName, accBalance: accBalance);
    final accountDB = AccountDB();
    await accountDB.insertAccount(accountvalue);
    await dBToAccount();
  }
}
