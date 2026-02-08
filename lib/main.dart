import 'package:expense_tracker/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:expense_tracker/features/home/data/models/transction_item.dart';
import 'package:expense_tracker/features/home/data/repo/transactions_repo.dart';
import 'package:expense_tracker/features/home/presentation/view_model/transactions_cubit.dart';
import 'package:expense_tracker/features/home/presentation/views/home_screen.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionItemAdapter());
  await Hive.openBox<TransactionItem>('transactions');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) =>
              TransactionsCubit(TransactionsRepo())..loadTransactions(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
