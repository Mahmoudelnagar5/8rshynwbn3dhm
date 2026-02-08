import 'package:flutter/material.dart';

class TransactionItem {
  final String title;
  final String date;
  final double amount;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  TransactionItem({
    required this.title,
    required this.date,
    required this.amount,
    this.onEdit,
    this.onDelete,
  });
}
