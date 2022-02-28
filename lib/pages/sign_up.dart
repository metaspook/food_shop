import 'package:flutter/material.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var ff = Controller.addressController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemExtent: 75,
        children: [
          TextField(
            controller: Controller.fullNameController,
            decoration: InputDecoration(
              // hintText: 'Name',
              labelText: "Full Name",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: Controller.emailController,
            decoration: InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: Controller.passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: Controller.phoneController,
            decoration: InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: Controller.addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          FittedBox(
            child: ElevatedButton.icon(
                onPressed: () => setState(() {}),
                icon: Icon(Icons.login),
                label: Text('Sign up')),
          ),
          Text(Controller.fullNameController.text),
        ],
      ),
    );
  }
}
