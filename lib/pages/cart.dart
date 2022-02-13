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
  late List _cartItemList;

  @override
  void initState() {
    super.initState();
    _cartItemList = [
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _cartItemList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      _cartItemList[index]['image'],
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      _cartItemList[index]['name'],
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      '\$${Random().nextInt(100)}',
                      textAlign: TextAlign.center,
                    ),
                    trailing: IconButton(
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
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: null,
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.orange,
                ),
                label: Text('Remove Cart'),
              ),
              ElevatedButton.icon(
                onPressed: null,
                icon: Icon(
                  CupertinoIcons.text_badge_checkmark,
                  color: Colors.orange,
                ),
                label: Text('Checkout'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
