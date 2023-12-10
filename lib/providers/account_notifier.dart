import 'package:financify/db/account_db.dart';
import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:flutter/Material.dart';

class AccountDataProvider extends ChangeNotifier {
  final accountDB = AccountDB();
  List<AccountModel> accountList = [];
  List<String> toaccountList = [];
  List<String> fromaccountList = [];
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  String accName = 'Cash';
  String accBalance = '0';
  TextEditingController accNameController = TextEditingController();
  TextEditingController accBalanceController = TextEditingController();
  double accTotal = 0;

  Future<void> deleteAccount() async {
    await accountDB.clearAccount();
    await dBToAccount();
    notifyListeners();
  }

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
    final getaccountLists = await accountDB.getAccount();
    accountList.clear();
    toaccountList.clear();
    fromaccountList.clear();
    accountList = getaccountLists;
    toaccountList = getaccountLists.map((e) => e.accName).toList();
    fromaccountList = getaccountLists.map((e) => e.accName).toList();
    toaccountList.add('choose another account');

    accTotal = sumofAccounts(getaccountLists);
    notifyListeners();
  }

  Future<void> dBDeleteAccount(String index) async {
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
    await accountDB.insertAccount(accountvalue);
    await dBToAccount();
  }

  void removeFromtoAccount(String value) {
    toaccountList.clear();
    toaccountList.add('choose another account');
    // if (deletefromToaccount== true) {
    toaccountList.addAll(accountList.map((e) => e.accName).toList());
    toaccountList.remove(value);

    // }
    // else if(deletefromToaccount == false){
    //   if(fromaccountList.length <= 1){

    //   }
    //     fromaccountList = accountList.map((e) => e.accName).toList();
    //   fromaccountList.remove(value);
    // }
    notifyListeners();
  }
}
