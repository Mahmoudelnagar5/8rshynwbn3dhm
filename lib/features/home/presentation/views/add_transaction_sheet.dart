import 'package:flutter/material.dart';
import '../../data/models/transction_item.dart';
import '../view_model/transactions_cubit.dart';
import '../widgets/form_header.dart';
import '../widgets/form_text_field.dart';
import '../widgets/transaction_type_selector.dart';
import '../widgets/form_date_field.dart';
import '../widgets/form_action_buttons.dart';

class AddTransactionSheet extends StatefulWidget {
  final TransactionsCubit cubit;

  const AddTransactionSheet({super.key, required this.cubit});

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  TransactionType _selectedType = TransactionType.expense;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormHeader(
            title: 'Add New Transaction',
            onClose: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 48),
          FormTextField(
            label: 'Transaction Name',
            hintText: 'e.g. Groceries, Salary, Transportation...',
            controller: _nameController,
          ),
          const SizedBox(height: 20),
          FormTextField(
            label: 'Amount (\$)',
            hintText: '0.00',
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 20),
          TransactionTypeSelector(
            selectedType: _selectedType,
            onTypeChanged: (type) {
              setState(() {
                _selectedType = type;
              });
            },
          ),
          const SizedBox(height: 20),
          FormDateField(
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          const SizedBox(height: 20),
          FormActionButtons(
            submitLabel: 'Save',
            onCancel: () => Navigator.of(context).pop(),
            onSubmit: () {
              final name = _nameController.text.trim();
              final amount =
                  double.tryParse(_amountController.text.trim()) ?? 0;
              if (name.isNotEmpty && amount > 0 && _selectedDate != null) {
                final date = _selectedDate!;
                final item = TransactionItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: name,
                  date: date,
                  amount: amount,
                  isIncome: _selectedType == TransactionType.income,
                );
                widget.cubit.addTransaction(item);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
