import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/cart_provider.dart';
import 'package:food_shop/models/cart_product.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/pages/cart_page.dart';
import 'package:food_shop/services/database.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  static const _title = 'Food Shop';
  final List<int> _itemPriceList = [];
  // final List<String> _cartItemList = [];
  // List<CartItem> cartItemList = [];
  // late final Future<List<Product>> _futureFood;

  @override
  void initState() {
    super.initState();
    // Variable.futureProduct = _fetchFood();
    // Method.prefs.then((db) {
    //   if (db.getStringList("cartItemList") != null) {
    //     setState(() {
    //       _cartItemList.addAll(db.getStringList("cartItemList")!);
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text(_title),
        actions: [
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
          Badge(
            showBadge: context.watch<Cart>().itemList.isEmpty ? false : true,
            badgeColor: Theme.of(context).colorScheme.secondary,
            shape: BadgeShape.square,
            borderRadius: BorderRadius.circular(20),
            position: BadgePosition.topEnd(top: 2.5, end: 5),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
            badgeContent: Text(
              context.watch<Cart>().itemList.length.toString(),
              style:
                  TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
              // style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.cart,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  onPressed: () {
                    // print(_cartItemList);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CartPage(itemPriceList: _itemPriceList)),
                    ).then((value) {
                      // print(value);
                      // if (value) {
                      //   setState(() {
                      //     Method.prefs.then((db) {
                      //       if (db.getStringList("cartItemList") != null) {
                      //         _cartItemList.clear();
                      //         _cartItemList
                      //             .addAll(db.getStringList("cartItemList")!);
                      //       } else {
                      //         _cartItemList.clear();
                      //       }
                      //     });
                      //   });
                      // }
                    });
                  },
                ),
                if (context.watch<Cart>().itemList.isNotEmpty)
                  SizedBox(
                    width: 7.5 *
                        context.watch<Cart>().itemList.length.toString().length,
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<List<Product>>(
          stream: Database.products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Variable.productList =
              //     Product.fromSnapshotChildren(snapshot.data!.snapshot.children);
              return snapshot.data!.isEmpty
                  ? Text(
                      'No Products!',
                      style: Theme.of(context).textTheme.headline3,
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${index + 1}. ${snapshot.data![index].name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                                Flexible(
                                    child: CachedNetworkImage(
                                  imageUrl: snapshot.data![index].image,
                                  // placeholder: (context, url) =>
                                  //     CircularProgressIndicator(),
                                  // progressIndicatorBuilder:
                                  //     (context, url, downloadProgress) =>
                                  //         CircularProgressIndicator(
                                  //             value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  // fit: BoxFit.cover,
                                )
                                    // Image(
                                    //     image: CachedNetworkImageProvider(
                                    //         snapshot.data![index].image))
                                    // CachedNetworkImage(
                                    //   imageUrl: ,
                                    //   child: Image.network(
                                    //     snapshot.data![index].image,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                    ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // SizedBox(width: 5),
                                    Text(
                                      "\$" +
                                          snapshot.data![index].price
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                    const SizedBox(width: 50),
                                    CartUpdater(
                                      item: CartProduct(
                                        productId: snapshot.data![index].id,
                                        quantity: snapshot.data![index].stock,
                                        unitPrice: snapshot.data![index].price,
                                        subTotal: snapshot.data![index].price,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }
}

class CartUpdater extends StatelessWidget {
  const CartUpdater({Key? key, required this.item}) : super(key: key);
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
              // print(context.read<Cart>().containItem(item));
            },
          )
        : IconButton(
            icon: const Icon(
              CupertinoIcons.cart_badge_plus,
              color: Colors.cyan,
            ),
            onPressed: () {
              context.read<Cart>().addItem(item);
              // print(context.read<Cart>().itemList.length);
            },
          );
  }
}

// 'https://raw.githubusercontent.com/metaspook/json_api/main/json/foods.json'
// Future<List<Product>> _fetchFood() async {
//   final response = await http.get(Uri.parse(
//       'https://raw.githubusercontent.com/metaspook/json_api/main/json/foods.json'));

//   if (response.statusCode == 200) {
//     return [
//       for (Map<String, dynamic> i in jsonDecode(response.body))
//         Product.fromJson(i)
//     ];
//   } else {
//     throw Exception('Failed to fetch data!');
//   }
// }
