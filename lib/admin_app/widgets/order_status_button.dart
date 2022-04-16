import 'package:flutter/material.dart';
import 'package:food_shop/controllers/orders_controller.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/utils/constants.dart';
import 'package:food_shop/utils/methods.dart';

class OrderStatusButton extends StatelessWidget {
  const OrderStatusButton(this.order, {Key? key}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: order.status,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: [
        for (final e in Constants.statusElements.keys)
          DropdownMenuItem<String>(
            value: e,
            child: Text(e,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: order.status == "Canceled"
                        ? Theme.of(context).disabledColor
                        : null)),
          )
      ],
      onChanged: order.status == "Canceled"
          ? null
          : (String? newStatus) async {
              if (newStatus != null) {
                newStatus == "Canceled"
                    ? Methods.customDialogText(
                        title: '⚠️  Caution!',
                        subtitle: 'Do you want to cancel this order?',
                        context: context,
                        primaryButtonText: 'NO',
                        primaryButtonFunction: () => Methods.navPop(context),
                        secondaryButtonText: 'YES',
                        secondaryButtonFunction: () async {
                          await OrdersController.changeStatus(
                            order.id,
                            status: newStatus,
                          );
                          Methods.navPop(context);
                        },
                      )
                    : await OrdersController.changeStatus(
                        order.id,
                        status: newStatus,
                      );
              }
            },
    );
  }
}
