import 'package:flutter/material.dart';
import 'package:food_shop/models/cart_product.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/utils/variable.dart';

class Cart extends ChangeNotifier {
  final _cartItemList = Variable.prefs.getStringList("cartItemList") ?? [];

  /// Get the list of all product definer items in the cart.
  List<CartProduct> get itemList =>
      CartProduct.fromJsonStringList(_cartItemList);

  /// Check if an item contains in the cart.
  bool containItem(CartProduct item) =>
      _cartItemList.contains(item.toJsonString());

  /// Add an item in the cart.
  Future<void> addItem(CartProduct item) async {
    _cartItemList.add(item.toJsonString());
    await Variable.prefs.setStringList("cartItemList", [..._cartItemList]);
    notifyListeners();
  }

  /// Remove an item from the cart.
  Future<void> removeItem(CartProduct item) async {
    _cartItemList.remove(item.toJsonString());
    await Variable.prefs.setStringList("cartItemList", [..._cartItemList]);
    notifyListeners();
  }

  /// Remove the cart with all items.
  Future<void> removeCart() async {
    await Variable.prefs.remove("cartItemList");
    _cartItemList.clear();
    notifyListeners();
  }

  /// Get the list of all products in the cart.
  Future<List<Product>> get productList async {
    return [
      for (var e in itemList)
        Product.fromSnapshot(
            (await Variable.dbRealtime.ref('products').child(e.productId).get())
                .value)
    ];
  }
}
