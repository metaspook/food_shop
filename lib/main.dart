import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:food_shop/firebase_options.dart';
import 'package:food_shop/pages/admin_panel.dart';
import 'package:food_shop/pages/sign_up.dart';
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
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Shop',
      theme: ThemeData(
        // primarySwatch: Colors.indigo,
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.pink,
        ),
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => FoodListPage(prefs: prefs),
      //   '/cart': (context) => CartPage(prefs: prefs),
      // },
      // home: const CartPage(title: 'Your Cart'),
      // home: FoodListPage(),
      home: const SignUpPage(),
    );
  }
}

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);
  // final SharedPreferences prefs;
  // final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Shop Admin',
      theme: ThemeData(
        // primarySwatch: Colors.indigo,
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.pink,
        ),
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => FoodListPage(prefs: prefs),
      //   '/cart': (context) => CartPage(prefs: prefs),
      // },
      // home: const CartPage(title: 'Your Cart'),
      // home: FoodListPage(),
      // home: const FakeUploader(),
      // home: const OrderPage(),
      home: const AdminPage(),
    );
  }
}
