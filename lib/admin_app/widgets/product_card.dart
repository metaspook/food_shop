import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/controllers/products_controller.dart';
import 'package:food_shop/widgets/input_form.dart';
import 'package:provider/provider.dart';

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
    final editMode = context.watch<ProductsController>().editModes[index];
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
                        onPressed: () => context
                            .read<ProductsController>()
                            .editModeOff(index, id),
                      )
                    : IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.edit,
                          color: Colors.cyan,
                        ),
                        onPressed: () => context
                            .read<ProductsController>()
                            .editModeOn(index),
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
                      Flexible(child: InputForm.price(index, price)),
                      const SizedBox(width: 10),
                      Flexible(child: InputForm.stock(index, stock)),
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
