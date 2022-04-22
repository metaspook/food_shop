import 'package:flutter/material.dart';
import 'package:food_shop/controllers/x_controller.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/utils/constants.dart';
import 'package:food_shop/widgets/dash_grid.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    // Order status count stream.
    for (String status in Constants.statusElements.keys) {
      Database.ordersByStatus(status).listen(
          (event) => Constants.statusElements[status]!["count"] = event.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = context.watch<List<AppUser>?>();
    final products = context.watch<List<Product>?>();
    final orders = context.watch<List<Order>?>();
    if (users != null && products != null && orders != null) {
      if (users.isEmpty || products.isEmpty || orders.isEmpty) {
        return Center(
          child: Text('No Elements!',
              style: Theme.of(context).textTheme.headline3),
        );
      }
      // Main board counts from stream.
      Constants.mainBoardElements["Users"]!["count"] = users.length;
      Constants.mainBoardElements["Orders"]!["count"] = products.length;
      Constants.mainBoardElements["Products"]!["count"] = orders.length;
      return Container(
        color: Colors.white,
        child: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return ListView(
              // shrinkWrap: true,
              controller: XController.scroll,
              children: [
                DashGrid("Main Board", items: Constants.mainBoardElements),
                DashGrid("Order Board", items: Constants.statusElements),
                // Card(
                //   elevation: 5,
                //   // shadowColor: Colors.black,
                //   // color: Colors.white54,
                //   child: Text(
                //     "Dashboard Items 2",
                //     textAlign: TextAlign.center,
                //     style: Theme.of(context).textTheme.headline1,
                //   ),
                // )
              ],
            );
          }),
        ),
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
