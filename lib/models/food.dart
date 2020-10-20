part of 'models.dart';

enum FoodType {new_food, popular, recommended}

class Food extends Equatable {
  final int id;
  final String picturePath;
  final String name;
  final String description;
  final String ingredients;
  final int price;
  final double rate;
  final List<FoodType> types;

  Food({
    this.id,
    this.picturePath,
    this.name,
    this.description,
    this.ingredients,
    this.price,
    this.rate,
    this.types = const []
  });

  @override
  List<Object> get props => [id, picturePath, name, description, ingredients, price, rate];

  factory Food.fromJson(Map<String, dynamic> data) => Food(
    id: data['id'],
    picturePath: data['picturePath'],
    name: data['name'],
    description: data['description'],
    ingredients: data['ingredients'],
    price: data['price'],
    rate: (data['rate'] as num).toDouble(), // example :  4 ke 4.0 type awal double
    types: data['types'].toString().split(',').map((e){ // "types": "new_food,recommended,popular" => [FoodType.new_food, FoodType.popular, FoodType.recommended]
      switch(e){
        case 'recomended':
          return FoodType.recommended;
          break;
        case 'popular':
          return FoodType.popular;
          break;
        default:
          return FoodType.new_food;
      }
    }).toList(),
  );
}

// DUMMY DATA

List<Food> mockFoods = [
  Food(
    id: 1,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    ingredients: "Bawang Merah, Paprika, Bawang Bombay, Timun",
    price: 150000,
    rate: 4.2,
    types: [FoodType.new_food, FoodType.popular, FoodType.recommended]
  ),
  Food(
    id: 2,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    ingredients: "Bawang Merah, Paprika, Bawang Bombay, Timun",
    price: 150000,
    rate: 4.2,
    types: [FoodType.popular]
  ),
  Food(
    id: 3,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    ingredients: "Bawang Merah, Paprika, Bawang Bombay, Timun",
    price: 150000,
    rate: 4.2,
    types: [FoodType.new_food]
  ),
  Food(
    id: 4,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    ingredients: "Bawang Merah, Paprika, Bawang Bombay, Timun",
    price: 150000,
    rate: 4.2,
    types: [FoodType.recommended]
  ),
  Food(
    id: 5,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    ingredients: "Bawang Merah, Paprika, Bawang Bombay, Timun",
    price: 150000,
    rate: 4.2,
    types: [FoodType.popular]
  ),
];