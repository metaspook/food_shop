import 'package:flutter/material.dart' show ValueNotifier;
import 'package:food_shop/models/cart_item.dart';

abstract class Notifier {
  static ValueNotifier<List<CartItem>> cartItemList = ValueNotifier([]);
  static ValueNotifier<int> itemLength = ValueNotifier(0);
}
