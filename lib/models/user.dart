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