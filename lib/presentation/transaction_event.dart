part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class LoadTransactions extends TransactionEvent {}

final class AddTransactionEvent extends TransactionEvent{
  final Transaction transaction;

  AddTransactionEvent({required this.transaction});
}

final class DeleteTransactionEvent extends TransactionEvent{
  final int key;

  DeleteTransactionEvent({required this.key});
}
