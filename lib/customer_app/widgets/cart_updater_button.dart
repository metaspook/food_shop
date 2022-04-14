import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/models/models.dart';
import 'package:provider/provider.dart';

class CartUpdaterButton extends StatelessWidget {
  const CartUpdaterButton({Key? key, required this.item}) : super(key: key);
  final CartProduct item;

  @override
  Widget build(BuildContext context) {
    return context.watch<Cart>().containItem(item)
        ? IconButton(
            icon: const Icon(
              CupertinoIcons.cart_badge_minus,
              color: Colors.orange,
            ),
            onPressed: () {
              context.read<Cart>().removeItem(item);
            },
          )
        : IconButton(
            icon: const Icon(
              CupertinoIcons.cart_badge_plus,
              color: Colors.cyan,
            ),
            onPressed: () {
              context.read<Cart>().addItem(item);
            },
          );
  }
}
