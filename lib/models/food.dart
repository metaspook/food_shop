// MODEL CLASS
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

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

  // // Shared Preferences helpers (..Prefs.. methods).
  // static Food getPrefs(
  //     {required SharedPreferences prefs, required String key}) {
  //   return Food.fromJson(jsonDecode(prefs.getString(key)!));
  // }

  // static void setPrefs({
  //   required SharedPreferences prefs,
  //   required String key,
  //   required Food value,
  // }) {
  //   prefs.setString(key, jsonEncode(value.toJson()));
  // }

  // static List<Food> getPrefsList(
  //     {required SharedPreferences prefs, required String key}) {
  //   return [
  //     for (String e in prefs.getStringList(key) ?? [])
  //       Food.fromJson(jsonDecode(e))
  //   ];
  // }

  // static void setPrefsList({
  //   required SharedPreferences prefs,
  //   required String key,
  //   required List<Food> list,
  // }) {
  //   prefs.setStringList(key, [for (Food e in list) jsonEncode(e.toJson())]);
  // }

  // static void addPrefsListItem({
  //   required SharedPreferences prefs,
  //   required String key,
  //   required Food item,
  // }) {
  //   setPrefsList(
  //     prefs: prefs,
  //     key: key,
  //     list: [...getPrefsList(prefs: prefs, key: key), item],
  //   );
  // }

  // static void removePrefsListItem({
  //   required SharedPreferences prefs,
  //   required String key,
  //   required Food item,
  // }) {
  //   List<Food> itemList = getPrefsList(prefs: prefs, key: key);
  //   itemList.remove(item);
  //   setPrefsList(
  //     prefs: prefs,
  //     key: key,
  //     list: [...itemList],
  //   );
  // }

  // static void removePrefsListItemAt({
  //   required SharedPreferences prefs,
  //   required String key,
  //   required int index,
  // }) {
  //   List<Food> itemList = getPrefsList(prefs: prefs, key: key);
  //   itemList.removeAt(index);
  //   setPrefsList(
  //     prefs: prefs,
  //     key: key,
  //     list: [...itemList],
  //   );
  // }
}
