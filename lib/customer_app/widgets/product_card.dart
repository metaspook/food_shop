import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/customer_app/widgets/widgets.dart';
import 'package:food_shop/models/models.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, {Key? key, required this.index})
      : super(key: key);
  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              '${index + 1}. ${product.name}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            Flexible(
              child: CachedNetworkImage(
                imageUrl: product.image,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(width: 5),
                Text(
                  "\$" + product.price.toString(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(width: 50),
                CartUpdaterButton(cartController.toCartProduct(product)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
