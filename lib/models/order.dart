import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'cart_item.dart';

class Order {
  final String id;
  final String userId;
  final String status;
  final List<CartItem> cartItemList;
  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.cartItemList,
  });

  Order copyWith({
    String? id,
    String? userId,
    String? status,
    List<CartItem>? cartItemList,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      cartItemList: cartItemList ?? this.cartItemList,
    );
  }

  // create model object from json object.
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      userId: json["userId"],
      status: json["status"],
      cartItemList: [for (var e in json["cartItemList"]) CartItem.fromJson(e)],
    );
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "userId": userId,
      "status": status,
      "cartItemList": cartItemList
    };
  }

  // get total price of an order.
  double get total =>
      [for (CartItem e in cartItemList) e.subTotal].reduce((v, e) => v + e);

  static List<Order> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      [for (Map<String, dynamic> e in jsonList) Order.fromJson(e)];
  static List<Order> fromJsonListString(String listString) => [
        for (Map<String, dynamic> e in jsonDecode(listString)) Order.fromJson(e)
      ];

  factory Order.fromJsonString(String jsonString) =>
      Order.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<Order> fromJsonStringList(List<String> list) =>
      [for (String e in list) Order.fromJsonString(e)];

  static List<String> toJsonStringList(List<Order> list) =>
      [for (Order e in list) e.toJsonString()];

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, status: $status, cartItemList: $cartItemList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.userId == userId &&
        other.status == status &&
        listEquals(other.cartItemList, cartItemList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        status.hashCode ^
        cartItemList.hashCode;
  }
}
