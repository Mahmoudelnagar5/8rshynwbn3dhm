import 'package:flutter/material.dart';
import '../../data/models/transction_item.dart';
import '../view_model/transactions_cubit.dart';
import '../widgets/form_header.dart';
import '../widgets/form_text_field.dart';
import '../widgets/transaction_type_selector.dart';
import '../widgets/form_date_field.dart';
import '../widgets/form_action_buttons.dart';

class EditTransactionSheet extends StatefulWidget {
  final TransactionItem transaction;
  final TransactionsCubit cubit;

  const EditTransactionSheet({
    super.key,
    required this.transaction,
    required this.cubit,
  });

  @override
  State<EditTransactionSheet> createState() => _EditTransactionSheetState();
}

class _EditTransactionSheetState extends State<EditTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late TransactionType _selectedType;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.transaction.title);
    _amountController = TextEditingController(
      text: widget.transaction.amount.toStringAsFixed(0),
    );
    _selectedType = widget.transaction.isIncome
        ? TransactionType.income
        : TransactionType.expense;
    final parts = widget.transaction.date;
    _selectedDate = DateTime(parts.year, parts.month, parts.day);
  }

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
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            FormHeader(
              title: 'Edit Transaction',
              onClose: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 48),
            FormTextField(
              label: 'Transaction Name',
              hintText: 'e.g. Groceries, Salary, Transportation...',
              controller: _nameController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'This field is required' : null,
            ),
            const SizedBox(height: 20),
            FormTextField(
              label: 'Amount (\$)',
              hintText: '0.00',
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'This field is required';
                final num = double.tryParse(value!);
                if (num == null || num <= 0) {
                  return 'Enter a valid amount greater than 0';
                }
                return null;
              },
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
              submitLabel: 'Update',
              onCancel: () => Navigator.of(context).pop(),
              onSubmit: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final name = _nameController.text.trim();
                  final amount =
                      double.tryParse(_amountController.text.trim()) ?? 0;
                  final date = _selectedDate!;
                  final updatedItem = TransactionItem(
                    id: widget.transaction.id,
                    title: name,
                    date: date,
                    amount: amount,
                    isIncome: _selectedType == TransactionType.income,
                  );
                  widget.cubit.updateTransaction(updatedItem);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
}
