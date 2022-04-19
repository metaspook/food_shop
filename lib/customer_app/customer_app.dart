import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';
import 'package:food_shop/customer_app/pages/pages.dart';
import 'package:provider/provider.dart';

class CustomerApp extends StatelessWidget {
  /// Customer app is a Mobile (Android, iOS) app.
  const CustomerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<User?>();
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
      // home: StreamPage1(),
      home: authUser != null ? const CustomerPage() : const SignInPage(),
      // home: const SignInPage(),
      // home: const SignUpPage(),
    );
  }
}
