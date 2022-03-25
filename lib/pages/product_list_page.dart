import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_shop/models/cart_item.dart';
import 'package:food_shop/pages/cart_page.dart';
import 'package:food_shop/utils/method.dart';
import 'package:food_shop/utils/notifier.dart';
import 'package:food_shop/utils/variable.dart';
import 'package:http/http.dart' as http;
import 'package:food_shop/models/product.dart';

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
          ValueListenableBuilder(
            valueListenable: Notifier.cartItemList,
            builder:
                (BuildContext context, List<CartItem> value, Widget? child) {
              // adaptive badge.
              return Badge(
                showBadge: value.isEmpty ? false : true,
                badgeColor: Theme.of(context).colorScheme.secondary,
                shape: BadgeShape.square,
                borderRadius: BorderRadius.circular(20),
                position: BadgePosition.topEnd(top: 2.5, end: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                badgeContent: Text(
                  value.length.toString(),
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
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
                    if (Notifier.cartItemList.value.isNotEmpty)
                      SizedBox(
                        width: 7.5 *
                            Notifier.cartItemList.value.length
                                .toString()
                                .length,
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: Variable.dbRealtime.ref("products").onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Variable.productList = List.generate(
              snapshot.data!.snapshot.children.length,
              (index) {
                return Product.fromJson(Method.objectToMap(
                  snapshot.data!.snapshot.children.elementAt(index).value,
                ));
              },
            );

            return snapshot.data!.snapshot.value == null
                ? Text(
                    'No Products!',
                    style: Theme.of(context).textTheme.headline3,
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: Variable.productList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '$index. ${Variable.productList[index].name}',
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
                                imageUrl: Variable.productList[index].image,
                                // placeholder: (context, url) =>
                                //     CircularProgressIndicator(),
                                // progressIndicatorBuilder:
                                //     (context, url, downloadProgress) =>
                                //         CircularProgressIndicator(
                                //             value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                                        Variable.productList[index].price
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
                                  ValueListenableBuilder(
                                    valueListenable: Notifier.cartItemList,
                                    builder: (BuildContext context,
                                        List<CartItem> value, Widget? child) {
                                      return value.contains(CartItem(
                                        itemIndex: index,
                                        quantity: 1,
                                        unitPrice: Variable
                                            .productList[index].price
                                            .toDouble(),
                                      ))
                                          ? IconButton(
                                              icon: const Icon(
                                                CupertinoIcons.cart_badge_minus,
                                                color: Colors.orange,
                                              ),
                                              onPressed: () {
                                                Notifier.cartItemList.value =
                                                    Notifier
                                                        .cartItemList.value = [
                                                  ...Notifier.cartItemList.value
                                                    ..remove(CartItem(
                                                        itemIndex: index,
                                                        quantity: 1,
                                                        unitPrice: Variable
                                                            .productList[index]
                                                            .price
                                                            .toDouble())),
                                                ];
                                              },
                                            )
                                          : IconButton(
                                              icon: const Icon(
                                                CupertinoIcons.cart_badge_plus,
                                                color: Colors.cyan,
                                              ),
                                              onPressed: () {
                                                Notifier.cartItemList.value = [
                                                  ...Notifier.cartItemList.value
                                                    ..add(CartItem(
                                                        itemIndex: index,
                                                        quantity: 1,
                                                        unitPrice: Variable
                                                            .productList[index]
                                                            .price
                                                            .toDouble()))
                                                ];
                                              },
                                            );
                                    },
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
