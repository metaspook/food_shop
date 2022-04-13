import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'cart_product.dart';

class Order {
  final String id;
  final String customerId;
  final String customerFullName;
  final String customerPhone;
  final String deliveryAddress;
  final String status;
  final num total;

  final List<CartProduct> cartProductList;
  Order({
    required this.id,
    required this.customerId,
    required this.customerFullName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.status,
    required this.total,
    required this.cartProductList,
  });

  // Order copyWith({
  //   String? id,
  //   String? userId,
  //   String? status,
  //   List<CartItem>? cartProductList,
  // }) {
  //   return Order(
  //     id: id ?? this.id,
  //     userId: userId ?? this.userId,
  //     status: status ?? this.status,
  //     cartProductList: cartProductList ?? this.cartProductList,
  //   );
  // }

  // create model object from json object.
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      customerId: json["customerId"],
      customerFullName: json["customerFullName"],
      customerPhone: json["customerPhone"],
      deliveryAddress: json["deliveryAddress"],
      status: json["status"],
      total: json["total"],
      cartProductList: [
        for (var e in json["cartProductList"]) CartProduct.fromJson(e)
      ],
    );
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "customerId": customerId,
      "customerFullName": customerFullName,
      "customerPhone": customerPhone,
      "deliveryAddress": deliveryAddress,
      "status": status,
      "total": total,
      "cartProductList": cartProductList
    };
  }

  factory Order.fromSnapshot(Object? object) {
    object as Map;
    final Map<String, dynamic> objectMap = {};
    object.forEach((k, v) => objectMap[k] = v);
    return Order.fromJson(objectMap);
  }

  static List<Order> fromSnapshotChildren(Iterable<DataSnapshot> list) =>
      // List.generate(list.length,
      //     (index) => Product.fromDataSnapshot(list.elementAt(index).value));
      [for (DataSnapshot e in list) Order.fromSnapshot(e.value)];

  // get total price of an order.
  num get getTotal => [for (CartProduct e in cartProductList) e.getSubTotal]
      .reduce((v, e) => v + e);

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

  // @override
  // String toString() {
  //   return 'Order(id: $id, userId: $userId, status: $status, cartProductList: $cartProductList)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Order &&
  //       other.id == id &&
  //       other.userId == userId &&
  //       other.status == status &&
  //       listEquals(other.cartProductList, cartProductList);
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //       userId.hashCode ^
  //       status.hashCode ^
  //       cartProductList.hashCode;
  // }
}
