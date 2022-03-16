import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/pages/cart.dart';
import 'package:food_shop/pages/order_page.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/variable.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  var items = [
    'Canceled',
    'Confirmed',
    'Delivery',
    'Pending',
    'Received',
  ];

  String dropdownValue = 'Pending';
  String statusImage = 'clock_01_x128.png';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Center(
        child: StreamBuilder<DatabaseEvent>(
            stream: Variable.dbRealtime.ref("orders").onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Variable.orderList = List.generate(
                  snapshot.data!.snapshot.children.length,
                  (index) => Order.fromJson(snapshot.data!.snapshot.children
                      .elementAt(index)
                      .value as Map<String, dynamic>),
                );
                return LayoutBuilder(builder: (context, constraints) {
                  return snapshot.data!.snapshot.value == null
                      ? Text(
                          'No Orders!',
                          style: Theme.of(context).textTheme.headline3,
                        )
                      : GridView.builder(
                          controller: Controller.scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: size.width > 1800
                                ? 3
                                : size.width > 1300
                                    ? 2
                                    : 1,
                            mainAxisExtent: 80,
                          ),
                          itemCount: Variable.orderList.length,
                          itemBuilder: (context, index) {
                            // final bool isPending = Constant.oderList[index]["pending"];

                            // switch (Variable.orderList[index].status) {
                            //   case "Confirmed":
                            //     break;
                            //   case "Canceled":
                            //     break;
                            //   case "Delivery":
                            //     break;
                            //   case "Pending":
                            //     break;
                            //   case "Received":
                            //     break;
                            //   default:
                            // }

                            // FontAwesomeIcons.timesCircle;
                            // FontAwesomeIcons.check;
                            // FontAwesomeIcons.checkCircle;
                            // FontAwesomeIcons.truck;
                            // FontAwesomeIcons.truckPickup;
                            // FontAwesomeIcons.shippingFast;
                            if (Variable.orderList[index].status ==
                                "Confirmed") {
                              statusImage = 'check_01_x128.png';
                            } else if (Constant.oderList[index]["status"] ==
                                "Canceled") {
                              statusImage = 'cancel_01_x128.png';
                            }
                            return Card(
                                elevation: 2.5,
                                child: ListTile(
                                  // contentPadding: EdgeInsetsGeometry.infinity,
                                  // visualDensity: VisualDensity.adaptivePlatformDensity,
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
                                                text: Variable
                                                    .orderList[index].id,
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Total Price: ',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.bold),

                                          // TextStyle(
                                          //     fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '\$',
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style),
                                            TextSpan(
                                              text: Variable
                                                  .orderList[index].total
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Text(
                                      //   "Order ID: \n" +
                                      //       Constant.oderList[index]["orderId"],
                                      //   style: Theme.of(context).textTheme.labelLarge,
                                      // ),
                                    ],
                                  ),

                                  subtitle: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Status: ",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      DropdownButton(
                                        // Initial Value
                                        value: Variable.orderList[index].status,

                                        // Down Arrow Icon
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: [
                                          for (final e in items)
                                            DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                            )
                                        ],
                                        onChanged: (String? newValue) {
                                          // setState(() {
                                          Variable.dbRealtime
                                              .ref(
                                                  "orders/${snapshot.data!.snapshot.children.elementAt(index).key}/status")
                                              .set(newValue);
                                          // });
                                        },
                                      ),
                                      const SizedBox(width: 22),
                                      RichText(
                                        text: TextSpan(
                                          text: "Customer: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: Variable
                                                    .userList[index].fullName,
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
                                        Constant.statusIcons[
                                            Variable.orderList[index].status]!,
                                        const SizedBox(height: 20),
                                        Text(
                                          "${index + 1}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        // Icon(FontAwesomeIcons.check),
                                        // Icon(FontAwesomeIcons.solidWindowClose),
                                        // Text(
                                        //   "${index + 1}",
                                        //   style: Theme.of(context).textTheme.headline1,
                                        // ),
                                        // Text(
                                        //   "✔️",
                                        //   style: Theme.of(context).textTheme.headline1,
                                        // ),
                                        // ❌✔️⏰
                                        // Image.asset("assets/images/$statusImage"),
                                      ],
                                    ),
                                  ),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OrderPage())),
                                  trailing: FittedBox(
                                    child: Column(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                              Icons.delete_forever_outlined),
                                          onPressed: () {
                                            Variable.dbRealtime
                                                .ref(
                                                    "orders/${snapshot.data!.snapshot.children.elementAt(index).key}")
                                                .remove();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        );
                });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator.adaptive();
            }),
      ),
    );
  }
}
