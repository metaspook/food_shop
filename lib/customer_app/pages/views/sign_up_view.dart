import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/utils/validator.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = context.watch<AuthController>();

    return Form(
      key: formKey,
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
              Flexible(
                child: TextFormField(
                  controller: XController.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validator.email(value),
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
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
          TextFormField(
            controller: XController.password,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => Validator.password(value),
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          TextFormField(
            controller: XController.fullName,
            keyboardType: TextInputType.name,
            // maxLength: 40,
            validator: (value) => Validator.fullName(value),
            decoration: const InputDecoration(
              // hintText: 'Name',
              labelText: "Full Name",
              border: OutlineInputBorder(),
            ),
          ),
          TextFormField(
            controller: XController.phone,
            keyboardType: TextInputType.phone,
            validator: (value) => Validator.phone(value),
            decoration: const InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
          ),
          TextFormField(
            controller: XController.address,
            keyboardType: TextInputType.streetAddress,
            validator: (value) => Validator.nullOrEmpty(value),
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          FittedBox(
            child: ElevatedButton.icon(
              onPressed: () async =>
                  await context.read<AuthController>().signUp(
                        context,
                        formKey: formKey,
                      ),
              icon: const Icon(Icons.app_registration_rounded),
              label: const Text('Sign Up'),
            ),
            // label: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
