import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  static const double _formGap = 20;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();

    return Column(
      children: [
        InputForm.email(),
        const SizedBox(height: _formGap),
        InputForm.password(),
        const SizedBox(height: _formGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text.rich(
              TextSpan(
                text: "Don't have an account?",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(text: '   '),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.signInCleaner;
                          context.read<AuthController>().setIndex(1);
                        },
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
              onPressed: () async {
                String? msg;
                if (controller.formKey.currentState!.validate()) {
                  Methods.snackBar(
                      controller.formKey.currentContext!, 'Logging In...');
                  context.read<BottomNavController>().setIndex(0);
                  msg = await context.read<AuthController>().signIn();
                }
                if (msg != null) {
                  Methods.snackBar(controller.formKey.currentContext!, msg);
                }
              },
              icon: const Icon(Icons.login),
              label: const Text('Sign In'),
            ),
          ],
        ),
      ],
    );
  }
}
