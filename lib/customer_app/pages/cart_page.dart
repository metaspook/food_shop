import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/cart_controller.dart';
import 'package:food_shop/customer_app/widgets/widgets.dart';
import 'package:food_shop/utils/methods.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            onPressed: () => Methods.customDialogText(
              title: '⚠️ Caution!',
              subtitle: 'Do you want to delete this cart?',
              context: context,
              primaryButtonText: 'Cancel',
              primaryButtonFunction: () => Methods.navPop(context),
              secondaryButtonText: 'Confirm',
              secondaryButtonFunction: () async {
                Methods.navPop(context);
                await context.read<CartController>().removeCart();
                Methods.navPop(context);
              },
            ),
            icon: Icon(
              CupertinoIcons.delete,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
      body: cartController.products.isEmpty
          ? Center(
              child: Text(
                'No item!',
                style: Theme.of(context).textTheme.headline3,
              ),
            )
          : ListView(
              children: <Widget>[
                ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 25, left: 5, right: 5),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartController.products.length,
                    itemBuilder: (context, index) {
                      return CartProductTile(
                        cartController.products[index],
                        productIndex: index,
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      label: const Text('Make Order'),
                      icon: const Icon(
                        CupertinoIcons.text_badge_checkmark,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        Methods.customDialogText(
                          title: 'Order Confirmation',
                          context: context,
                          primaryButtonText: 'Cancel',
                          primaryButtonFunction: () => Methods.navPop(context),
                          secondaryButtonText: 'Confirm',
                          secondaryButtonFunction: () async {
                            await context
                                .read<CartController>()
                                .makeOrder(context);
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 50),
                    Text(
                      'Total:',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      cartController.totalPrice.toString(),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
