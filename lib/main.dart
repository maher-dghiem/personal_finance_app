import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:personal_finance_app/presentation/pages/home_page.dart';
import 'package:personal_finance_app/presentation/transaction_bloc.dart';
import 'package:personal_finance_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'data/models/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/repositrory/hive_transaction_repository.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');

  final repository = HiveTransactionRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        BlocProvider(create: (_) => TransactionBloc(repository: repository)..add(LoadTransactions())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: HomePage(),
      theme: themeProvider.themeData,
    );
  }
}