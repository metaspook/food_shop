import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/pages/admin_panel.dart';
import 'package:food_shop/pages/cart.dart';
import 'package:food_shop/pages/food_list.dart';
import 'package:food_shop/pages/sign_in.dart';
import 'package:food_shop/pages/sign_up.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/method.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Note that this line is required, otherwise flutter throws an error
  // about using binary messenger before runApp()
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // Constant.prefsCrypt = EncryptedSharedPreferences();
  // Constant.prefs = await Constant.prefsCrypt.getInstance();
  // Initializing Shared Preferences
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // Constant.prefsCrypt.reload();
  // Method.setPrefsData("userList", " x");
  // Method.loadPrefsData("userList");

  runApp(kIsWeb ? const AdminApp() : const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // final SharedPreferences prefs;
  // final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Shop',
      theme: ThemeData(
        // primarySwatch: Colors.indigo,
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.pink,
        ),
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => FoodListPage(prefs: prefs),
      //   '/cart': (context) => CartPage(prefs: prefs),
      // },
      // home: const CartPage(title: 'Your Cart'),
      // home: FoodListPage(),
      home: const SignUpPage(),
    );
  }
}

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);
  // final SharedPreferences prefs;
  // final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Shop Admin',
      theme: ThemeData(
        // primarySwatch: Colors.indigo,
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.pink,
        ),
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => FoodListPage(prefs: prefs),
      //   '/cart': (context) => CartPage(prefs: prefs),
      // },
      // home: const CartPage(title: 'Your Cart'),
      // home: FoodListPage(),
      home: const AdminPage(),
    );
  }
}
