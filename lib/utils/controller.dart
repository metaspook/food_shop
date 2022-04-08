// Controllers.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_shop/models/cart_product.dart';
import 'package:food_shop/models/product.dart';

class Controller {
  static final StreamController<List<Product>> productList =
      StreamController<List<Product>>();
  static final cartItemList = StreamController<List<CartProduct>>();
  static final fullName = TextEditingController();
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final phone = TextEditingController();
  static final address = TextEditingController();
  static final page = PageController();
  static final scroll = ScrollController();
  static final price = TextEditingController();
  static final stock = TextEditingController();

  static void get signUpDisposer {
    email.dispose();
    password.dispose();
  }

  static void get signInDisposer {
    fullName.dispose();
    phone.dispose();
    address.dispose();
  }
}
