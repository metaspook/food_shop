import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/utils/utils.dart';
import 'package:food_shop/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final formKey = context.watch<AuthController>().currentFormKey;
    final controller = context.watch<AuthController>();

    return Form(
      key: Constants.signUpFormKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemExtent: 90,
        children: [
          Text.rich(
            TextSpan(
              text: 'Already have an account?',
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              children: [
                const TextSpan(text: '   '),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => context.read<AuthController>().setIndex(0),
                    text: "Login",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue.shade300,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            textScaleFactor: 2,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: InputForm.email()),
              Stack(
                // alignment: AlignmentDirectional.topCenter,
                children: [
                  Card(
                    margin: const EdgeInsets.all(9),
                    child: controller.imageFile == null
                        ? Image.asset('assets/images/placeholder_user_00.jpg')
                        : Image.file(controller.imageFile!),
                  ),
                  Positioned(
                    top: -11,
                    right: -11,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () {
                        Methods.customDialog(
                          context: context,
                          title: const Text('Please choose an option'),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async => context
                                    .read<AuthController>()
                                    .setImageFile(
                                        await Methods.pickCameraImage(context)),
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () async => context
                                    .read<AuthController>()
                                    .setImageFile(
                                        await Methods.pickGalleryImage(
                                            context)),
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        );

                        Methods.customDialog(
                            context: context,
                            title: const Text('Please choose an option'),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    context.read<AuthController>().setImageFile(
                                        await Methods.pickCameraImage(context));
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async => context
                                      .read<AuthController>()
                                      .setImageFile(
                                          await Methods.pickGalleryImage(
                                              context)),
                                  icon: const Icon(Icons.image),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ));
                        // _showImageDialog(context);
                      },
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          InputForm.password(),
          InputForm.fullName(),
          InputForm.phone(),
          InputForm.address(),
          FittedBox(
            child: ElevatedButton.icon(
              onPressed: () async {
                String? msg;
                if (Constants.signUpFormKey.currentState!.validate()) {
                  Methods.snackBar(Constants.signUpFormKey.currentContext!,
                      'Creating Account...');
                  msg = await context.read<AuthController>().signUp();
                }
                if (msg != null) {
                  Methods.snackBar(
                      Constants.signInFormKey.currentContext!, msg);
                }
              },
              icon: const Icon(Icons.app_registration_rounded),
              label: const Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
