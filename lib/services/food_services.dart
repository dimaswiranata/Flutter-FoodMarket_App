part of 'services.dart';

class FoodServices {

  // static method getFoods untuk mendapat value foods hehe
  // tidak diperlukan parameter inputan dari user
  static Future<ApiReturnValue<List<Food>>> getFoods({http.Client client}) async {
    // DUMMY DATA
    // await Future.delayed(Duration(milliseconds: 500)); // delay koneksi dalam proses getFoods kira2, 0.5 detik
    // return ApiReturnValue(value: mockFoods); // menamilkan value yang sudah diterima

    client ??= http.Client(); // membuat http client yang baru

    // Inisialisasi base URL
    String url = baseUrl + 'food';

    // Mendapat response get dari API dan menyimpan di response
    var response = await client.get(url);

    // cek jika gagal mendapatkan data 
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again');
    } 

    // menconvert response API menjadi Json dan mennyimpan di data
    var data = jsonDecode(response.body);

    // todo: RESPONSE API
    // {
    //   "data": {
    //      "current_page": 1,
    //       "data": [
    //           {
    //              "id": 1,
    //              "picturePath": "http://foodmarket-backend.buildwithangga.id/storage/assets/food/Z8bVCbRMsuob0X7MVXNG5tfFptuSFG9OtN02IcCI.jpeg",
    //              "name": "Soup Bumil",
    //              "description": "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
    //              "ingredients": "Seledri, telur, blueberry, madu",
    //              "price": 289000,
    //              "rate": 4,
    //              "types": "new_food",
    //              "deleted_at": null,
    //              "created_at": 1600840945000,
    //              "updated_at": 1600840945000
    //           },
    //           {
    //              "id": 2,
    //              "picturePath": "http://foodmarket-backend.buildwithangga.id/storage/assets/food/w0t9SoAvRvjmhGaoLzMcHAMsm9OuqGxEDsGL7gKv.jpeg",
    //              "name": "Chicken",
    //              "description": "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
    //              "ingredients": "Seledri, telur, blueberry, madu",
    //              "price": 4509000,
    //              "rate": 5,
    //              "types": "new_food,recommended",
    //              "deleted_at": null,
    //              "created_at": 1600841059000,
    //              "updated_at": 1600841059000
    //           },
    //           {
    //              "id": 3,
    //              "picturePath": "http://foodmarket-backend.buildwithangga.id/storage/assets/food/dqGSTKOJE5zZNNH0BTfZjt3ogxRjLuwVpvP6Drx4.jpeg",
    //              "name": "Shrimp",
    //              "description": "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
    //              "ingredients": "Seledri, telur, blueberry, madu",
    //              "price": 999000,
    //              "rate": 3,
    //              "types": "popular",
    //              "deleted_at": null,
    //              "created_at": 1600841118000,
    //              "updated_at": 1600841118000
    //           }
    //       ]
    //     }
    // }, jadi pengambilan food sebegai berikut :

    // mengubah Json data menjadi bentuk Object array ke foods
    List<Food> foods = (data["data"]["data"] as Iterable)
      .map((e) => Food.fromJson(e))
      .toList();

    // mengembalikan value return yang sudah berbentuk array
    return ApiReturnValue(value: foods); 
  }
  
}