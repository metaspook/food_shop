import 'package:flutter/material.dart';
import 'package:food_shop/pages/product_list_page.dart';
import 'package:food_shop/pages/sign_in.dart';
import 'package:food_shop/pages/sign_up.dart';

class CustomerApp extends StatelessWidget {
  /// Customer app is a Mobile (Android, iOS) app.
  const CustomerApp({Key? key}) : super(key: key);

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
      home: ProductListPage(),
      // home: const SignInPage(),
      // home: const SignUpPage(),
    );
  }
}
