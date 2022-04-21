import 'package:flutter/material.dart';
import 'package:food_shop/customer_app/widgets/widgets.dart';
import 'package:food_shop/models/models.dart';
import 'package:provider/provider.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<List<Order>?>();
    if (orders != null) {
      if (orders.isEmpty) {
        return Center(
          child: Text(
            'No Orders!',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.only(
          top: 2.5,
          bottom: 2.5,
          left: 7.5,
          right: 7.5,
        ),
        shrinkWrap: true,
        reverse: true,
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: OrderTileCustomer(orders[index], index: index),
          );
        },
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
