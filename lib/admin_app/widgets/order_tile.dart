import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/widgets/order_status_button.dart';
import 'package:food_shop/controllers/orders_controller.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/utils/constants.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(
    this.order, {
    Key? key,
    required this.index,
  }) : super(key: key);
  final Order order;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.5,
        child: ListTile(
          title: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Order ID: ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: order.id,
                        style: DefaultTextStyle.of(context).style),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              RichText(
                text: TextSpan(
                  text: 'Total Price: ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: '\$', style: DefaultTextStyle.of(context).style),
                    TextSpan(
                      text: order.total.toString(),
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ), // ),
            ],
          ),
          subtitle: Row(
            children: [
              Text(
                "Status: ",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
              OrderStatusButton(order),
              const SizedBox(width: 22),
              RichText(
                text: TextSpan(
                  text: "Customer: ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: order.customerFullName,
                        style: DefaultTextStyle.of(context).style),
                  ],
                ),
              ),
            ],
          ),
          leading: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Constants.statusElements[order.status]!["icon"],
                    color: Constants.statusElements[order.status]!["color"]),
                // Constants.statusElements[
                //     orderList[index].status]["icon"]!,
                const SizedBox(height: 20),
                Text(
                  "${index + 1}",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          onTap: () => OrdersController.navigateOrder(context, index),
          trailing: FittedBox(
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete_forever_outlined),
                  onPressed: () => OrdersController.remove(order.id),
                ),
              ],
            ),
          ),
        ));
  }
}
