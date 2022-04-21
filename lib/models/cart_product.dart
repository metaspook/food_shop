import 'dart:convert';

class CartProduct {
  final String productId;
  final String productImage;
  final String productName;
  final int quantity;
  final num unitPrice;
  final num subTotal;

  CartProduct({
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.subTotal,
  });

  // create model object from json object.
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json["productId"] ?? '',
      productImage: json["productImage"] ?? '',
      productName: json["productName"] ?? '',
      quantity: json["quantity"] ?? 0,
      unitPrice: json["unitPrice"] ?? 0,
      subTotal: json["subTotal"] ?? 0,
    );
  }

  // create json object from model object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "productId": productId,
      "productImage": productImage,
      "productName": productName,
      "quantity": quantity,
      "unitPrice": unitPrice,
      "subTotal": subTotal
    };
  }

  // get subtotal of a cart items.
  // num get getSubTotal => quantity * unitPrice;

  factory CartProduct.fromSnapshot(Object? object) {
    final objectMap = <String, dynamic>{};
    (object as Map).forEach((k, v) => objectMap[k] = v);
    return CartProduct.fromJson(objectMap);
  }

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
      'CartProduct(productId: $productId, productImage: $productImage,productName: $productName,quantity: $quantity, unitPrice: $unitPrice,subTotal: $subTotal)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartProduct &&
        other.productId == productId &&
        other.productImage == productImage &&
        other.productName == productName &&
        other.quantity == quantity &&
        other.unitPrice == unitPrice &&
        other.subTotal == subTotal;
  }

  @override
  int get hashCode =>
      productId.hashCode ^
      productImage.hashCode ^
      productName.hashCode ^
      quantity.hashCode ^
      unitPrice.hashCode ^
      subTotal.hashCode;
}
