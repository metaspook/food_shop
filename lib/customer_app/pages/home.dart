import 'package:flutter/material.dart';
import 'package:food_shop/customer_app/pages/views/views.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: const Text('Food Shop'),
          actions: const [
            // TextField(),
            // IconButton(
            //   onPressed: () => setState(() {
            //     Methods.prefs.then((db) => db.clear());
            //     _cartItemList.clear();
            //   }),
            //   icon: const Icon(
            //     CupertinoIcons.delete,
            //     color: Colors.orange,
            //   ),
            // ),

            // FloatingActionButton(
            //   onPressed: () {
            //     // setState(() {
            //     // Notifier.itemLength.value++;
            //     // });
            //     Notifier.cartItemList.value = [
            //       ...Notifier.cartItemList.value,
            //       CartItem(
            //           itemIndex: 1,
            //           quantity: 1,
            //           unitPrice: Constant.unitPriceList[1].toDouble())
            //     ];
            //     // Notifier.cartItemList.notifyListeners();
            //     // setState(() {
            //     //   _cartItemList.add(snapshot.data![index]
            //     //       .toJsonString());
            //     //   Method.prefs.then((db) =>
            //     //       db.setStringList(
            //     //           "cartItemList", _cartItemList));
            //     // });
            //   },
            // ),

            // adaptive badge.
            // Badge(
            //   showBadge: context.watch<Cart>().itemList.isEmpty ? false : true,
            //   badgeColor: Theme.of(context).colorScheme.secondary,
            //   shape: BadgeShape.square,
            //   borderRadius: BorderRadius.circular(20),
            //   position: BadgePosition.topEnd(top: 2.5, end: 5),
            //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
            //   badgeContent: Text(
            //     context.watch<Cart>().itemList.length.toString(),
            //     style:
            //         TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
            //     // style: TextStyle(color: Theme.of(context).colorScheme.primary),
            //   ),
            //   child: Row(
            //     children: [
            //       IconButton(
            //         icon: Icon(
            //           CupertinoIcons.cart,
            //           color: Theme.of(context).scaffoldBackgroundColor,
            //         ),
            //         onPressed: () {
            //           // print(_cartItemList);
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     CartPage(itemPriceList: _itemPriceList)),
            //           ).then((value) {
            //             // print(value);
            //             // if (value) {
            //             //   setState(() {
            //             //     Method.prefs.then((db) {
            //             //       if (db.getStringList("cartItemList") != null) {
            //             //         _cartItemList.clear();
            //             //         _cartItemList
            //             //             .addAll(db.getStringList("cartItemList")!);
            //             //       } else {
            //             //         _cartItemList.clear();
            //             //       }
            //             //     });
            //             //   });
            //             // }
            //           });
            //         },
            //       ),
            //       if (context.watch<Cart>().itemList.isNotEmpty)
            //         SizedBox(
            //           width: 7.5 *
            //               context.watch<Cart>().itemList.length.toString().length,
            //         ),
            //     ],
            //   ),
            // ),
          ],
        ),
        body: const ProductsView());
  }
}
