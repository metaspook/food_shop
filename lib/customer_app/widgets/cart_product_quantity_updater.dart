import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/models/models.dart';
import 'package:provider/provider.dart';

/// Cart Item Quantity Updater.
class CartProductQuantityUpdater extends StatelessWidget {
  const CartProductQuantityUpdater(
    this.cartProduct, {
    Key? key,
    required this.productIndex,
    required this.productStock,
  }) : super(key: key);
  final CartProduct cartProduct;
  final int productIndex;
  final int productStock;

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();

    return FittedBox(
      child: Row(
        children: [
          Text(
            cartProduct.quantity.toString(),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
            textAlign: TextAlign.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => cartController.quantityDecrement(cartProduct),
                icon: const Icon(
                  CupertinoIcons.minus_square,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: () =>
                    cartController.quantityIncrement(cartProduct, productStock),
                icon: const Icon(
                  CupertinoIcons.plus_square,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
