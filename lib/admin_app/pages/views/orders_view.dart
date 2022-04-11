import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/customer_app/pages/pages.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/variable.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  final items = const [
    'Canceled',
    'Confirmed',
    'Delivery',
    'Pending',
    'Received',
  ];

  // String dropdownValue = 'Pending';

  @override
  Widget build(BuildContext context) {
    String statusImage = 'clock_01_x128.png';
    final size = MediaQuery.of(context).size;
    final provider = context.watch<List<Order>?>();

    // Database.orders.listen((event) {
    //   print(event.first.status);
    // });
    print(provider?.first.status);

    return provider == null
        ? const Center(child: CircularProgressIndicator.adaptive())
        :
        //     : Container(
        //         child: const Text('fghgfhfg'),
        //       );

        Container(
            color: Colors.white,
            child: Center(
              child:

                  // StreamBuilder<DatabaseEvent>(
                  //     stream: Variable.dbRealtime.ref("orders").onValue,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         provider = List.generate(
                  //           snapshot.data!.snapshot.children.length,
                  //           (index) => Order.fromJson(snapshot.data!.snapshot.children
                  //               .elementAt(index)
                  //               .value as Map<String, dynamic>),
                  //         );
                  //         return

                  LayoutBuilder(builder: (context, constraints) {
                return provider.isEmpty
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
                        itemCount: provider.length,
                        itemBuilder: (context, index) {
                          // final bool isPending = Constant.oderList[index]["pending"];

                          // switch (provider[index].status) {
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
                          if (provider[index].status == "Confirmed") {
                            statusImage = 'check_01_x128.png';
                          } else if (provider[index].status == "Canceled") {
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
                                              text: provider[index].id,
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

                                        // TextStyle(
                                        //     fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '\$',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                          TextSpan(
                                            text: provider[index]
                                                .total
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
                                      value: provider[index].status,

                                      // Down Arrow Icon
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
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
                                        // // setState(() {
                                        // Database.dbRealtime
                                        //     .ref(
                                        //         "orders/${snapshot.data!.snapshot.children.elementAt(index).key}/status")
                                        //     .set(newValue);
                                        // // });
                                      },
                                    ),
                                    const SizedBox(width: 22),
                                    RichText(
                                      text: TextSpan(
                                        text: "Customer: ",
                                        style: const TextStyle(
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
                                      Constant
                                          .statusIcons[provider[index].status]!,
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
                                          // Variable.dbRealtime
                                          //     .ref(
                                          //         "orders/${snapshot.data!.snapshot.children.elementAt(index).key}")
                                          //     .remove();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
              }),
              //   } else if (snapshot.hasError) {
              //     return Text('${snapshot.error}');
              //   }
              //   return const CircularProgressIndicator.adaptive();
              // }),
            ),
          );
  }
}
