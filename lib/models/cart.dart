import 'dart:convert';

class Cart {
  final int itemIndex;
  final int quantity;
  Cart({
    required this.itemIndex,
    required this.quantity,
  });

  Cart copyWith({
    int? itemIndex,
    int? quantity,
  }) {
    return Cart(
      itemIndex: itemIndex ?? this.itemIndex,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemIndex': itemIndex,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      itemIndex: map['itemIndex']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(itemIndex: $itemIndex, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Cart &&
      other.itemIndex == itemIndex &&
      other.quantity == quantity;
  }

  @override
  int get hashCode => itemIndex.hashCode ^ quantity.hashCode;
}