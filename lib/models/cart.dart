import 'dart:convert';

class Cart {
  final int itemIndex;
  final int quantity;
  final double unitPrice;
  Cart({
    required this.itemIndex,
    required this.quantity,
    required this.unitPrice,
  });

  Cart copyWith({
    int? itemIndex,
    int? quantity,
    double? unitPrice,
  }) {
    return Cart(
      itemIndex: itemIndex ?? this.itemIndex,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  // create model object from json object.
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
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

  static List<Cart> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      [for (Map<String, dynamic> e in jsonList) Cart.fromJson(e)];
  static List<Cart> fromJsonListString(String listString) =>
      [for (Map<String, dynamic> e in jsonDecode(listString)) Cart.fromJson(e)];

  factory Cart.fromJsonString(String jsonString) =>
      Cart.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<Cart> fromJsonStringList(List<String> list) =>
      [for (String e in list) Cart.fromJsonString(e)];

  static List<String> toJsonStringList(List<Cart> list) =>
      [for (Cart e in list) e.toJsonString()];

  @override
  String toString() =>
      'Cart(itemIndex: $itemIndex, quantity: $quantity, unitPrice: $unitPrice)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.itemIndex == itemIndex &&
        other.quantity == quantity &&
        other.unitPrice == unitPrice;
  }

  @override
  int get hashCode =>
      itemIndex.hashCode ^ quantity.hashCode ^ unitPrice.hashCode;
}
