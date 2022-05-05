import 'package:flutter/material.dart';
import 'package:food_shop/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Scaffold(
        key: context.read<AuthController>().scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(controller.currentAppTitle),
        ),
        body: controller.currentView);
  }
}
