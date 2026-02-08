import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/view_model/transactions_cubit.dart';
import '../../features/home/presentation/views/add_transaction_sheet.dart';

void showAddSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: AddTransactionSheet(cubit: context.read<TransactionsCubit>()),
    ),
  );
}
