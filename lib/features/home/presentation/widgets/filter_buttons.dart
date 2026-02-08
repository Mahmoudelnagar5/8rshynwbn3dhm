import 'package:flutter/material.dart';

enum TransactionFilter { all, income, expenses }

class FilterButtons extends StatelessWidget {
  final TransactionFilter selectedFilter;
  final Function(TransactionFilter) onFilterChanged;

  const FilterButtons({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterButton(
          label: 'All',
          icon: Icons.list,
          isSelected: selectedFilter == TransactionFilter.all,
          onTap: () => onFilterChanged(TransactionFilter.all),
        ),
        const SizedBox(width: 8),
        _FilterButton(
          label: 'Income',
          icon: Icons.trending_up,
          isSelected: selectedFilter == TransactionFilter.income,
          onTap: () => onFilterChanged(TransactionFilter.income),
        ),
        const SizedBox(width: 8),
        _FilterButton(
          label: 'Expenses',
          icon: Icons.trending_down,
          isSelected: selectedFilter == TransactionFilter.expenses,
          onTap: () => onFilterChanged(TransactionFilter.expenses),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF155DFC) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? null
              : Border.all(color: Colors.black.withOpacity(0.1), width: 1.21),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF0A0A0A),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF0A0A0A),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
