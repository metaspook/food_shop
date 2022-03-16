import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/pages/profile.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/method.dart';
import 'package:food_shop/utils/validator.dart';
import 'package:food_shop/utils/variable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  static const Base64Codec base64 = Base64Codec();

  @override
  void dispose() {
    super.dispose();
    Controller.fullNameController.dispose();
    Controller.emailController.dispose();
    Controller.passwordController.dispose();
    Controller.phoneController.dispose();
    Controller.addressController.dispose();
  }

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
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    controller: Controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
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
                              title: Text('Please choose an option'),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.camera),
                                    label: Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () => _getFromGallery(),
                                    icon: Icon(Icons.image),
                                    label: Text('Gallery'),
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
              controller: Controller.passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: Controller.fullNameController,
              keyboardType: TextInputType.name,
              // maxLength: 40,
              validator: (value) => Validator.isEmpty(value),
              decoration: InputDecoration(
                // hintText: 'Name',
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: Controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: Controller.addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            FittedBox(
              child: ElevatedButton.icon(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  // Constant.prefsCrypt.setString('test1', 'This is test1');
                  // Constant.prefsCrypt.setString('test1', 'This is test2');
                  // Constant.prefsCrypt.setString('test1', 'This is test3');
                  // Constant.prefsCrypt.setString('test1', 'This is test7');
                  // Method.setPrefsData("userList", "This is test115");
                  // "id": 1,
                  //         "fullName": Controller.fullNameController.text,
                  //         "email": Controller.emailController.text,
                  //         "password": Controller.passwordController.text,
                  //         "phone": Controller.phoneController.text,
                  //         "address": Controller.addressController.text,
                  //  id: 1,
                  //         fullName: Controller.fullNameController.text,
                  //         email: Controller.emailController.text,
                  //         password: Controller.passwordController.text,
                  //         phone: Controller.phoneController.text,
                  //         address: Controller.addressController.text,
                  // Method.setPrefsData(
                  //   "userList",
                  //   jsonEncode([
                  //     ...jsonDecode(Variable.prefsData["userList"]!),
                  //     {
                  //       "id":
                  //           jsonDecode(Variable.prefsData["userList"]!).length +
                  //               1,
                  //       "fullName": Controller.fullNameController.text,
                  //       "email": Controller.emailController.text,
                  //       "password": Controller.passwordController.text,
                  //       "phone": Controller.phoneController.text,
                  //       "address": Controller.addressController.text,
                  //     }
                  //   ]),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );
                  // }

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfilePage(),
                  //   ),
                  // );
                  // createData();
                },
                icon: Icon(Icons.login),
                label: Text('Sign up'),
              ),
              // label: CircularProgressIndicator()),
            ),
            Text(Controller.fullNameController.text),
          ],
        ),
      ),
    );
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
}

// void createData() {
  // Variable.dbRealtime.child("users").push().set([
  //   {'name': 'Yashwant Kumar', 'description': 'Senior Software Engineer'},
  //   {'name': 'Yashwant Kumar', 'description': 'Senior Software Engineer'},
  //   {'name': 'Yashwant Kumar', 'description': 'Senior Software Engineer'},
  // ]);

  // Variable.dbRealtime.child("categories/").update(
  //     // "Category One",
  //     // "Category Two",
  //     // {"description": "Team Lead", "name": "Deepak Nishad"},
  //     {"description": "Team Lexxad", "name": "Deepak Nishcccadf"});
// }

