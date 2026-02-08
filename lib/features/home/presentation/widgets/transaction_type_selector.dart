import 'package:flutter/material.dart';

enum TransactionType { expense, income }

class TransactionTypeSelector extends StatelessWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onTypeChanged;

  const TransactionTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaction Type',
          style: TextStyle(color: Color(0xFF0A0A0A), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _TypeButton(
                label: 'Expense',
                isSelected: selectedType == TransactionType.expense,
                selectedColor: const Color(0xFFFEF2F2),
                selectedBorderColor: const Color(0xFFFB2C36),
                selectedTextColor: const Color(0xFFC10007),
                onTap: () => onTypeChanged(TransactionType.expense),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TypeButton(
                label: 'Income',
                isSelected: selectedType == TransactionType.income,
                selectedColor: const Color(0xFFF0FDF4),
                selectedBorderColor: const Color(0xFF00C950),
                selectedTextColor: const Color(0xFF008236),
                onTap: () => onTypeChanged(TransactionType.income),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final Color selectedBorderColor;
  final Color selectedTextColor;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.selectedBorderColor,
    required this.selectedTextColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : const Color(0xFFECECF0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? selectedBorderColor
                : Colors.black.withOpacity(0.1),
            width: 1.21,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedTextColor : const Color(0xFF0A0A0A),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
