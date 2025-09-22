import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_finance_app/data/models/transaction.dart';
import '../../domain/repository/transaction_repository.dart';

class HiveTransactionRepository implements TransactionRepository{
  final Box<Transaction> _box = Hive.box<Transaction>('transactions');
  @override
  Future<void> addTransaction(Transaction transaction) async {
     await _box.add(transaction);
  }

  @override
  Future<void> deleteTransaction(int key) async {
    await _box.delete(key);
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    return _box.values.toList();
  }

}