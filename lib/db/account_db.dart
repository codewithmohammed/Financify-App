import 'package:financify/model/category/accountcategory/account_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const ACCOUNT_DB_NAME = 'account_database';

abstract class AccountDBFunctions {
  Future<void> insertAccount(AccountModel value);
  Future<List<AccountModel>> getAccount();
  Future<void> clearAccount();
}

class AccountDB implements AccountDBFunctions {
  @override
  Future<void> insertAccount(AccountModel value) async {
    final accountDB = await Hive.openBox<AccountModel>(ACCOUNT_DB_NAME);
    accountDB.put(value.id, value);
  }

  @override
  Future<void> clearAccount() async {
    final accountDB = await Hive.openBox<AccountModel>(ACCOUNT_DB_NAME);
    accountDB.clear();
  }

  @override
  Future<List<AccountModel>> getAccount() async {
    final accountDB = await Hive.openBox<AccountModel>(ACCOUNT_DB_NAME);
    return accountDB.values.toList();
  }

  Future<void> deleteAccount(String index) async {
    final accountDB = await Hive.openBox<AccountModel>(ACCOUNT_DB_NAME);
    accountDB.delete(index);
  }
}

//   @override
//   Future<ProfileModel?> getProfile() async {
//     final profileDB = await Hive.openBox<ProfileModel>(PROFILE_DB_NAME);
//     return profileDB.get(PROFILE_KEY);
//   }

//   @override
//   Future<void> clearProfile() async {
//     final profileDB = await Hive.openBox<ProfileModel>(PROFILE_DB_NAME);
//     profileDB.clear();
//   }
// }


