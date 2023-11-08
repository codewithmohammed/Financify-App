import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const TRANSACTION_DB_NAME = 'main_transaction_db';

abstract class TransactionDBFunctions {
  Future<void> insertTransaction(TransactionModel value);
  Future<List<TransactionModel>> getTransaction();
  Future<void> clearTransaction();
}

class TransactionDB implements TransactionDBFunctions {
  @override
  Future<void> clearTransaction() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDB.clear();
  }

  Future<void> deleteTransaction(String value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    final keysToDelete = <int>[];
    for (var i = 0; i < transactionDB.length; i++) {
      final item = transactionDB.getAt(i);
      if (item != null && item.accountname == value) {
        keysToDelete.add(i);
      }
    }
    for (var key in keysToDelete) {
      await transactionDB.deleteAt(key);
    }
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transactionDB.values.toList();
  }

  @override
  Future<void> insertTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transactionDB.put(value.id, value);
  }
}
