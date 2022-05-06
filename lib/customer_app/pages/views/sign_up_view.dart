import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  static const double _formGap = 20;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: InputForm.email()),
            Stack(
              // alignment: AlignmentDirectional.topCenter,
              children: [
                SizedBox(
                  width: 76,
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 9),
                    child: controller.imageFile == null
                        ? Image.asset('assets/images/placeholder_user_00.jpg')
                        : Image.file(controller.imageFile!),
                  ),
                ),
                Positioned(
                  top: -14,
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
                                      await Methods.pickGalleryImage(context)),
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
        const SizedBox(height: _formGap),
        for (var e in [
          InputForm.password(),
          InputForm.fullName(),
          InputForm.phone(),
          InputForm.address(),
        ]) ...[e, const SizedBox(height: _formGap)],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              textScaleFactor: 1,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                String? msg;
                if (controller.formKey.currentState!.validate()) {
                  Methods.snackBar(controller.formKey.currentContext!,
                      'Creating Account...');
                  msg = await context.read<AuthController>().signUp();
                }
                if (msg != null) {
                  Methods.snackBar(controller.formKey.currentContext!, msg);
                }
              },
              icon: const Icon(Icons.app_registration_rounded),
              label: const Text('Sign Up'),
            ),
          ],
        ),
      ],
    );
  }
}
