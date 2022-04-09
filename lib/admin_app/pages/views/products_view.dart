import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/variable.dart';
import 'package:food_shop/widgets/input_form.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              ValueNotifier<List<bool>> _editModeNotifier = ValueNotifier(
                  List.generate(Variable.productList.length, (i) => false));
              return snapshot.data!.snapshot.value == null
                  ? Text(
                      'No Products!',
                      style: Theme.of(context).textTheme.headline3,
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(8),
                      controller: Controller.scroll,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width >= 1920
                            ? 6
                            : size.width > 1530
                                ? 5
                                : size.width > 1366
                                    ? 4
                                    : size.width > 1080
                                        ? 3
                                        : 2,
                        mainAxisExtent: 250,
                      ),
                      itemCount: Variable.productList.length,
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder<List<bool>>(
                          valueListenable: _editModeNotifier,
                          builder: (BuildContext context, List<bool> editMode,
                              Widget? child) {
                            return Card(
                              shadowColor: _editModeNotifier.value[index]
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary,
                              elevation: 2.5,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: '${index + 1}. ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: Variable
                                                      .productList[index].name
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          editMode[index]
                                              ? IconButton(
                                                  icon: const Icon(
                                                    FontAwesomeIcons
                                                        .checkCircle,
                                                    color: Colors.cyan,
                                                  ),
                                                  onPressed: () {
                                                    if (Controller.price.text
                                                        .isNotEmpty) {
                                                      Variable.dbRealtime
                                                          .ref(
                                                              "products/${snapshot.data!.snapshot.children.elementAt(index).key}/price")
                                                          .set(double.tryParse(
                                                              Controller
                                                                  .price.text));
                                                    }
                                                    if (Controller.stock.text
                                                        .isNotEmpty) {
                                                      Variable.dbRealtime
                                                          .ref(
                                                              "products/${snapshot.data!.snapshot.children.elementAt(index).key}/stock")
                                                          .set(int.tryParse(
                                                              Controller
                                                                  .stock.text));
                                                    }
                                                    _editModeNotifier.value = [
                                                      ..._editModeNotifier.value
                                                        ..removeAt(index)
                                                        ..insert(index, false)
                                                    ];
                                                  },
                                                )
                                              : IconButton(
                                                  icon: const Icon(
                                                    FontAwesomeIcons.edit,
                                                    color: Colors.cyan,
                                                  ),
                                                  onPressed: () {
                                                    _editModeNotifier.value = [
                                                      ..._editModeNotifier.value
                                                        ..removeAt(index)
                                                        ..insert(index, true)
                                                    ];
                                                  },
                                                ),
                                        ],
                                      ),
                                      Flexible(
                                        child: CachedNetworkImage(
                                          httpHeaders: const {
                                            "Content-Type": "image/jpeg"
                                          },
                                          imageUrl:
                                              Variable.productList[index].image,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              LinearProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error_outline),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'ID: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: Variable
                                                  .productList[index].id
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      editMode[index]
                                          ? Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceAround,
                                              children: [
                                                Flexible(
                                                    child: InputForm.price(
                                                        Variable
                                                            .productList[index]
                                                            .price as double)),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                    child: InputForm.stock(
                                                        Variable
                                                            .productList[index]
                                                            .stock)),
                                              ],
                                            )
                                          : Row(
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\$',
                                                          style: DefaultTextStyle
                                                                  .of(context)
                                                              .style),
                                                      TextSpan(
                                                        text: Variable
                                                            .productList[index]
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade600,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: Variable
                                                            .productList[index]
                                                            .stock
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade600,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  )),
                            );
                          },
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
