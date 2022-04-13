import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/models/models.dart';

class OrderTable extends StatelessWidget {
  const OrderTable(this.order, {Key? key, required this.constraints})
      : super(key: key);

  final Order order;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              defaultColumnWidth: size.width > 1250
                  ? const FixedColumnWidth(200)
                  : const FlexColumnWidth(),
              // defaultColumnWidth: FlexColumnWidth(),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
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
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  defaultColumnWidth: size.width > 1250
                      ? const FixedColumnWidth(200)
                      : const FlexColumnWidth(),
                  // defaultColumnWidth: FlexColumnWidth(),
                  border: TableBorder.all(
                      color: Colors.black, style: BorderStyle.solid, width: 2),
                  children: [
                    for (CartProduct e in order.cartProductList)
                      TableRow(children: [
                        Row(children: [
                          Flexible(
                            child: CachedNetworkImage(
                              imageUrl: e.productImage,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              height: constraints.maxHeight * 0.05,
                              width: constraints.maxWidth * 0.05,
                            ),
                          ),
                          Text(e.productName)
                        ]),
                        Column(children: [Text(e.unitPrice.toString())]),
                        Column(children: [Text(e.quantity.toString())]),
                        Column(children: [Text(e.subTotal.toString())]),
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
    );
  }
}
