// MODEL CLASS
import 'dart:convert';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final String image;

  // create model object from json object.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(id: json['id'], name: json['name'], image: json['image']);
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{"id": id, "name": name, "image": image};
  }

  factory Product.fromJsonString(String jsonString) =>
      Product.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<Product> fromJsonStringList(List<String> list) =>
      [for (String e in list) Product.fromJsonString(e)];

  static List<String> toJsonStringList(List<Product> list) =>
      [for (Product e in list) e.toJsonString()];
}
