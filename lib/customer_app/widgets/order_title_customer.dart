import 'package:flutter/material.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/utils/utils.dart';

class OrderTileCustomer extends StatelessWidget {
  const OrderTileCustomer(
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
        title: RichText(
          text: TextSpan(
            text: 'Order ID: ',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: order.id, style: DefaultTextStyle.of(context).style),
            ],
          ),
        ),
        subtitle: Row(
          children: [
            RichText(
              text: TextSpan(
                text: "Status: ",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: order.status,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 22),
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
            ),
            const SizedBox(width: 22),
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
        // onTap: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => OrderPage(index)),
        // ),
        // trailing: FittedBox(
        //   child: Column(
        //     children: const [],
        //   ),
        // ),
      ),
    );
  }
}
