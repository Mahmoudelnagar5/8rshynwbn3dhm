import 'package:hive/hive.dart';
import '../models/transction_item.dart';

class TransactionsRepo {
  static const String _boxName = 'transactions';

  Future<Box<TransactionItem>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<TransactionItem>(_boxName);
    }
    return Hive.box<TransactionItem>(_boxName);
  }

  Future<List<TransactionItem>> getAllTransactions() async {
    final box = await _getBox();
    return box.values.toList();
  }

  Future<void> addTransaction(TransactionItem item) async {
    final box = await _getBox();
    await box.put(item.id, item);
  }

  Future<void> updateTransaction(TransactionItem item) async {
    final box = await _getBox();
    await box.put(item.id, item);
  }

  Future<void> deleteTransaction(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }
}
