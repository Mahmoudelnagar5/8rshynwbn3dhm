import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/show_add_sheet.dart';
import '../../../../core/functions/show_edit_sheet.dart';
import '../../../../core/functions/snackbar_utils.dart';
import '../view_model/transactions_cubit.dart';
import '../view_model/transactions_state.dart';
import '../widgets/app_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/summary_cards.dart';
import '../widgets/transaction_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<TransactionsCubit, TransactionsState>(
        listener: (context, state) {
          if (state is TransactionAdded) {
            showSuccessSnackBar(context, 'Transaction added successfully');
          } else if (state is TransactionUpdated) {
            showInfoSnackBar(context, 'Transaction updated successfully');
          } else if (state is TransactionDeleted) {
            showErrorSnackBar(context, 'Transaction deleted successfully');
          }
        },
        builder: (context, state) {
          if (state is TransactionsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionsError) {
            return Center(child: Text(state.message));
          }

          if (state is TransactionsLoaded) {
            return Column(
              children: [
                const AppHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        BalanceCard(balance: state.currentBalance),
                        const SizedBox(height: 12),
                        SummaryCards(
                          income: state.totalIncome,
                          expenses: state.totalExpenses,
                        ),
                        const SizedBox(height: 24),
                        FilterButtons(
                          selectedFilter: state.selectedFilter,
                          onFilterChanged: (filter) {
                            context.read<TransactionsCubit>().changeFilter(
                              filter,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        if (state.selectedFilter == TransactionFilter.all ||
                            state.selectedFilter ==
                                TransactionFilter.income) ...[
                          TransactionSection(
                            title: 'Income',
                            count: state.incomeTransactions.length,
                            isIncome: true,
                            transactions: state.incomeTransactions,
                            onEdit: (t) => showEditSheet(context, t),
                            onDelete: (t) => context
                                .read<TransactionsCubit>()
                                .deleteTransaction(t.id),
                          ),
                          const SizedBox(height: 24),
                        ],
                        if (state.selectedFilter == TransactionFilter.all ||
                            state.selectedFilter ==
                                TransactionFilter.expenses) ...[
                          TransactionSection(
                            title: 'Expenses',
                            count: state.expenseTransactions.length,
                            isIncome: false,
                            transactions: state.expenseTransactions,
                            onEdit: (t) => showEditSheet(context, t),
                            onDelete: (t) => context
                                .read<TransactionsCubit>()
                                .deleteTransaction(t.id),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddSheet(context),
        backgroundColor: const Color(0xFF155DFC),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
