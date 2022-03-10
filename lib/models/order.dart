import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:food_shop/models/cart.dart';

class Order {
  final String orderId;
  final String userId;
  final int totalPrice;
  final List<Cart> cart;
  Order({
    required this.orderId,
    required this.userId,
    required this.totalPrice,
    required this.cart,
  });

  Order copyWith({
    String? orderId,
    String? userId,
    int? totalPrice,
    List<Cart>? cart,
  }) {
    return Order(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      totalPrice: totalPrice ?? this.totalPrice,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'totalPrice': totalPrice,
      'cart': cart.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      cart: List<Cart>.from(map['cart']?.map((x) => Cart.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(orderId: $orderId, userId: $userId, totalPrice: $totalPrice, cart: $cart)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.orderId == orderId &&
        other.userId == userId &&
        other.totalPrice == totalPrice &&
        listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        userId.hashCode ^
        totalPrice.hashCode ^
        cart.hashCode;
  }
}
