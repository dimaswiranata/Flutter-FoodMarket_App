part of 'services.dart';

class UserServices {

  // static method signIn untuk Sign In hehe
  // dengan paramenter email dan password yang akan dilempar ke backend
  static Future<ApiReturnValue<User>> signIn(String email, String password, {http.Client client}) async {
    await Future.delayed(Duration(milliseconds: 500)); // delay koneksi dalam proses signIn kira2, 0.5 detik
    
    if (client == null){
      client = http.Client();
    }

    String url = baseUrl + 'login';

    var response = await client.post(
      url, 
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode(<String, String>{'email': email, 'password' : password})
    );
    
    // Jika Gagal
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again');
    }

    // Jika berhasil
    // mengubah response.body API menjadi json
    var data = jsonDecode(response.body);
    
    // Karena token berada di
    // {
    //  "data": {
    //   "access_token": "4|Akd99dZcP3Ef8eRpzNitjqK0C29gjxn50Nuz4fbK",
    //  }
    // }, jadi pengambilan access_token sebegai berikut :

    User.token = data['data']['access_token'];

    // Karena user berada di
    // {
    //  "data": {
    //    "user": {
    //        "id": 8,
    //        "name": "Jennie Kim",
    //        "email": "jennie.kim@blackpink.co",
    //        "email_verified_at": null,
    //        "roles": "USER",
    //        "current_team_id": null,
    //        "picturePath": null,
    //        "address": "Jalan Jenderal Sudirman",
    //        "houseNumber": "1234",
    //        "phoneNumber": "08123456789",
    //        "city": "Bandung",
    //        "created_at": "2020-09-18T11:51:44.000000Z",
    //        "updated_at": "2020-09-18T11:51:44.000000Z",
    //        "profile_photo_url": "https://ui-avatars.com/api/?name=Jennie+Kim&color=7F9CF5&background=EBF4FF"
    //    },
    //   }
    // }, jadi pengambilan user sebegai berikut :

    // fromJson untuk mengubah Json menjadi Object
    User value = User.fromJson(data['data']['user']);

    return ApiReturnValue(value: value);
    
    // DUMMY DATA
    // return ApiReturnValue(value: mockUser); // menamilkan value yang sudah diterima
    // return ApiReturnValue(message: 'Wrong email or password'); // menamilkan value yang sudah diterima
  }

  // method: Sign Up / Register
  static Future<ApiReturnValue<User>> signUp(User user, String password, {File pictureFile, http.Client client}) async {
    // Jika http.Client null maka membuat http.Client yang baru
    if (client == null){
      client = http.Client();
    }
    // inisialisasi url
    String url = baseUrl + 'register';

    // var response menampung hasil dari response API
    var response = await client.post(
      url,
      headers: {
        "Content-Type" : "application/json"
      },
      body: jsonEncode(<String, String>{
        'name' :  user.name, // Sesuaikan dengan API Register dan User model
        'email' :  user.email,
        'password' :  password,
        'password_confirmation' :  password,
        'address' :  user.address,
        'city' :  user.city,
        'houseNumber' :  user.houseNumber,
        'phoneNumber' :  user.phoneNumber,
      })
    );

    // Jika Gagal
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again');
    }

    // Jika berhasil
    // mengubah response.body API menjadi json
    var data = jsonDecode(response.body);
    
    // Karena token berada di
    // {
    //  "data": {
    //   "access_token": "4|Akd99dZcP3Ef8eRpzNitjqK0C29gjxn50Nuz4fbK",
    //  }
    // }, jadi pengambilan access_token sebegai berikut :

    User.token = data['data']['access_token'];

    // Karena user berada di
    // {
    //  "data": {
    //    "user": {
    //        "id": 8,
    //        "name": "Jennie Kim",
    //        "email": "jennie.kim@blackpink.co",
    //        "email_verified_at": null,
    //        "roles": "USER",
    //        "current_team_id": null,
    //        "picturePath": null,
    //        "address": "Jalan Jenderal Sudirman",
    //        "houseNumber": "1234",
    //        "phoneNumber": "08123456789",
    //        "city": "Bandung",
    //        "created_at": "2020-09-18T11:51:44.000000Z",
    //        "updated_at": "2020-09-18T11:51:44.000000Z",
    //        "profile_photo_url": "https://ui-avatars.com/api/?name=Jennie+Kim&color=7F9CF5&background=EBF4FF"
    //    },
    //   }
    // }, jadi pengambilan user sebegai berikut :

    User value = User.fromJson(data['data']['user']);

    // todo: Upload PP
    if (pictureFile != null){ // Jika pictureFile masih kosong maka harus melakukan Upload Foto
      ApiReturnValue<String> result = await uploadProfilePicture(pictureFile); // result untuk menampung return dari result
      if(result.value != null){
        // value merupakan result user dari response API kemudian di edit/tambahkan di value.picturePath result dari UploadProfilePicture dengan method copyWith
        value = value.copyWith( 
          picturePath: "http://foodmarket-backend.buildwithangga.id/storage/" + result.value
        );
      }
    }

    // limk picturePath
    // http://foodmarket-backend.buildwithangga.id/storage/assets/user/OSm5hmSmjiCMR2lq1tS3hPljeVC9nFBLVeuhanPS.jpeg

    // mengembalikan value yang merupakan USER dari respose dari API + picture path
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<String>> uploadProfilePicture(File pictureFile, {http.MultipartRequest request}) async {
    //ininisialisasi url API Upload Photo user/photo
    String url = baseUrl + 'user/photo';
    var uri =  Uri.parse(url);

    // Jika request == null maka membuat baru request http.MultipartRequest dengan header
    if (request == null){
      request = http.MultipartRequest("POST", uri)
      ..headers["Content-Type"] = "application/json"
      ..headers["Authorization"] = "Bearer ${User.token}";
    }

    // Mendapatkan file picture dari folder terus menaruh file tsb ke re
    var multipartFile = await http.MultipartFile.fromPath('file', pictureFile.path);
    request.files.add(multipartFile);

    // mengirim request yang sudah diisi picture ke API/request yang didefinisikan diatas
    // kemudian menyimpan respose dari API tersebut
    var response = await request.send();
    
    // Jika berhasil 
    if (response.statusCode != 200){
      // menconvert response API di var 'response' ke var 'data
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      // Untuk mendapatkan picture, json berbentuk
      // {
      //   "meta": {
      //     "code": 200,
      //     "status": "success",
      //     "message": "File successfully uploaded"
      //   },
      //   "data": [
      //     "assets/user/ATanl6hpJ0TjWOGQg06VhFQkwgqszk3S1TTIxQVe.png"
      //   ]
      // }, untuk mengambil sebegai berikut :
      String imagePath = data['data'][0]; // data array ke 0 ditampung dalam bentuk String

      return ApiReturnValue(value: imagePath); // mengembalikan value picture
    } else {
      return ApiReturnValue(message: 'Uploading Profile Picture Failed');
    }

  }
}