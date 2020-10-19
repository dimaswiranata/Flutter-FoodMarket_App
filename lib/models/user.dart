part of 'models.dart';

class User extends Equatable{
  final int id;
  final String name;
  final String email;
  final String address;
  final String houseNumber;
  final String phoneNumber;
  final String city;
  final String picturePath;
  static String token;

  User({
    this.id,
    this.name,
    this.email,
    this.address,
    this.houseNumber,
    this.phoneNumber,
    this.city,
    this.picturePath,
  });

  // Method copyWith untuk mencopy User agar bisa di edit, jadi jika ingin mengedit maka datanya masuk ke copyWith
  // User typenya Equatable dan atributenya final semua jadi tidak bisa didedit
  User copyWith({
  int id,
  String name,
  String email,
  String address,
  String houseNumber,
  String phoneNumber,
  String city,
  String picturePath,
  }){
    return User( // bisa diedit tapi ??(jika kosong) maka menggunakan data lama
      id : id ?? this.id, 
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      houseNumber: houseNumber ?? this.houseNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      picturePath: picturePath ?? this.picturePath,
    );
  }

  @override
  List<Object> get props => [id, name, email, address, houseNumber, phoneNumber, city, picturePath];
}

// Dummy data User
User mockUser  = User(
  id: 1,
  name: "Jung Eunbi",
  email: "eunha@gfriend.com",
  address: "Dadali Camprenik 1",
  city: "Bandung",
  houseNumber: "16",
  phoneNumber: "08123456789",
  picturePath: "https://kprofiles.com/wp-content/uploads/2018/07/cweknagte.jpg"
);