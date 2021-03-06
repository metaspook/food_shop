import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/widgets/product_card_admin.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/models/product.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.watch<List<Product>?>();
    final size = MediaQuery.of(context).size;
    if (products != null) {
      if (products.isEmpty) {
        return Center(
          child: Text(
            'No Products!',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
      }
      ProductsController.initCardAdmin(products.length);
      return Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          controller: XController.scroll,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.width >= 1920
                ? 6
                : size.width > 1530
                    ? 5
                    : size.width > 1366
                        ? 4
                        : size.width > 1080
                            ? 3
                            : 2,
            mainAxisExtent: 250,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCardAdmin(
              id: products[index].id,
              name: products[index].name,
              image: products[index].image,
              price: products[index].price,
              stock: products[index].stock,
              index: index,
            );
          },
        ),
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
