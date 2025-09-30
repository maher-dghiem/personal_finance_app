import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:personal_finance_app/presentation/transaction_bloc.dart' show TransactionBloc, AddTransactionEvent;

import '../../data/models/transaction.dart';
import '../transaction_bloc.dart' show TransactionBloc;

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'General';
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title',
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,),),
              validator: (value) =>
              value == null || value.isEmpty ? 'Enter a title' : null,
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount',
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,),),
              keyboardType: TextInputType.number,
              validator: (value) =>
              value == null || double.tryParse(value) == null
                  ? 'Enter a valid amount'
                  : null,
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: ['General', 'Food', 'Transport', 'Shopping', 'Bills', 'Entertainment', 'Health']
                  .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,),),
              ))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
              decoration: InputDecoration(labelText: 'Category',
                labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,),),
            ),
            ListTile(
              title: Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,),),
              trailing: Icon(Icons.calendar_today,
              color: Theme.of(context).colorScheme.primary,),
              onTap: _pickDate,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Add Transaction',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,),),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(title: Text('Add Transaction',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.secondary,),));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final transaction = Transaction(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        category: _selectedCategory,
      );

      context.read<TransactionBloc>().add(AddTransactionEvent(transaction: transaction));
      Navigator.pop(context);
    }
  }
}