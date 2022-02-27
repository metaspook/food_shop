import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/utils/methods.dart';

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
  final List<String> _cartItemList = [];
  late List<int> _cartItemQuantityList;
  late List<int> _cartItemPriceList;
  static const _title = 'Your Cart';
  bool updateDB = false;

  @override
  void initState() {
    super.initState();
    _cartItemPriceList = [...?widget.itemPriceList];
    Methods.prefs.then((db) {
      if (db.getStringList("cartItemList") != null) {
        setState(() {
          _cartItemList.addAll(db.getStringList("cartItemList")!);
          _cartItemQuantityList =
              List<int>.generate(_cartItemList.length, (i) => 1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    Methods.customDialog(
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
                          Methods.prefs.then((db) => db.clear());
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
      body: _cartItemList.isEmpty
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
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
                                    Methods.prefs.then((db) => db.setStringList(
                                        "cartItemList", _cartItemList));
                                    _cartItemPriceList.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  CupertinoIcons.cart_badge_minus,
                                  color: Colors.orange,
                                ),
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    Food.fromJsonString(_cartItemList[index])
                                        .image,
                                // imageUrl: _cartItemList[index].image,
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
                            Food.fromJsonString(_cartItemList[index]).name,
                            // _cartItemList[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600),
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Text(
                            '\$${_cartItemPriceList[index]}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                                          if (_cartItemQuantityList[index] >
                                              1) {
                                            _cartItemQuantityList[index]--;
                                            _cartItemPriceList[index] -=
                                                widget.itemPriceList![index];
                                          }
                                        });
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
                                        setState(() {
                                          _cartItemQuantityList[index]++;
                                          _cartItemPriceList[index] +=
                                              widget.itemPriceList![index];
                                        });
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
                          ),
                        ),
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
                        Methods.customDialog(
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
