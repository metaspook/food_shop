import 'package:flutter/material.dart';
import 'package:food_shop/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(controller.currentAppTitle),
        ),
        body: controller.currentView);
  }
}
