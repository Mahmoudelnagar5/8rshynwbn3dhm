import 'package:flutter/material.dart';

class SummaryCards extends StatelessWidget {
  final double income;
  final double expenses;

  const SummaryCards({super.key, required this.income, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'Income',
            amount: income,
            backgroundColor: const Color(0xFFF0FDF4),
            borderColor: const Color(0xFFB9F8CF),
            iconBackgroundColor: const Color(0xFFDCFCE7),
            icon: Icons.trending_up,
            iconColor: const Color(0xFF008236),
            textColor: const Color(0xFF008236),
            amountColor: const Color(0xFF00A63E),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Expenses',
            amount: expenses,
            backgroundColor: const Color(0xFFFEF2F2),
            borderColor: const Color(0xFFFFC9C9),
            iconBackgroundColor: const Color(0xFFFFE2E2),
            icon: Icons.trending_down,
            iconColor: const Color(0xFFC10007),
            textColor: const Color(0xFFC10007),
            amountColor: const Color(0xFFE7000B),
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconBackgroundColor;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color amountColor;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconBackgroundColor,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 17, top: 17, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1.21),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Label
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: textColor, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 28),
          // Amount
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: amountColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
