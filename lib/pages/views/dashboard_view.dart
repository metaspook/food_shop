import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/variable.dart';

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
    for (var status in Variable.orderStatusList.keys) {
      Variable.dbRealtime
          .ref("orders")
          .orderByChild("status")
          .equalTo(status)
          .onValue
          .listen((event) {
        Variable.counterList[status]!["count"] = event.snapshot.children.length;
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
            stream: Variable.dbRealtime.ref().onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Order and Users count stream.
                Variable.counterList["Users"]!["count"] =
                    snapshot.data!.snapshot.child("users").children.length;
                Variable.counterList["Orders"]!["count"] =
                    snapshot.data!.snapshot.child("orders").children.length;
                return LayoutBuilder(builder: (context, constraints) {
                  return ListView(
                    // shrinkWrap: true,
                    controller: Controller.scroll,
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.all(8),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // controller: Controller.scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width > 2100
                              ? 5
                              : size.width > 1900
                                  ? 4
                                  : size.width > 1500
                                      ? 3
                                      : size.width > 1100
                                          ? 2
                                          : 1,
                          mainAxisExtent: 110,
                        ),
                        itemCount: Variable.counterList.length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: const EdgeInsets.all(8),
                              color: Colors.grey.shade800,
                              elevation: 10,
                              child: ListTile(
                                title: Text(
                                    ' ' +
                                        Variable.counterList.keys
                                            .elementAt(index),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: size.width > 1900
                                          ? constraints.maxWidth / 45
                                          : size.width > 1500
                                              ? constraints.maxWidth / 40
                                              : size.width > 1100
                                                  ? constraints.maxWidth / 30
                                                  : constraints.maxWidth / 20,
                                    )),
                                leading: Icon(
                                  Variable.counterList[Variable.counterList.keys
                                      .elementAt(index)]!["icon"],
                                  color: Variable.counterList[Variable
                                      .counterList.keys
                                      .elementAt(index)]!["color"],
                                  size: size.width > 1900
                                      ? constraints.maxWidth / 45
                                      : size.width > 1500
                                          ? constraints.maxWidth / 40
                                          : size.width > 1100
                                              ? constraints.maxWidth / 30
                                              : constraints.maxWidth / 20,
                                ),
                                onTap: null,
                                trailing: FittedBox(
                                  child: Text(
                                    Variable.counterList[Variable
                                            .counterList.keys
                                            .elementAt(index)]!["count"]
                                        .toString(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: size.width > 1900
                                          ? constraints.maxWidth / 45
                                          : size.width > 1500
                                              ? constraints.maxWidth / 40
                                              : size.width > 1100
                                                  ? constraints.maxWidth / 30
                                                  : constraints.maxWidth / 20,
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // controller: Controller.scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          // childAspectRatio: 2,
                        ),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            // shadowColor: Colors.black,
                            // color: Colors.white54,
                            child: Text(
                              "Dashboard Item ${index + 1}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          );
                        },
                      ),
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
