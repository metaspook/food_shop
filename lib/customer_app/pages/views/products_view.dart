import 'package:flutter/material.dart';
import 'package:food_shop/customer_app/widgets/product_card.dart';
import 'package:food_shop/models/product.dart';
// import 'package:food_shop/utils/utils.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.watch<List<Product>?>();
    // Constants.prefs.clear();
    if (products != null) {
      if (products.isEmpty) {
        return Center(
          child: Text(
            'No Products!',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
      }
      return Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: products.length,
          itemBuilder: (context, index) =>
              ProductCard(products[index], index: index),
        ),
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
