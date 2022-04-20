import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/admin_app.dart';
import 'package:food_shop/customer_app/customer_app.dart';
import 'package:food_shop/firebase_options.dart';
import 'package:food_shop/utils/constants.dart';
import 'package:food_shop/utils/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Ensure initialization to prevent error.
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions.fromMap(firebaseOptions));
    runApp(MultiProvider(
      providers: Providers.adminProviders,
      child: const AdminApp(),
    ));
  } else {
    await Firebase.initializeApp();
    // Database.dbRealtime.setPersistenceEnabled(true);
    Constants.prefs = await SharedPreferences.getInstance();
    runApp(MultiProvider(
      providers: Providers.customerProviders,
      child: const CustomerApp(),
    ));
  }
}
