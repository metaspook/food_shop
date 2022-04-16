import 'package:flutter/material.dart';
import 'package:food_shop/customer_app/pages/views/views.dart';
import 'package:food_shop/customer_app/widgets/cart_badge.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: const Text('Food Shop'),
          actions: const [CartBadge()],
        ),
        body: const ProductsView());
  }
}
