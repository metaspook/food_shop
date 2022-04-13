import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/widgets/order_status_button.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/utils/constants.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  // final items = const [
  //   'Canceled',
  //   'Confirmed',
  //   'Delivery',
  //   'Pending',
  //   'Received',
  // ];

  // String dropdownValue = 'Pending';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orderList = context.watch<List<Order>?>();
    return orderList == null
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Container(
            color: Colors.white,
            child: Center(
              child: LayoutBuilder(builder: (context, constraints) {
                return orderList.isEmpty
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
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return Card(
                              elevation: 2.5,
                              child: ListTile(
                                title: Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Order ID: ',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: orderList[index].id,
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Total Price: ',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '\$',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                          TextSpan(
                                            text: orderList[index]
                                                .total
                                                .toString(),
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    OrderStatusButton(orderList[index]),
                                    const SizedBox(width: 22),
                                    RichText(
                                      text: TextSpan(
                                        text: "Customer: ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: orderList[index]
                                                  .customerFullName,
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                leading: FittedBox(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                          Constants.statusElements[
                                              orderList[index].status]!["icon"],
                                          color: Constants.statusElements[
                                              orderList[index]
                                                  .status]!["color"]),
                                      // Constants.statusElements[
                                      //     orderList[index].status]["icon"]!,
                                      const SizedBox(height: 20),
                                      Text(
                                        "${index + 1}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => OrdersController.navigateOrder(
                                    context, index),
                                trailing: FittedBox(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.delete_forever_outlined),
                                        onPressed: () =>
                                            OrdersController.remove(
                                                orderList[index].id),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
              }),
            ),
          );
  }
}
