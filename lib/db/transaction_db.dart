import 'package:financify/model/category/transactioncategory/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const transactionDBName = 'main_transaction_db';

abstract class TransactionDBFunctions {
  Future<void> insertTransaction(TransactionModel value);
  Future<List<TransactionModel>> getTransaction();
  Future<void> clearTransaction();
}

class TransactionDB implements TransactionDBFunctions {
  @override
  Future<void> clearTransaction() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactionDB.clear();
  }

    Future<void> deleteTransaction(String id) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    await transactionDB.delete(id);
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    return transactionDB.values.toList();
  }

  @override
  Future<void> insertTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDBName);
    transactionDB.put(value.id, value);
  }
}
