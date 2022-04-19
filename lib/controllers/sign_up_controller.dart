import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/services/database.dart';
import 'package:food_shop/utils/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController {
  SignUpController._();

  static File? _imageFile;
  static late String _imageUrl;
  static late String _uid;

  static File? get imageFile => _imageFile;

  static Future<void> submitUser(
    BuildContext context, {
    required GlobalKey<FormState> formKey,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        Methods.snackBar(context, 'Processing Data...');
        // Create new user and set UID.
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: XController.email.text,
              password: XController.password.text,
            )
            .then((userCredential) => _uid = userCredential.user!.uid);
        // } on FirebaseAuthException catch (e) {
        //   if (e.code == 'weak-password') {
        //     print('The password provided is too weak.');
        //   } else if (e.code == 'email-already-in-use') {
        //     print('The account already exists for that email.');
        //   }
        // Set User DB and Storage references.
        final dbRef = Database.dbRealtime.ref("users/$_uid");
        final storageRef =
            FirebaseStorage.instance.ref("images/users/$_uid.jpg");
        // Upload User image to Storage.
        _imageFile == null
            ? Methods.snackBar(context, 'Please pick an image!!')
            : await storageRef.putFile(_imageFile!);
        // Get User image url.
        _imageUrl = await storageRef.getDownloadURL();
        // Upload User data to DB.
        await dbRef.set({
          "id": _uid,
          "fullName": XController.fullName.text,
          "email": XController.email.text,
          "password": XController.password.text.hashCrypt,
          "phone": XController.phone.text,
          "address": XController.address.text,
          "image": _imageUrl,
        });
        Methods.snackBar(context, 'Account Created!');
        XController.signUpDisposer;
      } catch (err) {
        Methods.snackBar(context, err.toString());
      }
    }
  }

  static Future<void> setImageCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Methods.navPop(context);
  }

  static Future<void> setImageGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Methods.navPop(context);
  }

  static Future<void> _cropImage(String path) async {
    _imageFile = await ImageCropper().cropImage(
      sourcePath: path,
      maxHeight: 1080,
      maxWidth: 1080,
    );
  }
}
