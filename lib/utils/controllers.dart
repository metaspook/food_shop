import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';

class Controllers {
  Controllers._();
  static final fullName = TextEditingController();
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final phone = TextEditingController();
  static final address = TextEditingController();
  static final page = PageController();
  static final scroll = ScrollController();
  static final products = ProductsController();
  static const users = UsersController;

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
