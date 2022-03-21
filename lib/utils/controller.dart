// Controllers.
import 'package:flutter/material.dart';

class Controller {
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
