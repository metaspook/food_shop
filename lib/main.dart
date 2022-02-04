import 'package:flutter/material.dart';
import 'package:food_shop/pages/food_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FoodListPage(title: 'Food Shop'),
    );
  }
}
