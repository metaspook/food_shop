import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_shop/models/cart_product.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/utils/constants.dart';

class CartController extends ChangeNotifier {
  final _cartProducts = Constants.prefs.getStringList("cartProducts") ?? [];

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

  CartProduct? productById(String productId) {
    CartProduct? cartProduct;
    for (CartProduct e in products) {
      if (e.productId == productId) {
        cartProduct = e;
        break;
      }
    }
    return cartProduct;
  }

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
    print(products);

    notifyListeners();
  }

  /// Remove the cart with all items.
  Future<void> removeCart() async {
    await Constants.prefs.remove("cartProducts");
    _cartProducts.clear();
    notifyListeners();
  }

  Future<void> quantityIncrement(CartProduct product, int stock) async {
    print(stock);
    if (product.quantity < stock) {
      final productIndex = _cartProducts.indexOf(product.toJsonString());
      final productMap = product.toJson();
      productMap['quantity']++;
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
      _cartProducts[productIndex] = jsonEncode(productMap);
      await Constants.prefs.setStringList("cartProducts", [..._cartProducts]);
      notifyListeners();
    }
  }
}
