import 'package:hive/hive.dart';

part 'transction_item.g.dart';

@HiveType(typeId: 0)
class TransactionItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final bool isIncome;

  TransactionItem({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.isIncome,
  });
}
