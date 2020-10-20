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

  // jadi kembali dari submitTransaction adalah payment url untuk mi trans
  Future<String> submitTransaction(Transaction transaction) async {
    ApiReturnValue<Transaction> result = await TransactionServices.submitTransaction(transaction);

    if(result.value != null){
      // Apabila submit Transaction berhasil maka result/hasil kembalian ditambahkan ke Transaction yang telah didapatkan di getTransactions()
      emit(TransactionLoaded(
        (state as TransactionLoaded).transactions + [result.value]
      ));
      // kemudian mengembalikan payment url
      return result.value.paymentUrl;
    } else { 
      // Jika result tidak mempunyai data atau gagal maka, mengembalikan null;
      return null;
    }
  }
  
}