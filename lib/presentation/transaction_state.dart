part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}


final class TransactionLoading extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionLoaded(this.transactions);
}

final class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
