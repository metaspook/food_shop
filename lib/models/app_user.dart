// MODEL CLASS
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class AppUser {
  AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    this.image,
  });

  final String id;
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String? image;

  // create model object from json object.
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
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

  factory AppUser.fromSnapshot(Object? object) {
    object as Map;
    final Map<String, dynamic> objectMap = {};
    object.forEach((k, v) => objectMap[k] = v);
    return AppUser.fromJson(objectMap);
  }

  static List<AppUser> fromSnapshotChildren(Iterable<DataSnapshot> list) =>
      // List.generate(list.length,
      //     (index) => Product.fromDataSnapshot(list.elementAt(index).value));
      [for (DataSnapshot e in list) AppUser.fromSnapshot(e.value)];

  static List<AppUser> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      [for (Map<String, dynamic> e in jsonList) AppUser.fromJson(e)];
  static List<AppUser> fromJsonListString(String listString) => [
        for (Map<String, dynamic> e in jsonDecode(listString))
          AppUser.fromJson(e)
      ];

  factory AppUser.fromJsonString(String jsonString) =>
      AppUser.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<AppUser> fromJsonStringList(List<String> list) =>
      [for (String e in list) AppUser.fromJsonString(e)];

  static List<String> toJsonStringList(List<AppUser> list) =>
      [for (AppUser e in list) e.toJsonString()];
}
