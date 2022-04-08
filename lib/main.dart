import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/admin_app.dart';
import 'package:food_shop/controllers/cart_provider.dart';
import 'package:food_shop/controllers/counter_provider.dart';
import 'package:food_shop/customer_app/customer_app.dart';
import 'package:food_shop/firebase_options.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/services/database.dart';
import 'package:food_shop/utils/variable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Note that this line is required, otherwise flutter throws an error
  // about using binary messenger before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions.fromMap(firebaseOptions));
    //     const FirebaseOptions(
    //   apiKey: FireOps.apiKey,
    //   authDomain: FireOps.authDomain,
    //   databaseURL: FireOps.databaseURL,
    //   projectId: FireOps.projectId,
    //   storageBucket: FireOps.storageBucket,
    //   messagingSenderId: FireOps.messagingSenderId,
    //   appId: FireOps.appId,
    //   measurementId: FireOps.measurementId,
    // ));
    runApp(MultiProvider(
      providers: [
        StreamProvider<List<Order>?>.value(
          value: Database.orders,
          initialData: null,
          catchError: (context, object) {
            throw (object.toString());
          },
          // child: const OrdersView(),
        ),
        // ChangeNotifierProvider(create: (_) => ProductProvider()),
        // StreamProvider(
        //   create: (_) => ProductProvider().getProducts,
        //   initialData: const CircularProgressIndicator.adaptive(),
        // ),

        // FutureProvider<List<Product>>(
        //   create: (_) async => Cart().productList,
        //   initialData: const [],
        // )
        // FutureProvider(
        //   create: (_) => ProductProvider().getCartProducts,
        //   initialData: const CircularProgressIndicator.adaptive(),
        // )
      ],
      child: const AdminApp(),
    ));
  } else {
    await Firebase.initializeApp();
    Variable.dbRealtime.setPersistenceEnabled(true);
    Variable.prefs = await SharedPreferences.getInstance();
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => Cart()),
        // StreamProvider<List<Order>>.value(
        //   value: Database.orders,
        //   initialData: const [],
        //   child: const OrdersView(),
        // ),
        // ChangeNotifierProvider(create: (_) => ProductProvider()),
        // StreamProvider(
        //   create: (_) => ProductProvider().getProducts,
        //   initialData: const CircularProgressIndicator.adaptive(),
        // ),

        FutureProvider<List<Product>>(
          create: (_) async => Cart().productList,
          initialData: const [],
        )
        // FutureProvider(
        //   create: (_) => ProductProvider().getCartProducts,
        //   initialData: const CircularProgressIndicator.adaptive(),
        // )
      ],
      child: const CustomerApp(),
    ));
  }
}
