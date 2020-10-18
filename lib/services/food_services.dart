part of 'services.dart';

class FoodServices {

  // static method getFoods untuk mendapat value foods hehe
  // tidak diperlukan parameter
  static Future<ApiReturnValue<List<Food>>> getFoods() async {
    await Future.delayed(Duration(milliseconds: 500)); // delay koneksi dalam proses getFoods kira2, 0.5 detik

    return ApiReturnValue(value: mockFoods); // menamilkan value yang sudah diterima
  }
  
}