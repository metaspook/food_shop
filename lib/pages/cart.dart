import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/utils/methods.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> _cartItemList;
  late List<int> _cartItemQuantityList;
  late List<int> _cartItemPriceList;
  late List<int> _itemPriceList;

  @override
  void initState() {
    super.initState();
    _cartItemList = <Map<String, dynamic>>[
      {
        "id": 1,
        "name": "Apple",
        "image":
            "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png"
      },
      {
        "id": 2,
        "name": "Biscuit",
        "image":
            "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png"
      },
      {
        "id": 3,
        "name": "Boiled Egg",
        "image":
            "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png"
      },
      {
        "id": 4,
        "name": "Bread",
        "image":
            "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/bread.png"
      },
      {
        "id": 5,
        "name": "Breadsticks",
        "image":
            "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/breadsticks.png"
      }
    ];
    _itemPriceList = List<int>.generate(
      _cartItemList.length,
      (i) => Random().nextInt(100),
      growable: false,
    );
    _cartItemPriceList = [..._itemPriceList];
    _cartItemQuantityList = List<int>.generate(
      _cartItemList.length,
      (i) => 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _cartItemList.clear();
              _cartItemPriceList.clear();
            }),
            icon: Icon(
              CupertinoIcons.delete,
              color: Colors.orange,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: _cartItemList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _cartItemList.removeAt(index);
                              _cartItemPriceList.removeAt(index);
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.cart_badge_minus,
                            color: Colors.orange,
                          ),
                        ),
                        Image.network(
                          _cartItemList[index]['image'],
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    title: Text(
                      _cartItemList[index]['name'],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      '\$${_cartItemPriceList[index]}',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.center,
                    ),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          Text(
                            "${_cartItemQuantityList[index]}",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                            textAlign: TextAlign.center,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_cartItemQuantityList[index] > 1) {
                                      _cartItemQuantityList[index]--;
                                      _cartItemPriceList[index] -=
                                          _itemPriceList[index];
                                    }
                                  });
                                },
                                icon: Icon(
                                  CupertinoIcons.minus_square,
                                  color: Colors.orange,
                                  size: 40,
                                ),
                              ),
                              IconButton(
                                // padding: EdgeInsets.all(1),
                                onPressed: () {
                                  setState(() {
                                    _cartItemQuantityList[index]++;
                                    _cartItemPriceList[index] +=
                                        _itemPriceList[index];
                                  });
                                },
                                icon: Icon(
                                  CupertinoIcons.plus_square,
                                  color: Colors.orange,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   '\$${_cartPriceList[index]}',
                    //   style: Theme.of(context).textTheme.headline5!.copyWith(
                    //       fontWeight: FontWeight.bold,
                    //       color: Theme.of(context).colorScheme.secondary),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                label: Text('Make Order'),
                icon: Icon(
                  CupertinoIcons.text_badge_checkmark,
                  color: Colors.orange,
                ),
                onPressed: () {
                  Methods.customDialog(
                    title: 'Order Confirmation',
                    // subtitle: 'Do you want confirm the order?',
                    context: context,
                    primaryButtonText: 'Cancel',
                    primaryButtonFunction: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    secondaryButtonText: 'Confirm',
                    secondaryButtonFunction: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                  );
                },
              ),
              SizedBox(width: 50),
              Text(
                'Total:',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
              Text(
                _cartItemPriceList.isEmpty
                    ? '\$0'
                    : '\$${_cartItemPriceList.reduce((value, element) => value + element)}',
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
