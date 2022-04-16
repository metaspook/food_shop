import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/cart_controller.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/utils/method.dart';
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
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   onPressed: () {
        //     if (Navigator.canPop(context)) Navigator.pop(context, true);
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_rounded,
        //     color: Theme.of(context).scaffoldBackgroundColor,
        //   ),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              // final ff = Provider.of<ProductProvider>(context, listen: false);
              print(context.read<CartController>().products);
              // print(Provider.of<List<Product>>(context, listen: false));

              Method.customDialogText(
                title: '⚠️ Caution!',
                subtitle: 'Do you want to delete this cart?',
                context: context,
                primaryButtonText: 'Cancel',
                primaryButtonFunction: () => Method.navPop(context),
                secondaryButtonText: 'Confirm',
                secondaryButtonFunction: () {
                  Method.navPop(context);
                  context.read<CartController>().removeCart();
                  Method.navPop(context);
                },
              );
            },
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
              // shrinkWrap: true,

              children: <Widget>[
                // FutureBuilder<List<Product>>(
                //     future: Variable.futureProduct,
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return

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
                        Method.customDialogText(
                          title: 'Order Confirmation',
                          // subtitle: 'Do you want confirm the order?',
                          context: context,
                          primaryButtonText: 'Cancel',
                          primaryButtonFunction: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          secondaryButtonText: 'Confirm',
                          secondaryButtonFunction: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
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
                      '0',
                      // _cartItemPriceList.isEmpty
                      //     ? '\$0'
                      //     : '\$${_cartItemPriceList.reduce((value, element) => value + element)}',

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
                  // context.watch<List<Product>>()[index]
                  // imageUrl: Variable.dbRealtime.ref("products/${context.watch<Cart>().itemList[index].itemId}").get(),
                  imageUrl: cartProduct.productImage,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  // fit: BoxFit.cover,
                ),
                // Image.network(
                //   widget.cartItemList[index].image,
                //   fit: BoxFit.fill,
                // ),
              ],
            ),
            title: Text(
              cartProduct.productName,
              // _cartItemList[index].name,
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
            trailing: CartItemQuantityUpdater(cartProduct,
                productIndex: productIndex, productStock: productStock)),
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}

/// Cart Item Quantity Updater.
class CartItemQuantityUpdater extends StatelessWidget {
  const CartItemQuantityUpdater(
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
