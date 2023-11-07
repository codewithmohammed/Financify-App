import 'package:financify/db/account_db.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:flutter/Material.dart';

class AccountDataProvider extends ChangeNotifier {
  List<AccountModel> accountList = [];
  List<String> toaccountList = [];
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  String accName = 'Cash';
  String accBalance = '0';
  TextEditingController accNameController = TextEditingController();
  TextEditingController accBalanceController = TextEditingController();
  double accTotal = 0;

  void setId() {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void updateId(String updateId) {
    id = updateId;
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
    final getaccountLists = await accountDB.getAccount();
    print(getaccountLists);
    accountList.clear();
    toaccountList.clear();
    accountList = getaccountLists;
    toaccountList = getaccountLists.map((e) => e.accName).toList();
    toaccountList.add('choose another account');
    print(toaccountList);
    accTotal = sumofAccounts(getaccountLists);
    notifyListeners();
    print('object');
  }

  Future<void> dBDeleteAccount(String index) async {
    final accountDB = AccountDB();
    await accountDB.deleteAccount(index);
    dBToAccount();
  }

  double sumofAccounts(List<AccountModel> accountLists) {
    final accountbalances = accountLists
        .map((account) => double.parse(account.accBalance))
        .toList();
    double sum = accountbalances.fold(
        0, (previousValue, element) => previousValue + element);
    return sum;
  }

  Future<void> accountToDB() async {
    final accountvalue =
        AccountModel(id: id, accName: accName, accBalance: accBalance);
    final accountDB = AccountDB();
    await accountDB.insertAccount(accountvalue);
    await dBToAccount();
  }
}
