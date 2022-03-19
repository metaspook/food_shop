import 'dart:convert';

class CartItem {
  final int itemIndex;
  final int quantity;
  final double unitPrice;
  CartItem({
    required this.itemIndex,
    required this.quantity,
    required this.unitPrice,
  });

  CartItem copyWith({
    int? itemIndex,
    int? quantity,
    double? unitPrice,
  }) {
    return CartItem(
      itemIndex: itemIndex ?? this.itemIndex,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  // create model object from json object.
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        itemIndex: json["itemIndex"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"]);
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "itemIndex": itemIndex,
      "quantity": quantity,
      "unitPrice": unitPrice
    };
  }

  // get subtotal of a cart items.
  double get subTotal => quantity * unitPrice;

  static List<CartItem> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      [for (Map<String, dynamic> e in jsonList) CartItem.fromJson(e)];
  static List<CartItem> fromJsonListString(String listString) => [
        for (Map<String, dynamic> e in jsonDecode(listString))
          CartItem.fromJson(e)
      ];

  factory CartItem.fromJsonString(String jsonString) =>
      CartItem.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<CartItem> fromJsonStringList(List<String> list) =>
      [for (String e in list) CartItem.fromJsonString(e)];

  static List<String> toJsonStringList(List<CartItem> list) =>
      [for (CartItem e in list) e.toJsonString()];

  @override
  String toString() =>
      'CartItem(itemIndex: $itemIndex, quantity: $quantity, unitPrice: $unitPrice)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.itemIndex == itemIndex &&
        other.quantity == quantity &&
        other.unitPrice == unitPrice;
  }

  @override
  int get hashCode =>
      itemIndex.hashCode ^ quantity.hashCode ^ unitPrice.hashCode;
}
