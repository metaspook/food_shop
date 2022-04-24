import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/services/services.dart';

class ProfileController extends ChangeNotifier {
  static bool _editModeField = false;
  static bool _editModePicture = false;
  bool get editModeField => _editModeField;
  bool get editModePicture => _editModePicture;
  static File? _imageFile;
  File? get imageFile => _imageFile;
  void setImageFile(File? imageFile) {
    if (imageFile != null) {
      _imageFile = imageFile;
      editModePictureOn();
    }
  }

  void editModeFieldOn() {
    _editModeField = true;
    notifyListeners();
  }

  void editModePictureOn() {
    _editModePicture = true;
    notifyListeners();
  }

  Future<void> editModeFieldOff(String userId) async {
    if (XController.fullName.text.isNotEmpty) {
      await Database.dbRealtime
          .ref("users/$userId/fullName")
          .set(XController.fullName.text);
      XController.fullName.clear();
    }
    if (XController.email.text.isNotEmpty) {
      await Database.dbRealtime
          .ref("users/$userId/email")
          .set(XController.email.text);
      XController.email.clear();
    }
    if (XController.phone.text.isNotEmpty) {
      await Database.dbRealtime
          .ref("users/$userId/phone")
          .set(XController.phone.text);
      XController.phone.clear();
    }
    if (XController.address.text.isNotEmpty) {
      await Database.dbRealtime
          .ref("users/$userId/address")
          .set(XController.address.text);
      XController.address.clear();
    }

    _editModeField = false;
    notifyListeners();
  }

  Future<void> editModePictureOff(String userId) async {
    final storageRef = FirebaseStorage.instance.ref("images/users/$userId.jpg");
    if (imageFile != null) {
      await storageRef.putFile(imageFile!);
      await Database.dbRealtime
          .ref("users/$userId/image")
          .set(await storageRef.getDownloadURL());
      _imageFile = null;
      _editModePicture = false;
      notifyListeners();
    }
  }
}
