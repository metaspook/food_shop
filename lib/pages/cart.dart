import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> _cartItemList;
  late List<int> _cartPriceList;

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
    _cartPriceList = List<int>.generate(
      _cartItemList.length,
      (i) => Random().nextInt(100),
      growable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          ElevatedButton.icon(
            onPressed: () => setState(() {
              _cartItemList.clear();
            }),
            icon: Icon(
              CupertinoIcons.delete,
              color: Colors.orange,
            ),
            label: Text('Remove Cart'),
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
                          // padding: EdgeInsets.all(1),
                          onPressed: () {
                            setState(() {
                              _cartItemList.removeAt(index);
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
                    // Image.network(
                    //   _cartItemList[index]['image'],
                    //   fit: BoxFit.cover,
                    // ),
                    title: Text(
                      _cartItemList[index]['name'],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                      textAlign: TextAlign.center,
                    ),
                    // subtitle:
                    // Text(
                    //   '\$${Random().nextInt(100)}',
                    //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    //       fontWeight: FontWeight.bold,
                    //       color: Theme.of(context).colorScheme.secondary),
                    //   textAlign: TextAlign.center,
                    // ),
                    trailing: Text(
                      '\$${_cartPriceList[index]}',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: null,
                icon: Icon(
                  CupertinoIcons.text_badge_checkmark,
                  color: Colors.orange,
                ),
                label: Text('Checkout'),
              ),
              SizedBox(width: 65),
              Text(
                'Total:',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
              Text(
                '\$${_cartPriceList.reduce((value, element) => value + element)}',
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
