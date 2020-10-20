part of 'services.dart';

class TransactionServices {

  // static method getTransactions untuk mendapat value Transaction hehe
  // tidak diperlukan parameter
  static Future<ApiReturnValue<List<Transaction>>> getTransactions({http.Client client}) async {
    // await Future.delayed(Duration(seconds: 3)); // delay koneksi dalam proses getTransactions kira2, 0.5 detik
    // return ApiReturnValue(value: mockTransaction); // menamilkan value yang sudah diterima

    client ??= http.Client(); // membuat koneksi http baru

    // Inisialisasi base URL
    String url = baseUrl + 'transaction/?limit=1000';

    // Mendapat response get dari API dan menyimpan di response
    var response = await client.get(
      url,
      headers: {
        "Content-Type" : "application/json",
        "Authorization" : "Bearer ${User.token}"
      }
    );

    // cek jika gagal mendapatkan data 
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again');
    } 

    // menconvert response API menjadi Json dan mennyimpan di data
    var data = jsonDecode(response.body);

    // todo: RESPONSE API
    // {
    //   "data": {
    //     "current_page": 1,
    //     "data": [
    //       {
    //         "id": 1,
    //         "food_id": 1,
    //         "user_id": 1,
    //         "quantity": 1,
    //         "total": 100000,
    //         "status": "DELIVERED",
    //         "payment_url": "https://app.sandbox.midtrans.com/snap/v2/vtweb/bcd3e4b7-6d01-435c-88ab-b3da45b9c66a#/select-payment",
    //         "deleted_at": null,
    //         "created_at": "2020-09-18T18:18:23.000000Z",
    //         "updated_at": "2020-09-18T18:18:23.000000Z",
    //         "food": {
    //           "id": 1,
    //           "picturePath": "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
    //           "name": "Sate Sayur Sultan",
    //           "description": "Sate Sayur Sultan adalah menu sate vegan paling terkenal di Bandung. Sate ini dibuat dari berbagai macam bahan bermutu tinggi. Semua bahan ditanam dengan menggunakan teknologi masa kini sehingga memiliki nutrisi yang kaya.",
    //           "ingredients": "Bawang Merah, Paprika, Bawang Bombay, Timun",
    //           "price": 150000,
    //           "rate": 4.2,
    //           "types": "recommended,popular",
    //           "deleted_at": null,
    //           "created_at": "2020-09-17T13:43:54.000000Z",
    //           "updated_at": "2020-09-17T13:43:54.000000Z"
    //         },
    //         "user": {
    //           "id": 1,
    //           "name": "Galih Pratama",
    //           "email": "hanamura.iost@gmail.com",
    //           "email_verified_at": null,
    //           "roles": "USER",
    //           "current_team_id": null,
    //           "picturePath": null,
    //           "address": null,
    //           "houseNumber": null,
    //           "phoneNumber": null,
    //           "city": null,
    //           "created_at": "2020-09-17T06:05:01.000000Z",
    //           "updated_at": "2020-09-17T06:05:01.000000Z",
    //           "profile_photo_url": "https://ui-avatars.com/api/?name=Galih+Pratama&color=7F9CF5&background=EBF4FF"
    //         }
    //       }
    //     ]
    //   }
    // }, jadi pengambilan user sebegai berikut :

    // mengubah Json data menjadi bentuk Object array ke transactions
    List<Transaction> transactions = (data["data"]["data"] as Iterable)
      .map((e) => Transaction.fromJson(e))
      .toList();
    
    // mengembalikan value return yang sudah berbentuk array
    return ApiReturnValue(value: transactions); 
  }

  // static method submitTransaction untuk menginput transaction terbaru dari User
  // parameter yang diperlukan yaitu Transaction
  static Future<ApiReturnValue<Transaction>> submitTransaction(Transaction transaction, {http.Client client}) async {
    client ??= http.Client(); // membuat koneksi http baru

    // Inisialisasi base URL
    String url = baseUrl + 'checkout';

    // Mendapat response get dari API dan menyimpan di response
    var response = await client.post(
      url,
      headers: {
        "Content-Type" : "application/json",
        "Authorization" : "Bearer ${User.token}"
      },
      body: // yang  dibutuhkan untuk submit transaction
        jsonEncode(<String, dynamic>{ // jsonEncode mengubah object ke json lagi
          'food_id' : transaction.food.id,
          'user_id' : transaction.user.id,
          'quantity' : transaction.quantity,
          'total' : transaction.total,
          'status' : 'PENDING'
        }
      )
    );

    // cek jika gagal mendapatkan response 
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again');
    }

    // mendapat respon dari API yang tersimpan di response, terus diconvert menjadi Json
    var data = jsonDecode(response.body);
    
    // merubah data yang sudah menjadi Json tadi menjadi Object
    Transaction value = Transaction.fromJson(data['data']);

    return ApiReturnValue(value: value);
  }
  
}