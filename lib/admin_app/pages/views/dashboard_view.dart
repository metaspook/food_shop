import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/x_controller.dart';
import 'package:food_shop/utils/variables.dart';
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
    for (var status in Variables.orderBoardItems.keys) {
      Variables.dbRealtime
          .ref("orders")
          .orderByChild("status")
          .equalTo(status)
          .onValue
          .listen((event) {
        Variables.orderBoardItems[status]!["count"] =
            event.snapshot.children.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Center(
        child: StreamBuilder<DatabaseEvent>(
            stream: Variables.dbRealtime.ref().onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Order and Users count stream.
                Variables.mainBoardItems["Users"]!["count"] =
                    snapshot.data!.snapshot.child("users").children.length;
                Variables.mainBoardItems["Orders"]!["count"] =
                    snapshot.data!.snapshot.child("orders").children.length;
                return LayoutBuilder(builder: (context, constraints) {
                  return ListView(
                    // shrinkWrap: true,
                    controller: XController.scroll,
                    children: [
                      DashGrid("Main Board", items: Variables.mainBoardItems),
                      DashGrid("Order Board", items: Variables.orderBoardItems),
                      Card(
                        elevation: 5,
                        // shadowColor: Colors.black,
                        // color: Colors.white54,
                        child: Text(
                          "Dashboard Items 2",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      )
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
