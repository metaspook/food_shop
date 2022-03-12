import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'cart.dart';

class Order {
  final String id;
  final String userId;
  final double totalPrice;
  final List<Cart> cart;
  Order({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.cart,
  });

  Order copyWith({
    String? id,
    String? userId,
    double? totalPrice,
    List<Cart>? cart,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      totalPrice: totalPrice ?? this.totalPrice,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'totalPrice': totalPrice,
      'cart': cart.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      cart: List<Cart>.from(map['cart']?.map((x) => Cart.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, totalPrice: $totalPrice, cart: $cart)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.userId == userId &&
        other.totalPrice == totalPrice &&
        listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ totalPrice.hashCode ^ cart.hashCode;
  }
}
