import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/widgets/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Methods {
  Methods._();

  static Future<File?> pickCameraImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    navPop(context);
    navPop(context);
    return await cropImage(pickedFile!.path);
  }

  static Future<File?> pickGalleryImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    navPop(context);
    navPop(context);
    return await cropImage(pickedFile!.path);
  }

  static Future<File?> cropImage(String path) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      maxHeight: 1080,
      maxWidth: 1080,
    );
  }

  static Map<String, dynamic> objectToMap(Object? obj) {
    obj as Map;
    final Map<String, dynamic> objMap = {};
    obj.forEach((k, v) => objMap[k] = v);
    return objMap;
  }

  static void snackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  static void navPop(BuildContext context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  static void orderDeleteDialog(BuildContext context, String orderId) {
    customDialogText(
      title: '⚠️  Caution!',
      subtitle: 'Do you want to delete this Order?',
      context: context,
      primaryButtonText: 'Cancel',
      primaryButtonFunction: () => Methods.navPop(context),
      secondaryButtonText: 'Confirm',
      secondaryButtonFunction: () {
        Methods.navPop(context);
        OrdersController.remove(orderId);
        Methods.navPop(context);
      },
    );
  }

  static void userDeleteDialog(BuildContext context, String userId) {
    customDialogText(
      title: '⚠️  Caution!',
      subtitle: 'Do you want to delete this User?',
      context: context,
      primaryButtonText: 'Cancel',
      primaryButtonFunction: () => Methods.navPop(context),
      secondaryButtonText: 'Confirm',
      secondaryButtonFunction: () {
        UsersController.remove(userId);
        Methods.navPop(context);
      },
    );
  }

  // customDialog 2022-02-15
  static void customDialogText({
    required BuildContext context,
    required String primaryButtonText,
    required Function primaryButtonFunction,
    String? secondaryButtonText,
    Function? secondaryButtonFunction,
    String? title,
    String? subtitle,
  }) {
    Methods.customDialog(
      context: context,
      primaryButtonText: primaryButtonText,
      primaryButtonFunction: primaryButtonFunction,
      secondaryButtonText: secondaryButtonText,
      secondaryButtonFunction: secondaryButtonFunction,
      title: title == null ? null : Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
    );
  }

  static void customDialog({
    required BuildContext context,
    String? primaryButtonText,
    Function? primaryButtonFunction,
    String? secondaryButtonText,
    Function? secondaryButtonFunction,
    Widget? title,
    Widget? subtitle,
  }) {
    showDialog(
      barrierDismissible:
          (primaryButtonText == null && primaryButtonFunction == null)
              ? true
              : false,
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:
              Theme.of(ctx).scaffoldBackgroundColor.withOpacity(0.85),
          title: title == null
              ? null
              : Column(
                  children: <Widget>[
                    title,
                    const SizedBox(height: 5),
                    const CustomDivider(),
                  ],
                ),
          content: subtitle,
          actionsAlignment:
              secondaryButtonText == null && secondaryButtonFunction == null
                  ? null
                  : MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            if (primaryButtonText != null && primaryButtonFunction != null)
              GestureDetector(
                onTap: () => primaryButtonFunction(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(primaryButtonText,
                      style: const TextStyle(fontSize: 18)),
                ),
              ),
            if (secondaryButtonText != null && secondaryButtonFunction != null)
              GestureDetector(
                onTap: () => secondaryButtonFunction(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(secondaryButtonText,
                      style: const TextStyle(fontSize: 18)),
                ),
              ),
          ],
        );
      },
    );
  }

  static Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
}
