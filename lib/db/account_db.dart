import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const accountDBName = 'account_database';

abstract class AccountDBFunctions {
  Future<void> insertAccount(AccountModel value);
  Future<List<AccountModel>> getAccount();
  Future<void> clearAccount();
}

class AccountDB implements AccountDBFunctions {
  @override
  Future<void> insertAccount(AccountModel value) async {
    final accountDB = await Hive.openBox<AccountModel>(accountDBName);
    accountDB.put(value.id, value);
  }

  @override
  Future<void> clearAccount() async {
    final accountDB = await Hive.openBox<AccountModel>(accountDBName);
    accountDB.clear();
  }

  @override
  Future<List<AccountModel>> getAccount() async {
    final accountDB = await Hive.openBox<AccountModel>(accountDBName);
    return accountDB.values.toList();
  }

  Future<void> deleteAccount(String index) async {
    final accountDB = await Hive.openBox<AccountModel>(accountDBName);
    accountDB.delete(index);
  }
}
