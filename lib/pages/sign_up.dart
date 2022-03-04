import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/pages/profile.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/method.dart';
import 'package:food_shop/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  static const Base64Codec base64 = Base64Codec();

  @override
  void dispose() {
    super.dispose();
    Controller.fullNameController.dispose();
    Controller.emailController.dispose();
    Controller.passwordController.dispose();
    Controller.phoneController.dispose();
    Controller.addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          itemExtent: 75,
          children: [
            TextFormField(
              controller: Controller.fullNameController,
              keyboardType: TextInputType.name,
              maxLength: 40,
              validator: (value) => Validator.isEmpty(value),
              decoration: InputDecoration(
                // hintText: 'Name',
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: Controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: Controller.passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: Controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: Controller.addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            FittedBox(
              child: ElevatedButton.icon(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  // Constant.prefsCrypt.setString('test1', 'This is test1');
                  // Constant.prefsCrypt.setString('test1', 'This is test2');
                  // Constant.prefsCrypt.setString('test1', 'This is test3');
                  // Constant.prefsCrypt.setString('test1', 'This is test7');
                  // Method.setPrefsData("userList", "This is test115");
                  // "id": 1,
                  //         "fullName": Controller.fullNameController.text,
                  //         "email": Controller.emailController.text,
                  //         "password": Controller.passwordController.text,
                  //         "phone": Controller.phoneController.text,
                  //         "address": Controller.addressController.text,
                  //  id: 1,
                  //         fullName: Controller.fullNameController.text,
                  //         email: Controller.emailController.text,
                  //         password: Controller.passwordController.text,
                  //         phone: Controller.phoneController.text,
                  //         address: Controller.addressController.text,
                  // Method.setPrefsData(
                  //   "userList",
                  //   jsonEncode([
                  //     ...jsonDecode(Variable.prefsData["userList"]!),
                  //     {
                  //       "id":
                  //           jsonDecode(Variable.prefsData["userList"]!).length +
                  //               1,
                  //       "fullName": Controller.fullNameController.text,
                  //       "email": Controller.emailController.text,
                  //       "password": Controller.passwordController.text,
                  //       "phone": Controller.phoneController.text,
                  //       "address": Controller.addressController.text,
                  //     }
                  //   ]),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );
                  // }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                icon: Icon(Icons.login),
                label: Text('Sign up'),
              ),
              // label: CircularProgressIndicator()),
            ),
            Text(Controller.fullNameController.text),
          ],
        ),
      ),
    );
  }
}
