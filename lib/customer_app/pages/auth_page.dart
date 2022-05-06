import 'package:flutter/material.dart';
import 'package:food_shop/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(controller.currentAppTitle),
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/food_shop.png", scale: 5),
                Text(
                  'Food Shop',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            const SizedBox(height: 25),
            Form(key: controller.formKey, child: controller.currentView),
          ],
        ));
  }
}
