import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foodmarket/models/models.dart';
import 'package:flutter_foodmarket/services/services.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState>{
  TransactionCubit() : super(TransactionInitial());

  Future<void> getTransactions() async {
    ApiReturnValue<List<Transaction>> result = await TransactionServices.getTransactions();

    if(result.value != null){
      emit(TransactionLoaded(result.value)); // Apabila result mempunyai data maka disimpan di TransactionLoaded
    } else { 
      // Jika result tidak mempunyai data maka, menerima pesan kegagalan dan pesan kegagalan 
      // disimpan di TransactionLoadingFailed
      emit(TransactionLoadingFailed(result.message));
    }
  }

  // bool, true jika submit berhasil dan false jika submit gagal
  Future<bool> submitTransaction(Transaction transaction) async {
    ApiReturnValue<Transaction> result = await TransactionServices.submitTransaction(transaction);

    if(result.value != null){
      // Apabila submit Transaction berhasil maka result/hasil kembalian ditambahkan ke Transaction yang telah didapatkan di getTransactions()
      emit(TransactionLoaded(
        (state as TransactionLoaded).transactions + [result.value]
      ));
      return true;
    } else { 
      // Jika result tidak mempunyai data atau gagal maka, mengembalikan false;
      return false;
    }
  }
  
}