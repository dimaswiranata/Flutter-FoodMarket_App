part of 'services.dart';

class TransactionServices {

  // static method getTransactions untuk mendapat value Transaction hehe
  // tidak diperlukan parameter
  static Future<ApiReturnValue<List<Transaction>>> getTransactions() async {
    await Future.delayed(Duration(seconds: 3)); // delay koneksi dalam proses getTransactions kira2, 0.5 detik

    return ApiReturnValue(value: mockTransaction); // menamilkan value yang sudah diterima
  }

  // static method submitTransaction untuk menginput transaction terbaru dari User
  // parameter yang diperlukan yaitu Transaction
  static Future<ApiReturnValue<Transaction>> submitTransaction(Transaction transaction) async {
    await Future.delayed(Duration(seconds: 2)); // delay koneksi dalam proses submitTransaction kira2, 0.5 detik

    // Jika berhasil maka mengembalikan Transcation baru dengan dummy id dan 
    // status(dummy data => submitTransaction baru default status.pending) tsb
    return ApiReturnValue(value: transaction.copyWith(id: 123, status: TransactionStatus.pending)); 
    // JIka Gagal
    // return ApiReturnValue(message: 'Transaksi Gagal'); 
  }
  
}