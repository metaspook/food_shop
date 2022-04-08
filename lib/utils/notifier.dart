import 'package:flutter/material.dart' show ValueNotifier;
import 'package:food_shop/models/cart_product.dart';

abstract class Notifier {
  static ValueNotifier<List<CartProduct>> cartItemList = ValueNotifier([]);
  static ValueNotifier<int> itemLength = ValueNotifier(0);
}
