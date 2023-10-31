import 'package:financify/model/category/transactioncategory/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';


abstract class TransactionDBFunctions {
  Future<void> insertTransaction(TransactionModel value);
  Future<TransactionModel?> getTransaction();
  Future<void> clearTransaction();
}

class TransactionDB implements TransactionDBFunctions {
  @override
  Future<void> clearTransaction() {
    // TODO: implement clearTransaction
    throw UnimplementedError();
  }

  @override
  Future<TransactionModel> getTransaction() {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> insertTransaction(value) {
    // TODO: implement insertTransaction
    throw UnimplementedError();
  }

}