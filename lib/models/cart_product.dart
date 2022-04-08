import 'dart:convert';

class CartProduct {
  final String productId;
  final int quantity;
  final num unitPrice;
  final num subTotal;

  CartProduct({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.subTotal,
  });

  CartProduct copyWith({
    String? productId,
    int? quantity,
    num? unitPrice,
    num? subTotal,
  }) {
    return CartProduct(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      subTotal: subTotal ?? this.subTotal,
    );
  }

  // create model object from json object.
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
        productId: json["productId"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        subTotal: json["subTotal"]);
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "productId": productId,
      "quantity": quantity,
      "unitPrice": unitPrice,
      "subTotal": subTotal
    };
  }

  // get subtotal of a cart items.
  num get getSubTotal => quantity * unitPrice;

  static List<CartProduct> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      [for (Map<String, dynamic> e in jsonList) CartProduct.fromJson(e)];
  static List<CartProduct> fromJsonListString(String listString) => [
        for (Map<String, dynamic> e in jsonDecode(listString))
          CartProduct.fromJson(e)
      ];

  factory CartProduct.fromJsonString(String jsonString) =>
      CartProduct.fromJson(jsonDecode(jsonString));

  String toJsonString() => jsonEncode(toJson());

  static List<CartProduct> fromJsonStringList(List<String> list) =>
      [for (String e in list) CartProduct.fromJsonString(e)];

  static List<String> toJsonStringList(List<CartProduct> list) =>
      [for (CartProduct e in list) e.toJsonString()];

  @override
  String toString() =>
      'CartProduct(productId: $productId, quantity: $quantity, unitPrice: $unitPrice,subTotal: $subTotal)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartProduct &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.unitPrice == unitPrice &&
        other.subTotal == subTotal;
  }

  @override
  int get hashCode =>
      productId.hashCode ^
      quantity.hashCode ^
      unitPrice.hashCode ^
      subTotal.hashCode;
}
