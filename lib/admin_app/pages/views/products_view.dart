import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/widgets/product_card.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/utils/controllers.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productList = context.watch<List<Product>?>();
    if (productList != null) {
      if (productList.isEmpty) {
        return Center(
          child: Text(
            'No Products!',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
      }
      return Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          controller: Controllers.scroll,
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
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductCard(
              id: productList[index].id,
              name: productList[index].name,
              image: productList[index].image,
              price: productList[index].price,
              stock: productList[index].stock,
              index: index,
            );
          },
        ),
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
