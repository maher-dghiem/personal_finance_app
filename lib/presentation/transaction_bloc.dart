import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:personal_finance_app/data/models/transaction.dart';
import 'package:personal_finance_app/domain/repository/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;
  TransactionBloc({required this.repository}) : super(TransactionLoading()) {
    on<TransactionEvent>((event, emit) async {
      if(event is LoadTransactions){
        try{
         final transactions = await repository.getAllTransactions();
         emit(TransactionLoaded(transactions));
        }
        catch(e){
            emit(TransactionError("Failed to load transactions"));
        }
      }
      else if (event is AddTransactionEvent){
          repository.addTransaction(event.transaction);
          add(LoadTransactions());
      }
      else if (event is DeleteTransactionEvent) {
        repository.deleteTransaction(event.key);
        add(LoadTransactions());
      }
    });
  }
}
