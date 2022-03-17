import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:food_shop/apps/admin_app.dart';
import 'package:food_shop/apps/customer_app.dart';
import 'package:food_shop/firebase_options.dart';
import 'package:food_shop/utils/variable.dart';

Future<void> main() async {
  // Note that this line is required, otherwise flutter throws an error
  // about using binary messenger before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: FireOps.apiKey,
      authDomain: FireOps.authDomain,
      databaseURL: FireOps.databaseURL,
      projectId: FireOps.projectId,
      storageBucket: FireOps.storageBucket,
      messagingSenderId: FireOps.messagingSenderId,
      appId: FireOps.appId,
      measurementId: FireOps.measurementId,
    ));
    Variable.dbRealtime = FirebaseDatabase.instance;
    Variable.fbStorage = FirebaseStorage.instance;
    runApp(const AdminApp());
  } else {
    await Firebase.initializeApp();
    Variable.dbRealtime = FirebaseDatabase.instance;
    Variable.dbRealtime.setPersistenceEnabled(true);
    Variable.fbStorage = FirebaseStorage.instance;
    runApp(const CustomerApp());
  }
}
