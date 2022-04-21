// MODEL CLASS
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.stock,
  });

  final String id;
  final String name;
  final String image;
  final num price;
  final int stock;

  // create model object from json object.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      stock: json['stock'],
      // id: json['id'] ?? '',
      // name: json['name'] ?? '',
      // image: json['image'] ?? '',
      // price: json['price'] ?? 0,
      // stock: json['stock'] ?? 0,
    );
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "price": price,
      "stock": stock
    };
  }

  factory Product.fromSnapshot(Object? object) {
    final Map<String, dynamic> objectMap = {};
    (object as Map).forEach((k, v) => objectMap[k] = v);
    return Product.fromJson(objectMap);
  }

  static List<Product> fromSnapshotChildren(Iterable<DataSnapshot> list) =>
      [for (DataSnapshot e in list) Product.fromSnapshot(e.value)];

  factory Product.fromJsonString(String jsonString) =>
      Product.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<Product> fromJsonStringList(List<String> list) =>
      [for (String e in list) Product.fromJsonString(e)];

  static List<String> toJsonStringList(List<Product> list) =>
      [for (Product e in list) e.toJsonString()];
}
