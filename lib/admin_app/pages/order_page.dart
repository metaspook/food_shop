import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/widgets/order_detail_card.dart';
import 'package:food_shop/admin_app/widgets/order_table.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/utils/methods.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage(this.orderIndex, {Key? key}) : super(key: key);
  final int orderIndex;

  @override
  build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final order = context.watch<List<Order>?>()?.elementAt(orderIndex);
    return order == null
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Order Page'),
              leading: IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) Navigator.pop(context, true);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Methods.customDialogText(
                      title: '⚠️ Caution!',
                      subtitle: 'Do you want to delete this cart?',
                      context: context,
                      primaryButtonText: 'Cancel',
                      primaryButtonFunction: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      secondaryButtonText: 'Confirm',
                      secondaryButtonFunction: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }

                        // setState(() {
                        //   // if (Navigator.canPop(context)) {
                        //   // int count = 0;
                        //   // Navigator.of(context).popUntil((_) => count++ >= 2);
                        //   Method.prefs.then((db) => db.clear());
                        //   _cartItemList.clear();
                        //   _cartItemPriceList.clear();
                        //   // }
                        // });
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context, true);
                        }
                        // Navigator.pop(context, true);
                      },
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
            body: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Flex(
                  direction:
                      size.width > 1250 ? Axis.horizontal : Axis.vertical,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OrderDetailCard(order),
                    const SizedBox(width: 100),
                    OrderTable(order, constraints: constraints),
                  ],
                ),
              );
            }),
          );
  }
}
