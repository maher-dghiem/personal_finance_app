import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_app/data/models/transaction.dart';
import 'package:personal_finance_app/presentation/pages/settings_page.dart';
import 'package:personal_finance_app/presentation/pages/summary_screen_page.dart';
import 'package:personal_finance_app/presentation/transaction_bloc.dart';

import 'add_transaction_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          final transactions = state.transactions;

          return Scaffold(
            drawer: _buildDrawer(context),
            appBar: _buildAppBar(context, transactions),
            body: _buildListView(transactions),
            floatingActionButton: _buildFloatingActionButton(context)
          );
        } else if(state is TransactionLoading){
          return Scaffold(appBar: AppBar(
            title: Text('Expense Tracker'),),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        else if (state is TransactionError) {
          return Scaffold(appBar: AppBar(
            title: Text('Expense Tracker'),),
            body: Center(child: Text(state.message)),
          );
        }
        else {
          return SizedBox();
        }
        }
    );
  }




  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddTransactionPage()));
            },
              child: Text("Add"),
            );
  }

  ListView _buildListView(List<Transaction> transactions) {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 80), // space for FAB
      itemCount: transactions.length + 1, // +1 for the header image
      itemBuilder: (context, index) {
      if (index == 0) {
      return Container(
      padding: EdgeInsets.all(20),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset("assets/images/img1.png"),
      ),
      );
      }

      final tx = transactions[index - 1];
      return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.teal, Colors.greenAccent]),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(getCategoryIcon(tx.category), color: Colors.white)),
      Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text(tx.title, style: TextStyle(color: Colors.white, fontSize: 16)),
      Text('${tx.amount}\$ • ${tx.category}', style: TextStyle(color: Colors.white70)),
      Text('${tx.date.day}-${tx.date.month}-${tx.date.year}', style: TextStyle(color: Colors.white70)),
      ],
      ),
      IconButton(
      icon: Icon(Icons.delete, color: Colors.white),
      onPressed: () {
      context.read<TransactionBloc>().add(DeleteTransactionEvent(key: tx.key));
      },
      ),
      ],
      ),
      );
      },
      );
  }

  AppBar _buildAppBar(BuildContext context, List<Transaction> transactions) {
    return AppBar(
            title: Text('Expense Tracker',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,),),
            actions: [
              IconButton(
                icon: Icon(Icons.bar_chart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SummaryScreenPage(transactions: transactions),
                    ),
                  );
                },
              ),
            ],
          );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 150,),
                  ListTile(
                    leading: Icon(Icons.settings, size: 40,
                    color: Theme.of(context).colorScheme.primary,),
                    title: Text("Settings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,),),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder:
                      (context) => SettingsPage()));
                    },
                  )
                ],
              ),
            ),
          );
  }

  IconData? getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant;
      case 'Transport':
        return Icons.directions_car;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Bills':
        return Icons.receipt_long;
      case 'Entertainment':
        return Icons.movie;
      case 'Health':
        return Icons.local_hospital;
      case 'General':
        return Icons.category;
      default:
        return Icons.help_outline;
    }
  }
}
