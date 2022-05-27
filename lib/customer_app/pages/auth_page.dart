import 'package:flutter/material.dart';
import 'package:food_shop/controllers/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Scaffold(
        key: controller.scaffoldKey,
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(controller.currentAppTitle),
        // ),
        body: SafeArea(
          child: ListView(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 45, bottom: 15),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/food_shop.png", scale: 5),
                  Text(
                    'Food Shop',
                    style: GoogleFonts.lobster(
                        textStyle: Theme.of(context).textTheme.headline2),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Form(key: controller.formKey, child: controller.currentView),
            ],
          ),
        ));
  }
}
