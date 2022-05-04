import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemExtent: 75,
              children: [
                InputForm.email(),
                InputForm.password(),
              ],
            ),
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
                            ..onTap = () =>
                                context.read<AuthController>().setIndex(1),
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
                    if (formKey.currentState!.validate()) {
                      context.read<BottomNavController>().setIndex(0);
                      await context.read<AuthController>().signIn(context);
                    }
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
