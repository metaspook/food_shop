import 'dart:convert';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/pages/views/dashboard.dart';
import 'package:food_shop/pages/views/orders.dart';
import 'package:food_shop/pages/views/users.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';

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
    // Constant.prefs.setStringList("userList", ["user1"]);
    // _userList = (Constant.prefs.getStringList("userList") == null ||
    //         Constant.prefs.getStringList("userList")!.isEmpty)
    //     ? []
    //     : User.fromJsonStringList(Constant.prefs.getStringList("userList")!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              displayMode: SideMenuDisplayMode.auto,
              hoverColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              selectedColor: Theme.of(context).colorScheme.secondary,
              selectedTitleTextStyle: TextStyle(color: Colors.white),
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
                priority: 1,
                title: 'Users',
                onTap: () {
                  Controller.pageController.jumpToPage(1);
                },
                icon: Icons.supervisor_account,
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
                priority: 6,
                title: 'Exit',
                onTap: () async {},
                icon: Icons.exit_to_app,
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: Controller.pageController,
              children: [
                DashboardView(),
                UsersView(),
                OrdersView(),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Page\n   3',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Page\n   4',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
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
