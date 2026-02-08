import 'package:flutter/material.dart';
import '../../data/models/transction_item.dart';
import '../widgets/app_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/summary_cards.dart';
import '../widgets/transaction_section.dart';
import '../widgets/transaction_type_selector.dart';
import 'add_transaction_sheet.dart';
import 'edit_transaction_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TransactionFilter _selectedFilter = TransactionFilter.all;

  final double _currentBalance = 9485.00;
  final double _totalIncome = 10000.00;
  final double _totalExpenses = 515.00;

  List<TransactionItem> _incomeTransactions = [];
  List<TransactionItem> _expenseTransactions = [];

  @override
  void initState() {
    super.initState();
    _incomeTransactions = [
      TransactionItem(
        title: 'salary',
        date: '2026-02-08',
        amount: 10000.00,
        onEdit: () => _showEditSheet(
          TransactionItem(
            title: 'salary',
            date: '2026-02-08',
            amount: 10000.00,
          ),
          true,
        ),
        onDelete: () {
          // Handle delete
        },
      ),
    ];
    _expenseTransactions = [
      TransactionItem(
        title: 'food',
        date: '2026-02-08',
        amount: 515.00,
        onEdit: () => _showEditSheet(
          TransactionItem(title: 'food', date: '2026-02-08', amount: 515.00),
          false,
        ),
        onDelete: () {
          // Handle delete
        },
      ),
    ];
  }

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddTransactionSheet(),
      ),
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        // Handle the new transaction data
        final isIncome = result['type'] == TransactionType.income;
        final date = result['date'] as DateTime;
        final dateStr =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        final item = TransactionItem(
          title: result['name'],
          date: dateStr,
          amount: result['amount'],
        );
        setState(() {
          if (isIncome) {
            _incomeTransactions.add(item);
          } else {
            _expenseTransactions.add(item);
          }
        });
      }
    });
  }

  void _showEditSheet(TransactionItem transaction, bool isIncome) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditTransactionSheet(
          transaction: transaction,
          isIncome: isIncome,
        ),
      ),
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        // Handle the updated transaction data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // App Header
          const AppHeader(),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Balance Card
                  BalanceCard(balance: _currentBalance),
                  const SizedBox(height: 12),
                  // Income and Expenses Summary Cards
                  SummaryCards(income: _totalIncome, expenses: _totalExpenses),
                  const SizedBox(height: 24),
                  // Filter Buttons
                  FilterButtons(
                    selectedFilter: _selectedFilter,
                    onFilterChanged: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  // Transaction Sections
                  if (_selectedFilter == TransactionFilter.all ||
                      _selectedFilter == TransactionFilter.income) ...[
                    TransactionSection(
                      title: 'Income',
                      count: _incomeTransactions.length,
                      isIncome: true,
                      transactions: _incomeTransactions,
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (_selectedFilter == TransactionFilter.all ||
                      _selectedFilter == TransactionFilter.expenses) ...[
                    TransactionSection(
                      title: 'Expenses',
                      count: _expenseTransactions.length,
                      isIncome: false,
                      transactions: _expenseTransactions,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSheet,
        backgroundColor: const Color(0xFF155DFC),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
