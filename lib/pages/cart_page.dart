import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/cart_provider.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/utils/method.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
    this.itemPriceList,
  }) : super(key: key);
  final List<int>? itemPriceList;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // final List<String> _cartItemList = [];
  // late List<int> _cartItemQuantityList;
  // late List<int> _cartItemPriceList;
  static const _title = 'Your Cart';
  // bool updateDB = false;

  @override
  void initState() {
    super.initState();
    // _cartItemPriceList = [...?widget.itemPriceList];
    // Method.prefs.then((db) {
    //   if (db.getStringList("cartItemList") != null) {
    //     setState(() {
    //       _cartItemList.addAll(db.getStringList("cartItemList")!);
    //       _cartItemQuantityList =
    //           List<int>.generate(_cartItemList.length, (i) => 1);
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(_title),
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context, true);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // final ff = Provider.of<ProductProvider>(context, listen: false);
              print(context.read<List<Product>>()[4].name.toString());
              // print(Provider.of<List<Product>>(context, listen: false));

              // Method.customDialogText(
              //   title: '⚠️ Caution!',
              //   subtitle: 'Do you want to delete this cart?',
              //   context: context,
              //   primaryButtonText: 'Cancel',
              //   primaryButtonFunction: () => Method.navPop(context),
              //   secondaryButtonText: 'Confirm',
              //   secondaryButtonFunction: () {
              //     Method.navPop(context);
              //     context.read<Cart>().removeCart();
              //     Method.navPop(context);
              //   },
              // );
            },
            icon: Icon(
              CupertinoIcons.delete,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
      body: context.watch<Cart>().itemList.isEmpty
          ? Center(
              child: Text(
                'No item!',
                style: Theme.of(context).textTheme.headline3,
              ),
            )
          : ListView(
              // shrinkWrap: true,
              padding:
                  const EdgeInsets.only(top: 5, bottom: 25, left: 5, right: 5),
              children: <Widget>[
                // FutureBuilder<List<Product>>(
                //     future: Variable.futureProduct,
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return

                const CartItemListView(),
                // ;

                //   } else if (snapshot.hasError) {
                //     return Text('${snapshot.error}');
                //   }
                //   return const CircularProgressIndicator.adaptive();
                // }),
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
class CartItemListView extends StatelessWidget {
  const CartItemListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // itemCount: 0,
        itemCount: context.watch<List<Product>>().length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // setState(() {
                        //   _cartItemList.removeAt(index);
                        //   Method.prefs.then((db) =>
                        //       db.setStringList(
                        //           "cartItemList",
                        //           _cartItemList));
                        //   _cartItemPriceList
                        //       .removeAt(index);
                        // });
                      },
                      icon: const Icon(
                        CupertinoIcons.cart_badge_minus,
                        color: Colors.orange,
                      ),
                    ),
                    CachedNetworkImage(
                      // context.watch<List<Product>>()[index]
                      // imageUrl: Variable.dbRealtime.ref("products/${context.watch<Cart>().itemList[index].itemId}").get(),
                      imageUrl: context.watch<List<Product>>()[index].image,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      // fit: BoxFit.cover,
                    ),
                    // Image.network(
                    //   widget.cartItemList[index].image,
                    //   fit: BoxFit.fill,
                    // ),
                  ],
                ),
                title: Text(
                  context.watch<List<Product>>()[index].name,
                  // _cartItemList[index].name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  '\$${context.watch<List<Product>>()[index].price}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                  textAlign: TextAlign.center,
                ),
                trailing: CartItemQuantityUpdater(index: index)),
          );
        });
  }
}

/// Cart Item Quantity Updater.
class CartItemQuantityUpdater extends StatelessWidget {
  const CartItemQuantityUpdater({Key? key, required this.index})
      : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Text(
            context.watch<Cart>().itemList[index].quantity.toString(),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
            textAlign: TextAlign.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  // setState(() {
                  //   if (_cartItemQuantityList[
                  //           index] >
                  //       1) {
                  //     _cartItemQuantityList[
                  //         index]--;
                  //     _cartItemPriceList[
                  //         index] -= widget
                  //             .itemPriceList![
                  //         index];
                  //   }
                  // });
                },
                icon: const Icon(
                  CupertinoIcons.minus_square,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
              IconButton(
                // padding: EdgeInsets.all(1),
                onPressed: () {
                  // setState(() {
                  //   _cartItemQuantityList[
                  //       index]++;
                  //   _cartItemPriceList[
                  //           index] +=
                  //       widget.itemPriceList![
                  //           index];
                  // });
                },
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
