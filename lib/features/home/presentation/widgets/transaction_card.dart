import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final bool isIncome;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TransactionCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.isIncome,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final iconBackgroundColor = isIncome
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFFFE2E2);
    final iconColor = isIncome
        ? const Color(0xFF008236)
        : const Color(0xFFC10007);
    final amountColor = isIncome
        ? const Color(0xFF00A63E)
        : const Color(0xFFE7000B);
    final icon = isIncome ? Icons.trending_up : Icons.trending_down;

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          if (onEdit != null)
            SlidableAction(
              onPressed: (_) => onEdit!(),
              backgroundColor: const Color(0xFF155DFC),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          if (onDelete != null)
            SlidableAction(
              onPressed: (_) => onDelete!(),
              backgroundColor: const Color(0xFFE7000B),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 17,
          top: 17,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1.21),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            // Title and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF0A0A0A),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Color(0xFF717182),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              '${isIncome ? '+' : '-'}\$${amount.abs().toStringAsFixed(2)}',
              style: TextStyle(
                color: amountColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
