part of 'services.dart';

class UserServices {

  // static method signIn untuk Sign In hehe
  // dengan paramenter email dan password yang akan dilempar ke backend
  static Future<ApiReturnValue<User>> signIn(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 500)); // delay koneksi dalam proses signIn kira2, 0.5 detik

    return ApiReturnValue(value: mockUser); // menamilkan value yang sudah diterima
    // return ApiReturnValue(message: 'Wrong email or password'); // menamilkan value yang sudah diterima
  }
  
}