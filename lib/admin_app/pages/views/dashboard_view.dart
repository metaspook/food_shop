import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/x_controller.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/utils/constants.dart';
import 'package:food_shop/widgets/dash_grid.dart';

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
      Database.ordersByStatus(status).listen((event) {
        Constants.statusElements[status]!["count"] = event.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: StreamBuilder<DatabaseEvent>(
            stream: Database.dbRealtime.ref().onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Order and Users count stream.
                Constants.mainBoardElements["Users"]!["count"] =
                    snapshot.data!.snapshot.child("users").children.length;
                Constants.mainBoardElements["Orders"]!["count"] =
                    snapshot.data!.snapshot.child("orders").children.length;
                Constants.mainBoardElements["Products"]!["count"] =
                    snapshot.data!.snapshot.child("products").children.length;
                return LayoutBuilder(builder: (context, constraints) {
                  return ListView(
                    // shrinkWrap: true,
                    controller: XController.scroll,
                    children: [
                      DashGrid("Main Board",
                          items: Constants.mainBoardElements),
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
