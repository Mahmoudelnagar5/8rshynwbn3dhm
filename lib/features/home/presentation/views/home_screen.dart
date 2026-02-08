import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/summary_cards.dart';
import '../widgets/transaction_section.dart';

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

  final List<TransactionItem> _incomeTransactions = [
    TransactionItem(
      title: 'salary',
      date: '2026-02-08',
      amount: 10000.00,
      onEdit: () {
        // Handle edit
      },
      onDelete: () {
        // Handle delete
      },
    ),
  ];

  final List<TransactionItem> _expenseTransactions = [
    TransactionItem(
      title: 'food',
      date: '2026-02-08',
      amount: 515.00,
      onEdit: () {
        // Handle edit
      },
      onDelete: () {
        // Handle delete
      },
    ),
  ];

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
        onPressed: () {
          // Handle add transaction
        },
        backgroundColor: const Color(0xFF155DFC),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
