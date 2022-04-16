import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/models/models.dart';
import 'package:provider/provider.dart';

class CartUpdaterButton extends StatelessWidget {
  const CartUpdaterButton(this.cartProduct, {Key? key}) : super(key: key);
  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();

    return cartController.contains(cartProduct.productId)
        ? IconButton(
            icon: const Icon(
              CupertinoIcons.cart_badge_minus,
              color: Colors.orange,
            ),
            onPressed: () {
              print(cartProduct);

              context.read<CartController>().remove(cartProduct);
            },
          )
        : IconButton(
            icon: const Icon(
              CupertinoIcons.cart_badge_plus,
              color: Colors.cyan,
            ),
            onPressed: () => context.read<CartController>().add(cartProduct),
          );
  }
}
