import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/pages/sign_up.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/extension.dart';
import 'package:food_shop/utils/method.dart';
import 'package:food_shop/utils/validator.dart';
import 'package:food_shop/utils/variable.dart';
import 'package:food_shop/widgets/input_form.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  File? _imageFile;
  String? _imageUrl;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  static const Base64Codec base64 = Base64Codec();
  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign In'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemExtent: 75,
                children: [
                  InputForm.email,
                  InputForm.password,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: '   '),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpPage(),
                                    ),
                                  ),
                            text: "Create Here",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue.shade300,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    textScaleFactor: 1,
                  ),
                  ElevatedButton.icon(
                    onPressed: _userSignIn,
                    icon: Icon(Icons.login),
                    label: Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _userSignIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        Method.snackBar(context, 'Processing Data...');
        // final dbRef =
        //     await Variable.dbRealtime.ref("users").get().then((value) {
        //   value.children;
        // });
        await Variable.dbRealtime
            .ref("users")
            .orderByChild("email")
            .equalTo(Controller.email.text)
            .once()
            .then((value) {
          if (value.snapshot.value == null) {
            Method.snackBar(context, "Email doesn't exists!");
          } else {
            final matchedData = value.snapshot.value as Map;
            for (Map e in matchedData.values) {
              // isAuthenticated =
              if (e["password"] == Controller.password.text.hashCrypt) {
                isAuthenticated = true;
                return Method.snackBar(context, "User authenticated.");
              }
              return Method.snackBar(context, "Password doesn't match!");
              // break;
            }
          }
        });

        //   .onValue
        //   .listen((event) {
        // Variable.counterList[status]!["count"] = event.snapshot.children.length;
        // });
        // await dbRef.set({
        //   "id": dbRef.key,
        //   "fullName": Controller.fullName.text,
        //   "email": Controller.email.text,
        //   "password": Controller.password.text.hashCrypt,
        //   "phone": Controller.phone.text,
        //   "address": Controller.address.text,
        //   "image": _imageUrl,
        // });
        // Method.snackBar(context, 'Account Created!');
      } catch (err) {
        Method.snackBar(context, err.toString());
      }
    }
  }
}
