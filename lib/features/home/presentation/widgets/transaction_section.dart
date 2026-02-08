import 'package:flutter/material.dart';
import '../../data/models/transction_item.dart';
import 'transaction_card.dart';

class TransactionSection extends StatelessWidget {
  final String title;
  final int count;
  final bool isIncome;
  final List<TransactionItem> transactions;

  const TransactionSection({
    super.key,
    required this.title,
    required this.count,
    required this.isIncome,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isIncome
        ? const Color(0xFF008236)
        : const Color(0xFFC10007);
    final icon = isIncome ? Icons.trending_up : Icons.trending_down;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 8),
            Text(
              '$title ($count)',
              style: TextStyle(
                color: iconColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Transaction Cards
        ...transactions.map(
          (transaction) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TransactionCard(
              title: transaction.title,
              date: transaction.date,
              amount: transaction.amount,
              isIncome: isIncome,
              onEdit: transaction.onEdit,
              onDelete: transaction.onDelete,
            ),
          ),
        ),
      ],
    );
  }
}
