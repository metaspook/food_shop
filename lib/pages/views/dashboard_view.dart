import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/variable.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
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
                final List<Map<String, dynamic>> _gridInfoList = [
                  {
                    "title": "Users",
                    "count":
                        snapshot.data!.snapshot.child("users").children.length,
                    "icon": Icons.supervised_user_circle_sharp
                  },
                  {"title": "Orders", "count": 20, "icon": Icons.file_copy},
                  {
                    "title": "Pending",
                    "count": 45,
                    "icon": Icons.access_alarms_sharp
                  },
                  {
                    "title": "Confirmed",
                    "count": 36,
                    "icon": Icons.done_outline_rounded
                  }
                ];
                // print(snapshot.data!.snapshot.child("users").children.length);
                return ListView(
                  // shrinkWrap: true,
                  controller: Controller.scrollController,

                  children: [
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // controller: Controller.scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width > 600 ? 4 : 2,
                        childAspectRatio: 2,
                      ),
                      itemCount: Variable.gridInfoList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 5,
                            // shadowColor: Colors.black,
                            // color: Colors.white54,
                            child: ListTile(
                              // contentPadding: EdgeInsetsGeometry.infinity,
                              // visualDensity:
                              //     VisualDensity.adaptivePlatformDensity,
                              title: Text(
                                _gridInfoList[index]["title"],
                                style: Theme.of(context).textTheme.headline4,
                              ),

                              leading: Icon(
                                _gridInfoList[index]["icon"],
                                color: Theme.of(context).colorScheme.secondary,
                                size: size.width * 0.05,
                              ),
                              onTap: null,
                              trailing: Text(
                                _gridInfoList[index]["count"].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontSize: size.width > 600 ? 50 : 25,
                                    ),
                              ),
                            ));
                      },
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // controller: Controller.scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator.adaptive();
            }),
      ),
    );
  }
}
