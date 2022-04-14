import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/widgets/order_status_button.dart';
import 'package:food_shop/models/order.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard(this.order, {Key? key}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Text("""
Customer ID: ${order.customerId} || Order ID: ${order.id}
Customer Name: ${order.customerFullName} || Product Count: ${order.cartProductList.length}
Customer Phone: ${order.customerPhone}"""),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Status: ',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary)),
                OrderStatusButton(order),
                RichText(
                  text: TextSpan(
                    text: 'Total: ',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                    children: <TextSpan>[
                      TextSpan(
                          text: order.total.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold))
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
