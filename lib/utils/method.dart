import 'package:flutter/material.dart';
import 'package:food_shop/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Method {
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
    Method.customDialog(
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
              Theme.of(ctx).scaffoldBackgroundColor.withOpacity(0.75),
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
