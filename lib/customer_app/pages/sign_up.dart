import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/auth_controller.dart';
import 'package:food_shop/controllers/x_controller.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // File? _imageFile;
  // String? _imageUrl;
  final formKey = GlobalKey<FormState>();
  // final bool _isLoading = false;
  // static const Base64Codec base64 = Base64Codec();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Account'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemExtent: 75,
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
                        ..onTap = () => Methods.navPop(context),
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
                  child: TextField(
                    controller: XController.email,
                    keyboardType: TextInputType.emailAddress,
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
                      child: AuthController.imageFile == null
                          ? Image.asset('assets/images/placeholder_user_00.jpg')
                          : Image.file(AuthController.imageFile!),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async =>
                                        AuthController.setImageFile(
                                            await Methods.pickCameraImage(
                                                context)),
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () async =>
                                        AuthController.setImageFile(
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
            TextField(
              controller: XController.password,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: XController.fullName,
              keyboardType: TextInputType.name,
              // maxLength: 40,
              validator: (value) => Validator.isEmpty(value),
              decoration: const InputDecoration(
                // hintText: 'Name',
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: XController.phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: XController.address,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            FittedBox(
              child: ElevatedButton.icon(
                onPressed: () async => await AuthController.signUp(
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
      ),
    );
  }
}
