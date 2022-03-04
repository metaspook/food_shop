import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/widgets/custom_divider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Method {
  // customDialog 2022-02-15
  static void customDialog({
    required BuildContext context,
    required String primaryButtonText,
    required Function primaryButtonFunction,
    String? secondaryButtonText,
    Function? secondaryButtonFunction,
    String? title,
    String? subtitle,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:
              Theme.of(ctx).scaffoldBackgroundColor.withOpacity(0.80),
          title: title == null
              ? null
              : Column(
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    const CustomDivider(),
                  ],
                ),
          content: subtitle == null
              ? null
              : Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(ctx).textTheme.headline4,
                ),
          actionsAlignment:
              secondaryButtonText == null && secondaryButtonFunction == null
                  ? null
                  : MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
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

  // static void initPrefsData() async {
  //   await Constant.prefsCrypt.getString(key).then((value) {
  //     Constant.prefsData = value;
  //   });
  // }

  /// Load data on "Constant.prefsData" global variable.
  // static void loadPrefsData(String key) async {
  //   Variable.prefsData[key] = await Variable.prefsCrypt.getString(key);
  // }

  // static void setPrefsData(String key, String value) {
  //   Variable.prefsData[key] = value;
  //   Variable.prefsCrypt.setString(key, value);
  // }

  // static String base64Encode(String str) {
  //   return base64.encode(utf8.encode('I like dogs'));
  // }

  // static String base64Decode() {

  // }
}
