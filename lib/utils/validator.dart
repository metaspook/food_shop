import 'package:validators/validators.dart';

class Validator {
  Validator._();
  // final _charSet = const {
  //   // "special":    r'!"#$%&'()*+,- ./:;<=>?@[\]^_`{|}~',
  //   "uppercase": "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
  //   "lowercase": "abcdefghijklmnopqrstuvwxyz",
  //   "number": "0123456789",
  // };
  static const _phoneLength = 6;
  static const _passLength = 6;

  /// validate if a string [str] is null or empty;
  static String? nullOrEmpty(String? str) {
    return (str == null || str.isEmpty) ? "This field can't be empty" : null;
  }

  static String? fullName(String? value) {
    return nullOrEmpty(value) ??
        (isUppercase(value![0]) ? null : "First character should be uppercase");
  }

  static String? email(String? value) {
    return nullOrEmpty(value) ??
        (isEmail(value!) ? null : "Not a valid email!");
  }

  static String? password(String? str) {
    return nullOrEmpty(str) ??
        (str!.length >= _passLength ? null : "Must be at least 6 characters!");
  }

  static String? phone(String? str) {
    return nullOrEmpty(str) ??
        ((str![0] == '+' || isNumeric(str[0])) &&
                isNumeric(str.substring(1, str.length)) &&
                str.length >= _phoneLength
            ? null
            : "Not a valid phone number!");
  }
}
