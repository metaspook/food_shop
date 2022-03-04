// MODEL CLASS
import 'dart:convert';

class User {
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    this.image,
  });

  final int id;
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String? image;

  // create model object from json object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      fullName: json["fullName"],
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      address: json["address"],
      image: json["image"],
    );
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "image": image
    };
  }

  static List<User> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      [for (Map<String, dynamic> e in jsonList) User.fromJson(e)];
  static List<User> fromJsonListString(String listString) =>
      [for (Map<String, dynamic> e in jsonDecode(listString)) User.fromJson(e)];

  factory User.fromJsonString(String jsonString) =>
      User.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<User> fromJsonStringList(List<String> list) =>
      [for (String e in list) User.fromJsonString(e)];

  static List<String> toJsonStringList(List<User> list) =>
      [for (User e in list) e.toJsonString()];
}
