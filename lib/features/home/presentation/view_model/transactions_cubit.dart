import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/transction_item.dart';
import '../../data/repo/transactions_repo.dart';
import '../widgets/filter_buttons.dart';
import 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionsRepo _repo;

  TransactionsCubit(this._repo) : super(TransactionsInitial());

  Future<void> loadTransactions() async {
    emit(TransactionsLoading());
    try {
      final transactions = await _repo.getAllTransactions();
      emit(TransactionsLoaded(
        allTransactions: transactions,
        selectedFilter: TransactionFilter.all,
      ));
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  void changeFilter(TransactionFilter filter) {
    final currentState = state;
    if (currentState is TransactionsLoaded) {
      emit(TransactionsLoaded(
        allTransactions: currentState.allTransactions,
        selectedFilter: filter,
      ));
    }
  }

  Future<void> addTransaction(TransactionItem item) async {
    try {
      await _repo.addTransaction(item);
      emit(TransactionAdded());
      final transactions = await _repo.getAllTransactions();
      final currentFilter = state is TransactionsLoaded
          ? (state as TransactionsLoaded).selectedFilter
          : TransactionFilter.all;
      emit(TransactionsLoaded(
        allTransactions: transactions,
        selectedFilter: currentFilter,
      ));
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  Future<void> updateTransaction(TransactionItem item) async {
    try {
      await _repo.updateTransaction(item);
      emit(TransactionUpdated());
      final transactions = await _repo.getAllTransactions();
      final currentFilter = state is TransactionsLoaded
          ? (state as TransactionsLoaded).selectedFilter
          : TransactionFilter.all;
      emit(TransactionsLoaded(
        allTransactions: transactions,
        selectedFilter: currentFilter,
      ));
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await _repo.deleteTransaction(id);
      emit(TransactionDeleted());
      final transactions = await _repo.getAllTransactions();
      final currentFilter = state is TransactionsLoaded
          ? (state as TransactionsLoaded).selectedFilter
          : TransactionFilter.all;
      emit(TransactionsLoaded(
        allTransactions: transactions,
        selectedFilter: currentFilter,
      ));
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }
}
