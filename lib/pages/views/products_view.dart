import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/models/cart_item.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/notifier.dart';
import 'package:food_shop/utils/variable.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<DatabaseEvent>(
          stream: Variable.dbRealtime.ref("products").onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Variable.productList = List.generate(
                snapshot.data!.snapshot.children.length,
                (index) => Product.fromJson(snapshot.data!.snapshot.children
                    .elementAt(index)
                    .value as Map<String, dynamic>),
              );
              return snapshot.data!.snapshot.value == null
                  ? Text(
                      'No Products!',
                      style: Theme.of(context).textTheme.headline3,
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(8),
                      controller: Controller.scroll,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        mainAxisExtent: 250,
                      ),
                      itemCount: Variable.productList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '${index + 1}. ' +
                                          Variable.productList[index].name,
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
                                    IconButton(
                                      icon: const Icon(
                                        FontAwesomeIcons.edit,
                                        color: Colors.cyan,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: CachedNetworkImage(
                                    httpHeaders: const {
                                      "Content-Type": "image/jpeg"
                                    },
                                    imageUrl: Variable.productList[index].image,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        LinearProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error_outline),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Price: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '\$',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                          TextSpan(
                                            text: Variable
                                                .productList[index].price
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Stock: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: Variable
                                                .productList[index].stock
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
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
            return const CircularProgressIndicator();
          }),
    );
  }
}
