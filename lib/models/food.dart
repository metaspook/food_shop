// MODEL CLASS
import 'dart:convert';

class Food {
  Food({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final String image;

  // create model object from json object.
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(id: json['id'], name: json['name'], image: json['image']);
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{"id": id, "name": name, "image": image};
  }

  factory Food.fromJsonString(String jsonString) =>
      Food.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<Food> fromJsonStringList(List<String> list) =>
      [for (String e in list) Food.fromJsonString(e)];

  static List<String> toJsonStringList(List<Food> list) =>
      [for (Food e in list) e.toJsonString()];
}
