import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Admin Dashboard'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.25),

              selectedColor: Theme.of(context).colorScheme.secondary,
              selectedTitleTextStyle: TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // backgroundColor: Colors.amber
              // openSideMenuWidth: 200
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
                Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'mohada',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                onTap: () {
                  page.jumpToPage(0);
                },
                icon: Icons.home,
              ),
              SideMenuItem(
                priority: 1,
                title: 'Users',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: Icons.supervisor_account,
              ),
              SideMenuItem(
                priority: 2,
                title: 'Files',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: Icons.file_copy_rounded,
              ),
              SideMenuItem(
                priority: 3,
                title: 'Download',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: Icons.download,
              ),
              SideMenuItem(
                priority: 4,
                title: 'Settings',
                onTap: () {
                  page.jumpToPage(4);
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
              controller: page,
              children: [
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Page\n   1',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Page\n   2',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
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
