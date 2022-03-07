import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:food_shop/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Variable {
  // Shared Preferences.
  static late final SharedPreferences prefs;
  static late final EncryptedSharedPreferences prefsCrypt;
  static final Map<String, String> prefsData = {};
  // static late final FirebaseDatabase dbRealtimeInstance;
  static late final FirebaseDatabase dbRealtime;
  static List<User> userList = const [];
  static final List<Map<String, dynamic>> gridInfoList = [
    {
      "title": "Users",
      "count": Variable.userList.length,
      "icon": Icons.supervised_user_circle_sharp
    },
    {"title": "Orders", "count": 20, "icon": Icons.file_copy},
    {"title": "Pending", "count": 45, "icon": Icons.access_alarms_sharp},
    {"title": "Confirmed", "count": 36, "icon": Icons.done_outline_rounded}
  ];
}
