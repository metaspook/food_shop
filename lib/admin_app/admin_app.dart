import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/pages/admin_page.dart';

class AdminApp extends StatelessWidget {
  /// Admin app is a Web app.
  const AdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Shop Admin',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.pink,
        ),
      ),
      // initialRoute: Routes.initialRoute,
      // routes: Routes.adminRoutes,
      home: const AdminPage(),
    );
  }
}
