import 'package:flutter/material.dart';

class XController {
  XController._();
  static final fullName = TextEditingController();
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final phone = TextEditingController();
  static final address = TextEditingController();
  static final page = PageController();
  static final scroll = ScrollController();

  static void get signInDisposer {
    email.dispose();
    password.dispose();
  }

  static void get signUpDisposer {
    fullName.dispose();
    phone.dispose();
    address.dispose();
  }
}
