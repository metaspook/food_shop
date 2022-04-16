import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/customer_app/pages/cart_page.dart';
import 'package:provider/provider.dart';

/// Adaptive cart badge.
class CartBadge extends StatelessWidget {
  const CartBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CartController>();

    return Badge(
      showBadge: controller.products.isEmpty ? false : true,
      badgeColor: Theme.of(context).colorScheme.secondary,
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(20),
      position: BadgePosition.topEnd(top: 2.5, end: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      badgeContent: Text(
        controller.products.length.toString(),
        style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        // style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              CupertinoIcons.cart,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            ),
          ),
          if (controller.products.isNotEmpty)
            SizedBox(
              width: 7.5 * controller.products.length.toString().length,
            ),
        ],
      ),
    );
  }
}
