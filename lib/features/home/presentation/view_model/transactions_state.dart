import '../../data/models/transction_item.dart';
import '../widgets/filter_buttons.dart';

sealed class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final List<TransactionItem> allTransactions;
  final TransactionFilter selectedFilter;

  TransactionsLoaded({
    required this.allTransactions,
    required this.selectedFilter,
  });

  List<TransactionItem> get incomeTransactions =>
      allTransactions.where((t) => t.isIncome).toList();

  List<TransactionItem> get expenseTransactions =>
      allTransactions.where((t) => !t.isIncome).toList();

  double get totalIncome =>
      incomeTransactions.fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpenses =>
      expenseTransactions.fold(0.0, (sum, t) => sum + t.amount);

  double get currentBalance => totalIncome - totalExpenses;
}

class TransactionsError extends TransactionsState {
  final String message;

  TransactionsError(this.message);
}

class TransactionAdded extends TransactionsState {}

class TransactionUpdated extends TransactionsState {}

class TransactionDeleted extends TransactionsState {}
