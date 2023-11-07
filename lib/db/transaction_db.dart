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
