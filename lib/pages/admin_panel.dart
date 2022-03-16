import 'dart:convert';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/pages/fake_uploader.dart';
import 'package:food_shop/pages/views/dashboard_view.dart';
import 'package:food_shop/pages/views/downloads_view.dart';
import 'package:food_shop/pages/views/orders_view.dart';
import 'package:food_shop/pages/views/users_view.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/method.dart';
import 'package:food_shop/utils/variable.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // late final List<User> _userList;
  // User.fromJsonStringList(Constant.prefs.getStringList("userList")!);

  @override
  void dispose() {
    super.dispose();
    Controller.pageController.dispose();
    Controller.scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Variable.dbRealtime.ref("users").once().then((value) {
      Variable.userList = [
        for (var e in value.snapshot.children)
          User.fromJson(e.value as Map<String, dynamic>)
      ];
    });
    Variable.dbRealtime.ref("orders").once().then((value) {
      Variable.orderList = [
        for (var e in value.snapshot.children)
          Order.fromJson(e.value as Map<String, dynamic>)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Method.setCounter();

    // List<User> userList =
    //     // User.fromJsonListString(Constant.prefsData["userList"]!);
    //     [
    //   for (Map<String, dynamic> e
    //       in jsonDecode(Constant.prefsData["userList"]!))
    //     User.fromJson(e)
    // ];
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Admin Panel'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: Controller.pageController,
            style: SideMenuStyle(
              displayMode: size.width > 800
                  ? SideMenuDisplayMode.open
                  : SideMenuDisplayMode.compact,
              hoverColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              selectedColor: Theme.of(context).colorScheme.secondary,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // backgroundColor: Colors.amber,
              openSideMenuWidth: 225,
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      'assets/images/task_schedule_00.png',
                      // fit: BoxFit.none,
                    ),
                  ),
                ),
                const Divider(indent: 8.0, endIndent: 8.0),
              ],
            ),
            footer: Text('© 2022 Metaspook',
                style: Theme.of(context).textTheme.subtitle1),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                onTap: () {
                  Controller.pageController.jumpToPage(0);
                },
                icon: Icons.home,
              ),
              SideMenuItem(
                priority: 2,
                title: 'Orders',
                onTap: () {
                  Controller.pageController.jumpToPage(2);
                },
                icon: Icons.file_copy_rounded,
              ),
              SideMenuItem(
                priority: 1,
                title: 'Users',
                onTap: () {
                  Controller.pageController.jumpToPage(1);
                },
                icon: Icons.supervisor_account,
              ),
              SideMenuItem(
                priority: 3,
                title: 'Download',
                onTap: () {
                  Controller.pageController.jumpToPage(3);
                },
                icon: Icons.download,
              ),
              SideMenuItem(
                priority: 4,
                title: 'Settings',
                onTap: () {
                  Controller.pageController.jumpToPage(4);
                },
                icon: Icons.settings,
              ),
              SideMenuItem(
                priority: 5,
                title: 'Fake Uploader',
                onTap: () {
                  Controller.pageController.jumpToPage(5);
                },
                icon: Icons.settings,
              ),
              SideMenuItem(
                priority: 6,
                title: 'Exit',
                onTap: () async {},
                icon: Icons.exit_to_app,
              ),
            ],
          ),
          size.width < 600
              ? Flexible(
                  child: Center(
                    child: Container(
                      color: Colors.red,
                      child: FittedBox(
                        child: Text(' Unsupported Screen! ',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                )),
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: PageView(
                    controller: Controller.pageController,
                    children: [
                      DashboardView(),
                      OrdersView(),
                      UsersView(),
                      Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Page\n   3',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      DownloadsView(),
                      FakeUploader(),
                      Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Page\n   5',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),

      // drawer: Drawer(
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: ListView(
      //           padding: EdgeInsets.zero,
      //           children: [
      //             const UserAccountsDrawerHeader(
      //               accountName: Text('User'),
      //               accountEmail: Text('user@email.com'),
      //               currentAccountPicture: CircleAvatar(
      //                 child: Icon(Icons.android),
      //               ),
      //             ),
      //             ListTile(
      //               leading: const Icon(Icons.home),
      //               title: const Text('PageTitles.home'),
      //               onTap: null,
      //               // selected: _selectedRoute == RouteNames.home,
      //             ),
      //             ListTile(
      //               leading: const Icon(Icons.photo_library),
      //               title: const Text('PageTitles.gallery'),
      //               onTap: null,
      //             ),
      //             ListTile(
      //               leading: const Icon(Icons.slideshow),
      //               title: const Text('PageTitles.slideshow'),
      //               onTap: null,
      //             ),
      //             const Divider(),
      //             ListTile(
      //               leading: const Icon(Icons.settings),
      //               title: const Text('PageTitles.settings'),
      //               onTap: null,
      //             ),
      //           ],
      //         ),
      //       ),
      //       const VerticalDivider(width: 3)
      //     ],
      //   ),
      // ),
      // body: Container(),
    );
  }
}

void _fetchE() async {
  final DataSnapshot ff = await Variable.dbRealtime
      .ref("orders")
      .orderByChild("status")
      .equalTo("Pending")
      .get();
  // .then((value) {
  // for (var e in value.children) {
  //   print(value.children.length);
  // }
  Variable.counterList["Pending"]!["count"] = ff.children.length;
  print(Variable.counterList["Pending"]!["count"]);
  // print(value.children);
  // });
  // ff.;
}
