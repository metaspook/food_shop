import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringExtension on String {
  String get hashCrypt =>
      md5.convert(utf8.encode(base64.encode(utf8.encode(this)))).toString();
}
