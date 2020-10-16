part of 'models.dart';

class Food {
  final int id;
  final String picturePath;
  final String name;
  final String description;
  final String ingredients;
  final int price;
  final double rate;

  Food({
    this.id,
    this.picturePath,
    this.name,
    this.description,
    this.ingredients,
    this.price,
    this.rate,
  });
}

// DUMMY DATA

List<Food> mockFoods = [
  Food(
    id: 1,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    price: 150000,
    rate: 4.2
  ),
  Food(
    id: 2,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    price: 150000,
    rate: 4.2
  ),
  Food(
    id: 3,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    price: 150000,
    rate: 4.2
  ),
  Food(
    id: 4,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    price: 150000,
    rate: 4.2
  ),
  Food(
    id: 5,
    picturePath: "https://storage.googleapis.com/cakrawala01/2020/07/67e684bc-resep-daing-kambing.jpg",
    name: "Sate Kambing Cakrawala",
    description: "Sate kambing Cakrawala adalah menu sate paling terkenal dibandung. Sate init dibuat dari berbagai macam bahan bahan berkualitas",
    price: 150000,
    rate: 4.2
  ),
];