// import 'dart:convert';
// import 'package:flutter/material.dart';

// class Counter {
//   final String title;
//   final int count;
//   final Icon icon;
//   Counter({
//     required this.title,
//     required this.count,
//     required this.icon,
//   });

//   // create model object from json object.
//   factory Counter.fromJson(Map<String, dynamic> json) {
//     return Counter(
//         title: json['title'], count: json['count'], icon: json['icon']);
//   }

//   // create json object from model object.
//   // Map<String, dynamic> toJson() {
//   //   return <String, dynamic>{"title": title, "count": count, "icon": icon};
//   // }

//   static List<Counter> fromJsonList(List<Map<String, dynamic>> jsonList) =>
//       [for (Map<String, dynamic> e in jsonList) Counter.fromJson(e)];

//   // factory Counter.fromJsonString(String jsonString) =>
//   //     Counter.fromJson(jsonDecode(jsonString));

//   // String toJsonString() => jsonEncode(toJson());

//   // static List<Counter> fromJsonStringList(List<String> list) =>
//   //     [for (String e in list) Counter.fromJsonString(e)];

//   // static List<String> toJsonStringList(List<Counter> list) =>
//   //     [for (Counter e in list) e.toJsonString()];
// }
