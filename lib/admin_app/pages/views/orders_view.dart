import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/widgets/order_tile.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/models/models.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orders = context.watch<List<Order>?>();
    return orders == null
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Container(
            color: Colors.white,
            child: Center(
              child: LayoutBuilder(builder: (context, constraints) {
                return orders.isEmpty
                    ? Text(
                        'No Orders!',
                        style: Theme.of(context).textTheme.headline3,
                      )
                    : GridView.builder(
                        controller: XController.scroll,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width > 1800
                              ? 3
                              : size.width > 1300
                                  ? 2
                                  : 1,
                          mainAxisExtent: 80,
                        ),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return OrderTile(orders[index], index: index);
                        },
                      );
              }),
            ),
          );
  }
}
