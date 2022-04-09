import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/pages/admin_page.dart';

class AdminApp extends StatelessWidget {
  /// Admin app is a Web app.
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
      // home: const FakeUploader(),
      // home: const OrderPage(),
      home: const AdminPage(),
    );
  }
}
