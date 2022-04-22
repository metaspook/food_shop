import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/admin_app/pages/views/views.dart';
import 'package:food_shop/controllers/x_controller.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void dispose() {
    super.dispose();
    XController.page.dispose();
    XController.scroll.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            controller: XController.page,
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
                onTap: () => XController.page.jumpToPage(0),
                icon: Icons.home,
              ),
              SideMenuItem(
                priority: 1,
                title: 'Orders',
                onTap: () => XController.page.jumpToPage(1),
                icon: Icons.file_copy_rounded,
              ),
              SideMenuItem(
                priority: 2,
                title: 'Products',
                onTap: () => XController.page.jumpToPage(2),
                icon: FontAwesomeIcons.utensils,
              ),
              SideMenuItem(
                priority: 3,
                title: 'Users',
                onTap: () => XController.page.jumpToPage(3),
                icon: Icons.supervisor_account,
              ),
              SideMenuItem(
                priority: 4,
                title: 'Settings',
                onTap: () => XController.page.jumpToPage(4),
                icon: Icons.settings,
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
                    controller: XController.page,
                    children: const [
                      DashboardView(),
                      OrdersView(),
                      ProductsView(),
                      UsersView(),
                      SettingsView(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
