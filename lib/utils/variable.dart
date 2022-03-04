import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Variable {
  // Shared Preferences.
  static late final SharedPreferences prefs;
  static late final EncryptedSharedPreferences prefsCrypt;
  static final Map<String, String> prefsData = {};
}
