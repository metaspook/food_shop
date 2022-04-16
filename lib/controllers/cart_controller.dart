import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/utils/constants.dart';

class CartController extends ChangeNotifier {
  final _cartProducts = Constants.prefs.getStringList("cartProducts") ?? [];
  num _totalPrice = 0;

  /// Get the list of all product definer items in the cart.
  List<CartProduct> get products =>
      CartProduct.fromJsonStringList(_cartProducts);

  /// Check if an item contains in the cart.
  bool contains(String productId) {
    bool found = false;
    for (CartProduct e in products) {
      if (e.productId == productId) {
        found = true;
        break;
      }
    }
    return found;
  }

  /// Convert Product to CartProduct.
  CartProduct toCartProduct(Product product) {
    CartProduct cartProduct = CartProduct(
      productId: product.id,
      productImage: product.image,
      productName: product.name,
      quantity: 1,
      unitPrice: product.price,
      subTotal: product.price * 1,
    );
    for (CartProduct e in products) {
      if (e.productId == product.id) {
        cartProduct = e;
        break;
      }
    }
    return cartProduct;
  }

  num get totalPrice => _totalPrice;

  /// Add an item in the cart.
  Future<void> add(CartProduct product) async {
    _cartProducts.add(product.toJsonString());
    await Constants.prefs.setStringList("cartProducts", [..._cartProducts]);
    notifyListeners();
  }

  /// Remove an item from the cart.
  Future<void> remove(CartProduct product) async {
    _cartProducts.remove(product.toJsonString());
    await Constants.prefs.setStringList("cartProducts", [..._cartProducts]);
    notifyListeners();
  }

  /// Remove the cart with all items.
  Future<void> removeCart() async {
    await Constants.prefs.remove("cartProducts");
    _totalPrice = 0;
    _cartProducts.clear();
    notifyListeners();
  }

  Future<void> quantityIncrement(CartProduct product, int stock) async {
    if (product.quantity < stock) {
      final productIndex = _cartProducts.indexOf(product.toJsonString());
      final productMap = product.toJson();
      productMap['quantity']++;
      productMap['subTotal'] += productMap['unitPrice'];
      _totalPrice += productMap['subTotal'];
      _cartProducts[productIndex] = jsonEncode(productMap);
      await Constants.prefs.setStringList("cartProducts", [..._cartProducts]);
      notifyListeners();
    }
  }

  Future<void> quantityDecrement(CartProduct product) async {
    if (product.quantity > 1) {
      final productIndex = _cartProducts.indexOf(product.toJsonString());
      final productMap = product.toJson();
      productMap['quantity']--;
      productMap['subTotal'] -= productMap['unitPrice'];
      _totalPrice -= productMap['subTotal'];
      _cartProducts[productIndex] = jsonEncode(productMap);
      await Constants.prefs.setStringList("cartProducts", [..._cartProducts]);
      notifyListeners();
    }
  }
}
