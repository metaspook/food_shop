import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_shop/services/database.dart';
import 'package:food_shop/utils/utils.dart';

class UserController {
  static Future<void> remove(String userId) async {
    await Database.dbRealtime.ref("users/$userId").remove();
    await Variable.fbStorage.ref("images/users/$userId.jpg").delete();
  }

  static Future<void> signUp(BuildContext context,
      {required GlobalKey<FormState> formKey, File? imageFile}) async {
    if (formKey.currentState!.validate()) {
      try {
        Method.snackBar(context, 'Processing Data...');
        final dbRefPush = Database.dbRealtime.ref("users").push();
        String? imageUrl;
        if (imageFile != null) {
          final storageRef =
              Variable.fbStorage.ref("images/users/${dbRefPush.key}.jpg");
          await storageRef.putFile(imageFile);
          imageUrl = await storageRef.getDownloadURL();
        }
        await dbRefPush.set({
          "id": dbRefPush.key,
          "fullName": Controller.fullName.text,
          "email": Controller.email.text,
          "password": Controller.password.text.hashCrypt,
          "phone": Controller.phone.text,
          "address": Controller.address.text,
          "image": imageUrl,
        });
        Method.snackBar(context, 'Account Created!');
        Controller.signUpDisposer;
      } catch (err) {
        Method.snackBar(context, err.toString());
      }
    }
  }
}
