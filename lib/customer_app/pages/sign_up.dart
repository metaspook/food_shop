import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/x_controller.dart';
import 'package:food_shop/utils/extension.dart';
import 'package:food_shop/utils/method.dart';
import 'package:food_shop/utils/validator.dart';
import 'package:food_shop/utils/variables.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _imageFile;
  String? _imageUrl;
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  static const Base64Codec base64 = Base64Codec();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Account'),
      ),
      body: Form(
        key: _formKey,
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
                        ..onTap = () => Method.navPop(context),
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
                      child: _imageFile == null
                          ? Image.asset('assets/images/placeholder_user_00.jpg')
                          : Image.file(_imageFile!),
                    ),
                    Positioned(
                      top: -11,
                      right: -11,
                      child: IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () {
                          Method.customDialog(
                              context: context,
                              title: const Text('Please choose an option'),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: _getFromCamera,
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: _getFromGallery,
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
                onPressed: _userSignUp,
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

  Future<void> _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    // setState(() => imageFile = File(pickedFile!.path));
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  Future<void> _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    // setState(() => imageFile = File(pickedFile!.path));
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  Future<void> _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if (croppedImage != null) setState(() => _imageFile = croppedImage);
  }

  Future<void> _userSignUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        Method.snackBar(context, 'Processing Data...');
        final dbRef = Variables.dbRealtime.ref("users").push();
        final storageRef =
            Variables.fbStorage.ref("images/users/${dbRef.key}.jpg");
        await storageRef.putFile(_imageFile!);
        _imageUrl = await storageRef.getDownloadURL();
        await dbRef.set({
          "id": dbRef.key,
          "fullName": XController.fullName.text,
          "email": XController.email.text,
          "password": XController.password.text.hashCrypt,
          "phone": XController.phone.text,
          "address": XController.address.text,
          "image": _imageUrl,
        });
        Method.snackBar(context, 'Account Created!');
        XController.signUpDisposer;
      } catch (err) {
        Method.snackBar(context, err.toString());
      }
    }
  }
}
