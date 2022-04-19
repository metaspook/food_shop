import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class XService {
  XService._();

  static Future<File?> imageCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    return _imageCrop(pickedFile!.path);
  }

  static Future<File?> imageGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    return _imageCrop(pickedFile!.path);
  }

  static Future<File?> _imageCrop(String path) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      maxHeight: 1080,
      maxWidth: 1080,
    );
  }
}
