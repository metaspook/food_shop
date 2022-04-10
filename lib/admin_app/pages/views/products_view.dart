import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/controllers/product_controller.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productList = context.watch<List<Product>?>();
    if (productList != null) {
      if (productList.isEmpty) {
        return Center(
          child: Text(
            'No Products!',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
      }
      context.read<ProductController>().editModes =
          List.generate(productList.length, (i) => false, growable: false);
      return Center(
        child: GridView.builder(
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
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductCard(
              id: productList[index].id,
              name: productList[index].name,
              image: productList[index].image,
              price: productList[index].price,
              stock: productList[index].stock,
              index: index,
            );
          },
        ),
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.stock,
    required this.index,
  }) : super(key: key);

  final String id;
  final String name;
  final String image;
  final num price;
  final int stock;
  final int index;

  @override
  Widget build(BuildContext context) {
    final editMode = context.watch<ProductController>().editModes[index];
    return Card(
      shadowColor: editMode
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.primary,
      elevation: 2.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: TextSpan(
                    text: "${index + 1}. ",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: name,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ],
                  ),
                ),
                editMode
                    ? IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.checkCircle,
                          color: Colors.cyan,
                        ),
                        onPressed: () {
                          context
                              .read<ProductController>()
                              .editModeChange(index, !editMode);
                          // context
                          //     .read<ProductController>()
                          //     .editModeChange(!editMode);
                          // if (Controller.price.text.isNotEmpty) {
                          //   Variable.dbRealtime
                          //       .ref(
                          //           "products/${snapshot.data!.snapshot.children.elementAt(index).key}/price")
                          //       .set(double.tryParse(
                          //           Controller.price.text));
                          // }
                          // if (Controller.stock.text.isNotEmpty) {
                          //   Variable.dbRealtime
                          //       .ref(
                          //           "products/${snapshot.data!.snapshot.children.elementAt(index).key}/stock")
                          //       .set(int.tryParse(
                          //           Controller.stock.text));
                          // }
                          // _editModeNotifier.value = [
                          //   ..._editModeNotifier.value
                          //     ..removeAt(index)
                          //     ..insert(index, false)
                          // ];
                        },
                      )
                    : IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.edit,
                          color: Colors.cyan,
                        ),
                        onPressed: () {
                          // editMode = true;
                          // print(editMode);
                          context
                              .read<ProductController>()
                              .editModeChange(index, !editMode);
                          // _editModeNotifier.value = [
                          //   ..._editModeNotifier.value
                          //     ..removeAt(index)
                          //     ..insert(index, true)
                          // ];
                        },
                      ),
              ],
            ),
            Flexible(
              child: CachedNetworkImage(
                httpHeaders: const {"Content-Type": "image/jpeg"},
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    LinearProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'ID: ',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
                children: <TextSpan>[
                  TextSpan(
                    text: id,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            editMode
                ? Row(
                    children: [
                      Flexible(child: InputForm.price(price as double)),
                      const SizedBox(width: 10),
                      Flexible(child: InputForm.stock(stock)),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Price: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                          children: <TextSpan>[
                            TextSpan(
                                text: '\$',
                                style: DefaultTextStyle.of(context).style),
                            TextSpan(
                              text: "$price",
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
                                  color: Theme.of(context).colorScheme.primary),
                          children: <TextSpan>[
                            TextSpan(
                              text: "$stock",
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
  }
}
