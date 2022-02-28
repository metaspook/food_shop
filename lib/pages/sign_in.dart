import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'E-mail'),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Password'),
              ),
              ElevatedButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.login),
                  label: Text('Sign in'))
            ],
          ),
        ),
      ),
    );
  }
}
