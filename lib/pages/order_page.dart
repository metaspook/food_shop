import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/utils/method.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key? key,
    this.itemPriceList,
  }) : super(key: key);
  final List<int>? itemPriceList;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<Map<String, dynamic>> _cartItemList = [
    {"itemIndex": 0, "quantity": 5},
    {"itemIndex": 1, "quantity": 1},
    {"itemIndex": 2, "quantity": 44},
    {"itemIndex": 3, "quantity": 23},
  ];

  final List<Map<String, dynamic>> _itemList = [
    {
      "id": 1,
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
      "unitPrice": 74
    },
    {
      "id": 2,
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
      "unitPrice": 32
    },
    {
      "id": 3,
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
      "unitPrice": 98
    },
    {
      "id": 1,
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
      "unitPrice": 87
    },
    {
      "id": 2,
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
      "unitPrice": 21
    },
    {
      "id": 3,
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
      "unitPrice": 32
    },
    {
      "id": 1,
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
      "unitPrice": 43
    },
    {
      "id": 2,
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
      "unitPrice": 56
    },
    {
      "id": 3,
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
      "unitPrice": 88
    },
    {
      "id": 1,
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
      "unitPrice": 22
    },
    {
      "id": 2,
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
      "unitPrice": 43
    },
    {
      "id": 3,
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
      "unitPrice": 55
    }
  ];
  late List<int> _cartItemQuantityList;
  late List<int> _cartItemPriceList;
  static const _title = 'Order Page';
  bool updateDB = false;

  @override
  void initState() {
    super.initState();
    _cartItemPriceList = [...?widget.itemPriceList];
    _cartItemQuantityList = List<int>.generate(_cartItemList.length, (i) => 1);
    _cartItemPriceList = List<int>.generate(
      _cartItemList.length,
      (i) => 10 + Random().nextInt(100 - 10),
      growable: false,
    );
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
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
          Badge(
            showBadge: _cartItemList.isEmpty ? false : true,
            badgeColor: Theme.of(context).colorScheme.secondary,
            shape: BadgeShape.square,
            borderRadius: BorderRadius.circular(20),
            position: BadgePosition.topEnd(top: 2.5, end: 5),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
            badgeContent: Text(
              '${_cartItemList.length}',
              style:
                  TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
              // style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Method.customDialog(
                      title: '⚠️ Caution!',
                      subtitle: 'Do you want to delete this cart?',
                      context: context,
                      primaryButtonText: 'Cancel',
                      primaryButtonFunction: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      secondaryButtonText: 'Confirm',
                      secondaryButtonFunction: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);

                        setState(() {
                          // if (Navigator.canPop(context)) {
                          // int count = 0;
                          // Navigator.of(context).popUntil((_) => count++ >= 2);
                          Method.prefs.then((db) => db.clear());
                          _cartItemList.clear();
                          _cartItemPriceList.clear();
                          // }
                        });
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context, true);
                        }
                        // Navigator.pop(context, true);
                      },
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                if (_cartItemList.isNotEmpty)
                  SizedBox(width: 7.5 * _cartItemList.length.toString().length),
              ],
            ),
          )
        ],
      ),
      body: Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(8),
              child: Table(
                defaultColumnWidth:
                    FixedColumnWidth(constraints.maxWidth / 4.75),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Text('Product', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: [
                      Text('Unit Price', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: [
                      Text('Quantity', style: TextStyle(fontSize: 20.0))
                    ]),
                    Column(children: [
                      Text('Subtotal', style: TextStyle(fontSize: 20.0))
                    ]),
                  ]),
                  for (var i = 0; i < _cartItemList.length; i++)
                    TableRow(children: [
                      Row(children: [
                        Flexible(
                          child: CachedNetworkImage(
                            imageUrl:
                                "${_itemList[_cartItemList[i]['itemIndex']]['image']}",
                            //         // imageUrl: _cartItemList[index].image,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            // fit: BoxFit.scaleDown,
                            height: constraints.maxHeight * 0.05,
                            width: constraints.maxWidth * 0.05,
                          ),
                        ),
                        // Image.asset(
                        // '${_itemList[_cartItemList[i]['itemIndex']]['image']}'),
                        Text(
                            '${_itemList[_cartItemList[i]['itemIndex']]['name']}')
                      ]),
                      Column(children: [Text('Flutter')]),
                      Column(children: [Text('5*')]),
                      Column(children: [Text('5*')]),
                    ]),
                  // TableRow(children: [
                  //   Column(children: [Text('Javatpoint')]),
                  //   Column(children: [Text('MySQL')]),
                  //   Column(children: [Text('5*')]),
                  //   Column(children: [Text('5*')]),
                  // ]),
                  // TableRow(children: [
                  //   Column(children: [Text('Javatpoint')]),
                  //   Column(children: [Text('ReactJS')]),
                  //   Column(children: [Text('5*')]),
                  //   Column(children: [Text('5*')]),
                  // ]),
                  // TableRow(children: [
                  //   Column(children: [Text('Javatpoint')]),
                  //   Column(children: [Text('ReactJS')]),
                  //   Column(children: [Text('5*')]),
                  //   Column(children: [Text('5*')]),
                  // ]),
                ],
              ),
            );
            // Column(
            //   // physics: NeverScrollableScrollPhysics(),
            //   // shrinkWrap: true,
            //   // padding:
            //   //     const EdgeInsets.only(top: 5, bottom: 25, left: 5, right: 5),
            //   children: <Widget>[
            //     Text("Product Name" +
            //         " " * (constraints.maxWidth * 0.12).round() +
            //         "Unit Price" +
            //         // "      " +
            //         "Quantity" +
            //         // "       " +
            //         "Subtotal"),
            //     Flexible(
            //       child: ListView.builder(
            //           physics: const AlwaysScrollableScrollPhysics(),
            //           // shrinkWrap: true,
            //           itemCount: _cartItemList.length,
            //           itemExtent: 75,
            //           itemBuilder: (context, index) {
            //             return Card(
            //               child: Row(
            //                 // mainAxisSize: MainAxisSize.min,
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   CachedNetworkImage(
            //                     imageUrl:
            //                         Food.fromJson(_cartItemList[index]).image,
            //                     // imageUrl: _cartItemList[index].image,
            //                     errorWidget: (context, url, error) =>
            //                         const Icon(Icons.error),
            //                     // fit: BoxFit.cover,
            //                   ),
            //                   // Image.network(
            //                   //   widget.cartItemList[index].image,
            //                   //   fit: BoxFit.fill,
            //                   // ),
            //                   Text(
            //                     Food.fromJson(_cartItemList[index]).name,
            //                     // _cartItemList[index].name,
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .titleLarge!
            //                         .copyWith(
            //                             fontWeight: FontWeight.bold,
            //                             color: Colors.grey.shade600),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                   Text(
            //                     '\$${_cartItemPriceList[index]}',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .headline6!
            //                         .copyWith(
            //                             fontWeight: FontWeight.bold,
            //                             color: Theme.of(context)
            //                                 .colorScheme
            //                                 .secondary),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                   Text(
            //                     '${_cartItemQuantityList[index]}',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .headline6!
            //                         .copyWith(
            //                             fontWeight: FontWeight.bold,
            //                             color: Theme.of(context)
            //                                 .colorScheme
            //                                 .secondary),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                 ],
            //               ),
            //               // child: ListTile(
            //               //   leading: Row(
            //               //     mainAxisSize: MainAxisSize.min,
            //               //     children: [
            //               //       CachedNetworkImage(
            //               //         imageUrl:
            //               //             Food.fromJson(_cartItemList[index]).image,
            //               //         // imageUrl: _cartItemList[index].image,
            //               //         errorWidget: (context, url, error) =>
            //               //             const Icon(Icons.error),
            //               //         // fit: BoxFit.cover,
            //               //       ),
            //               //       // Image.network(
            //               //       //   widget.cartItemList[index].image,
            //               //       //   fit: BoxFit.fill,
            //               //       // ),
            //               //       Text(
            //               //         Food.fromJson(_cartItemList[index]).name,
            //               //         // _cartItemList[index].name,
            //               //         style: Theme.of(context)
            //               //             .textTheme
            //               //             .titleLarge!
            //               //             .copyWith(
            //               //                 fontWeight: FontWeight.bold,
            //               //                 color: Colors.grey.shade600),
            //               //         textAlign: TextAlign.center,
            //               //       ),
            //               //     ],
            //               //   ),
            //               //   title: Text(
            //               //     '$${_cartItemPriceList[index]}',
            //               //     style: Theme.of(context)
            //               //         .textTheme
            //               //         .headline6!
            //               //         .copyWith(
            //               //             fontWeight: FontWeight.bold,
            //               //             color: Theme.of(context)
            //               //                 .colorScheme
            //               //                 .secondary),
            //               //     textAlign: TextAlign.center,
            //               //   ),
            //               //   subtitle: Text(
            //               //     '$${_cartItemPriceList[index]}',
            //               //     style: Theme.of(context)
            //               //         .textTheme
            //               //         .headline6!
            //               //         .copyWith(
            //               //             fontWeight: FontWeight.bold,
            //               //             color: Theme.of(context)
            //               //                 .colorScheme
            //               //                 .secondary),
            //               //     textAlign: TextAlign.center,
            //               //   ),
            //               //   trailing: FittedBox(
            //               //     child: Row(
            //               //       children: [
            //               //         Text(
            //               //           "${_cartItemQuantityList[index]}",
            //               //           style: Theme.of(context)
            //               //               .textTheme
            //               //               .headline4!
            //               //               .copyWith(
            //               //                   fontWeight: FontWeight.bold,
            //               //                   color: Theme.of(context)
            //               //                       .colorScheme
            //               //                       .secondary),
            //               //           textAlign: TextAlign.center,
            //               //         ),
            //               //         Column(
            //               //           mainAxisAlignment: MainAxisAlignment.center,
            //               //           // mainAxisSize: MainAxisSize.min,
            //               //           children: [
            //               //             IconButton(
            //               //               onPressed: () {
            //               //                 setState(() {
            //               //                   if (_cartItemQuantityList[index] >
            //               //                       1) {
            //               //                     _cartItemQuantityList[index]--;
            //               //                     _cartItemPriceList[index] -=
            //               //                         widget.itemPriceList![index];
            //               //                   }
            //               //                 });
            //               //               },
            //               //               icon: const Icon(
            //               //                 CupertinoIcons.minus_square,
            //               //                 color: Colors.orange,
            //               //                 size: 40,
            //               //               ),
            //               //             ),
            //               //             IconButton(
            //               //               // padding: EdgeInsets.all(1),
            //               //               onPressed: () {
            //               //                 setState(() {
            //               //                   _cartItemQuantityList[index]++;
            //               //                   _cartItemPriceList[index] +=
            //               //                       widget.itemPriceList![index];
            //               //                 });
            //               //               },
            //               //               icon: const Icon(
            //               //                 CupertinoIcons.plus_square,
            //               //                 color: Colors.orange,
            //               //                 size: 40,
            //               //               ),
            //               //             ),
            //               //           ],
            //               //         ),
            //               //       ],
            //               //     ),
            //               //   ),
            //               // ),
            //             );
            //           }),
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         ElevatedButton.icon(
            //           label: const Text('Make Order'),
            //           icon: const Icon(
            //             CupertinoIcons.text_badge_checkmark,
            //             color: Colors.orange,
            //           ),
            //           onPressed: () {
            //             Method.customDialog(
            //               title: 'Order Confirmation',
            //               // subtitle: 'Do you want confirm the order?',
            //               context: context,
            //               primaryButtonText: 'Cancel',
            //               primaryButtonFunction: () {
            //                 if (Navigator.canPop(context)) {
            //                   Navigator.pop(context);
            //                 }
            //               },
            //               secondaryButtonText: 'Confirm',
            //               secondaryButtonFunction: () {
            //                 if (Navigator.canPop(context)) {
            //                   Navigator.pop(context);
            //                 }
            //               },
            //             );
            //           },
            //         ),
            //         const SizedBox(width: 50),
            //         Text(
            //           'Total:',
            //           style: Theme.of(context).textTheme.headline5!.copyWith(
            //               fontWeight: FontWeight.bold,
            //               color: Theme.of(context).colorScheme.secondary),
            //           textAlign: TextAlign.center,
            //         ),
            //         Text(
            //           _cartItemPriceList.isEmpty
            //               ? '\$0'
            //               : '\$${_cartItemPriceList.reduce((value, element) => value + element)}',
            //           style: Theme.of(context).textTheme.headline4!.copyWith(
            //               fontWeight: FontWeight.bold,
            //               color: Theme.of(context).colorScheme.secondary),
            //           textAlign: TextAlign.center,
            //         ),
            //       ],
            //     ),
            //   ],
            // );
          })),
    );
  }
}
