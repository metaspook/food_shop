import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/models/product.dart';
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
  var items = [
    'Canceled',
    'Confirmed',
    'Delivery',
    'Pending',
    'Received',
  ];
  String dropdownValue = 'Pending';
  String statusImage = 'clock_01_x128.png';
  final List<Map<String, dynamic>> _cartItemList = [
    {"itemIndex": 0, "quantity": 5},
    {"itemIndex": 1, "quantity": 1},
    {"itemIndex": 2, "quantity": 44},
    {"itemIndex": 3, "quantity": 23},
    {"itemIndex": 0, "quantity": 5},
    {"itemIndex": 1, "quantity": 1},
    {"itemIndex": 2, "quantity": 44},
    {"itemIndex": 3, "quantity": 23},
    {"itemIndex": 0, "quantity": 5},
    {"itemIndex": 1, "quantity": 1},
    {"itemIndex": 2, "quantity": 44},
    {"itemIndex": 3, "quantity": 23},
    {"itemIndex": 0, "quantity": 5},
    {"itemIndex": 1, "quantity": 1},
    {"itemIndex": 2, "quantity": 44},
    {"itemIndex": 3, "quantity": 23},
    {"itemIndex": 0, "quantity": 5},
    {"itemIndex": 1, "quantity": 1},
    {"itemIndex": 2, "quantity": 44},
    {"itemIndex": 3, "quantity": 23},
  ];

  final List<Map<String, dynamic>> _itemList = [
    {
      "id": "862af8d6-8827-59cc-a0ec-c7d37e53aa02",
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
      "unitPrice": 74
    },
    {
      "id": "a36e5a0d-42c5-536c-a9c1-d9bbcb53d21d",
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
      "unitPrice": 32
    },
    {
      "id": "d23bfce3-fcaa-5b88-a920-3eca09ba9aa9",
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
      "unitPrice": 98
    },
    {
      "id": "b66ea18d-2f43-5b74-a063-1a30607b2cd4",
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
      "unitPrice": 87
    },
    {
      "id": "ad57b509-6f56-543a-90e2-b8c26e345614",
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
      "unitPrice": 21
    },
    {
      "id": "02c22cdf-299d-5d9e-a124-2658fd7068d9",
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
      "unitPrice": 32
    },
    {
      "id": "00d0db5e-240b-57d4-aabd-c244c49a2752",
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
      "unitPrice": 43
    },
    {
      "id": "40c1a48d-33cd-5ee6-9933-d8df12067a54",
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
      "unitPrice": 56
    },
    {
      "id": "456f400f-9231-573d-add3-e843fd63e70e",
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
      "unitPrice": 88
    },
    {
      "id": "2cc4fb3c-4cb1-59ad-922a-d6e568f013e0",
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
      "unitPrice": 22
    },
    {
      "id": "2bfeeeab-0c9b-5766-affa-c01b5a3df81c",
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
      "unitPrice": 43
    },
    {
      "id": "f6ddec77-26c8-5c76-ac63-c5a4db49bea0",
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
      "unitPrice": 55
    }
  ];
  static const _title = 'Order Page';
  bool updateDB = false;
  int totalPrice = 0;
  late List<int> _cartItemQuantityList;
  late List<int> _cartItemPriceList;
  late List<int> _cartSubTotalList;

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
    _cartSubTotalList = [
      for (var i = 0; i < _cartItemList.length; i++)
        _cartItemList[i]['quantity'] *
            _itemList[_cartItemList[i]['itemIndex']]['unitPrice']
    ];
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
                    Method.customDialogText(
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
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Flex(
            direction: size.width > 1250 ? Axis.horizontal : Axis.vertical,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                margin: EdgeInsets.all(20),
                elevation: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("""
      Customer ID: GlfdigjdfkFDfd Customer Name: Javed Hasan
      Customer Phone: 01356565632
      Order ID: ghhhigjdfkFDfd
                    """),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Status: ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                        DropdownButton(
                          // Initial Value
                          value: dropdownValue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: [
                            for (final e in items)
                              DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              )
                          ],
                          onChanged: dropdownValue == 'Canceled'
                              ? null
                              : (String? newValue) {
                                  if (newValue == 'Canceled') {
                                    Method.customDialogText(
                                      title: '⚠️  Caution!',
                                      subtitle:
                                          'Do you want to cancel this order?',
                                      context: context,
                                      primaryButtonText: 'NO',
                                      primaryButtonFunction: () =>
                                          Method.navPop(context),
                                      secondaryButtonText: 'YES',
                                      secondaryButtonFunction: () {
                                        Method.navPop(context);
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                    );
                                  } else {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  }
                                },
                        ),
                        // ElevatedButton.icon(
                        //   label: const Text('Make Order'),
                        //   icon: const Icon(
                        //     CupertinoIcons.text_badge_checkmark,
                        //     color: Colors.orange,
                        //   ),
                        //   onPressed: () {
                        //     Method.customDialog(
                        //       title: 'Order Confirmation',
                        //       // subtitle: 'Do you want confirm the order?',
                        //       context: context,
                        //       primaryButtonText: 'Cancel',
                        //       primaryButtonFunction: () {
                        //         if (Navigator.canPop(context)) {
                        //           Navigator.pop(context);
                        //         }
                        //       },
                        //       secondaryButtonText: 'Confirm',
                        //       secondaryButtonFunction: () {
                        //         if (Navigator.canPop(context)) {
                        //           Navigator.pop(context);
                        //         }
                        //       },
                        //     );
                        //   },
                        // ),
                        // const SizedBox(width: 50),
                        RichText(
                          text: TextSpan(
                            text: 'Total: ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '\$${_cartSubTotalList.reduce((v, e) => v + e)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 100),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        defaultColumnWidth: size.width > 1250
                            ? FixedColumnWidth(200)
                            : FlexColumnWidth(),
                        // defaultColumnWidth: FlexColumnWidth(),
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Text(
                                'Product',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ]),
                            Column(children: [
                              Text(
                                'Unit Price',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ]),
                            Column(children: [
                              Text(
                                'Quantity',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ]),
                            Column(children: [
                              Text(
                                'Subtotal',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ]),
                          ]),
                        ],
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            defaultColumnWidth: size.width > 1250
                                ? FixedColumnWidth(200)
                                : FlexColumnWidth(),
                            // defaultColumnWidth: FlexColumnWidth(),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              // for (var j = 0; j < 8; j++)
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
                                  Column(children: [
                                    Text(
                                        "\$${_itemList[_cartItemList[i]['itemIndex']]['unitPrice']}")
                                  ]),
                                  Column(children: [
                                    Text("${_cartItemList[i]['quantity']}")
                                  ]),
                                  Column(children: [
                                    Text(
                                        '\$${_cartItemList[i]['quantity'] * _itemList[_cartItemList[i]['itemIndex']]['unitPrice']}')
                                  ]),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        //                     '$${_cartItemPriceList[index]}',
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
        //               ? '$0'
        //               : '$${_cartItemPriceList.reduce((value, element) => value + element)}',
        //           style: Theme.of(context).textTheme.headline4!.copyWith(
        //               fontWeight: FontWeight.bold,
        //               color: Theme.of(context).colorScheme.secondary),
        //           textAlign: TextAlign.center,
        //         ),
        //       ],
        //     ),
        //   ],
        // );
      }),
    );
  }
}
