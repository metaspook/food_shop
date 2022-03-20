import 'dart:math';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' show Colors, Icons, ValueNotifier;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Variable {
  static late final Future<List<Product>> futureProduct;
  // static final unitPriceList = List<double>.generate(
  //     60,
  //     (index) => double.tryParse((Random().nextInt(20) + 1).toString() +
  //         "." +
  //         (25 * Random().nextInt(4)).toString())!);
  static ValueNotifier<int> decoy = ValueNotifier(0);
  // Shared Preferences.
  static late final SharedPreferences prefs;
  static late final EncryptedSharedPreferences prefsCrypt;
  static final Map<String, String> prefsData = {};
  // static late final FirebaseDatabase dbRealtimeInstance;
  static late final FirebaseDatabase dbRealtime;
  static late final FirebaseStorage fbStorage;
  static List<User> userList = [];
  static List<Order> orderList = [];
  static final itemPriceList =
      List<int>.generate(60, (index) => Random().nextInt(10) + 1);

  static final orderStatusList = <String, Map<String, dynamic>>{
    "Pending": {
      "count": 0,
      "icon": FontAwesomeIcons.infoCircle,
      "color": Colors.orange,
    },
    "Confirmed": {
      "count": 0,
      "icon": FontAwesomeIcons.solidHandshake,
      "color": Colors.blue,
    },
    "Canceled": {
      "count": 0,
      "icon": FontAwesomeIcons.solidTimesCircle,
      "color": Colors.red,
    },
    "Delivery": {
      "count": 0,
      "icon": FontAwesomeIcons.shippingFast,
      "color": Colors.purple,
    },
    "Received": {
      "count": 0,
      "icon": FontAwesomeIcons.solidCheckCircle,
      "color": Colors.green,
    },
  };

  static final counterList = <String, Map<String, dynamic>>{
    "Users": {
      "count": 0,
      "icon": Icons.supervised_user_circle_sharp,
      "color": Colors.orange,
    },
    "Orders": {
      "count": 0,
      "icon": Icons.file_copy,
      "color": Colors.orange,
    },
    "Products": {
      "count": 0,
      "icon": Icons.shopping_bag_rounded,
      "color": Colors.orange,
    },
    // ...Variable.orderStatusList
  };
}
