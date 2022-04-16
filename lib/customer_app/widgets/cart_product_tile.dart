import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/customer_app/widgets/widgets.dart';
import 'package:food_shop/models/models.dart';
import 'package:provider/provider.dart';

/// Cart Item ListView.
class CartProductTile extends StatelessWidget {
  const CartProductTile(this.cartProduct,
      {Key? key, required this.productIndex})
      : super(key: key);
  final CartProduct cartProduct;
  final int productIndex;

  @override
  Widget build(BuildContext context) {
    final productStock =
        context.watch<List<Product>?>()?.elementAt(productIndex).stock;
    if (productStock != null) {
      if (productStock == 0) {
        return Center(
          child: Text(
            'Out of Stock!',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
      }
      return Card(
        child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<CartController>().remove(cartProduct),
                  icon: const Icon(
                    CupertinoIcons.cart_badge_minus,
                    color: Colors.orange,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: cartProduct.productImage,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
            title: Text(
              cartProduct.productName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              '\$${cartProduct.unitPrice}',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
            trailing: CartProductQuantityUpdater(cartProduct,
                productIndex: productIndex, productStock: productStock)),
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
