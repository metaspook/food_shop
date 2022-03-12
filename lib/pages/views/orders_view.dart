import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/pages/cart.dart';
import 'package:food_shop/pages/order_page.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';

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
      child: Constant.userList.isEmpty
          ? Center(
              child: Text(
                'No user!',
                style: Theme.of(context).textTheme.headline3,
              ),
            )
          : Center(
              child: GridView.builder(
                controller: Controller.scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 600 ? 3 : 1,
                  childAspectRatio: 4,
                ),
                itemCount: Constant.oderList.length,
                itemBuilder: (context, index) {
                  // final bool isPending = Constant.oderList[index]["pending"];
                  if (Constant.oderList[index]["status"] == "Confirmed") {
                    statusImage = 'check_01_x128.png';
                  } else if (Constant.oderList[index]["status"] == "Canceled") {
                    statusImage = 'cancel_01_x128.png';
                  }
                  return Card(
                      elevation: 2.5,
                      child: ListTile(
                        // contentPadding: EdgeInsetsGeometry.infinity,
                        // visualDensity: VisualDensity.adaptivePlatformDensity,
                        title: Row(
                          children: [
                            Text(
                              "Status: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButton(
                              // Initial Value
                              value: dropdownValue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
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
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                            SizedBox(width: 20),
                            RichText(
                              text: TextSpan(
                                text: 'Order ID:\n',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: Constant.oderList[index]["orderId"],
                                      style:
                                          DefaultTextStyle.of(context).style),
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

                        subtitle: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Constant.userList[index]["fullName"],
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'ID: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "-MxaseV0vCzvdfrrRjeo",
                                      style:
                                          DefaultTextStyle.of(context).style),
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
                              Icon(FontAwesomeIcons.truckMoving),
                              SizedBox(height: 20),
                              Text(
                                "${index + 1}",
                                style: Theme.of(context).textTheme.headline6,
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
                                builder: (context) => OrderPage())),
                        trailing: FittedBox(
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete_forever_outlined),
                                onPressed: () => setState(() {
                                  Constant.userList.removeAt(index);
                                }),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
    );
  }
}
