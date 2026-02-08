import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/transction_item.dart';
import '../view_model/transactions_cubit.dart';
import '../view_model/transactions_state.dart';
import '../widgets/app_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/summary_cards.dart';
import '../widgets/transaction_section.dart';
import 'add_transaction_sheet.dart';
import 'edit_transaction_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showAddSheet(BuildContext context) {
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

  void _showEditSheet(BuildContext context, TransactionItem transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditTransactionSheet(
          transaction: transaction,
          cubit: context.read<TransactionsCubit>(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<TransactionsCubit, TransactionsState>(
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
                            onEdit: (t) => _showEditSheet(context, t),
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
                            onEdit: (t) => _showEditSheet(context, t),
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
        onPressed: () => _showAddSheet(context),
        backgroundColor: const Color(0xFF155DFC),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
