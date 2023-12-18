// TODO: import firestore
// import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String imageUrl;
  final String name;
  final String description;

  final double price;

  Product(this.id, this.price,
      {required this.imageUrl, required this.name, required this.description});

  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id,
      data['price'] ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
