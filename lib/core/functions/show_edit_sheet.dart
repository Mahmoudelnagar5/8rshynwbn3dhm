import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/data/models/transction_item.dart';
import '../../features/home/presentation/view_model/transactions_cubit.dart';
import '../../features/home/presentation/views/edit_transaction_sheet.dart';

void showEditSheet(BuildContext context, TransactionItem transaction) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (builderContext) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(builderContext).viewInsets.bottom,
      ),
      child: EditTransactionSheet(
        transaction: transaction,
        cubit: context.read<TransactionsCubit>(),
      ),
    ),
  );
}
