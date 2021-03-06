import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/services/services.dart';
import 'package:provider/provider.dart';

class Providers {
  Providers._();
  static final adminProviders = [
    ChangeNotifierProvider<ProductsController>(
        create: (_) => ProductsController()),

    StreamProvider<List<Order>?>.value(
      value: Database.orders,
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
    ),
    // StreamProvider<List<Order>?>.value(
    //   value: Database.ordersByStatus("Pending"),
    //   initialData: null,
    //   catchError: (context, object) {
    //     throw (object.toString());
    //   },
    //   child: const DashboardView(),
    // ),
    StreamProvider<List<AppUser>?>.value(
      value: Database.users,
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
    ),
    StreamProvider<List<Product>?>.value(
      value: Database.products,
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
    ),
    // FutureProvider<List<Product>>(
    //   create: (_) async => Cart().productList,
    //   initialData: const [],
    // )
  ];

  static final customerProviders = [
    ChangeNotifierProvider(create: (_) => CartController()),
    ChangeNotifierProvider(create: (_) => BottomNavController()),
    ChangeNotifierProvider(create: (_) => ProfileController()),
    ChangeNotifierProvider(create: (_) => AuthController()),
    // ChangeNotifierProvider(create: (_) => SearchController()),
    StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
    ),
    // StreamProvider<AppUser?>.value(
    //   value: Database.user(FirebaseAuth.instance.currentUser?.uid),
    //   initialData: null,
    //   catchError: (context, object) {
    //     throw (object.toString());
    //   },
    // ),
    // StreamProvider<AppUser?>.value(
    //   value: FirebaseAuth.instance.authStateChanges().map<AppUser?>((user) {
    //     AppUser? appUser;
    //     Database.user(user!.uid).listen((event) {
    //       appUser = event;
    //     });
    //     return appUser;
    //   }),
    //   initialData: null,
    //   catchError: (context, object) {
    //     throw (object.toString());
    //   },
    // ),
    StreamProvider<List<Product>?>.value(
      value: Database.products,
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
    ),
    // if (FirebaseAuth.instance.currentUser?.uid != null)
    //   StreamProvider<AppUser?>.value(
    //     // value: Database.user(Constants.userId),
    //     value: Database.user(FirebaseAuth.instance.currentUser!.uid),
    //     // value: Database.user(AuthController().uid),
    //     initialData: null,
    //     catchError: (context, object) {
    //       throw (object.toString());
    //     },
    //   ),
    // if (FirebaseAuth.instance.currentUser?.uid != null)
    //   StreamProvider<List<Order>?>.value(
    //     // value: Database.ordersByUser(Constants.userId),
    //     value: Database.ordersByUser(FirebaseAuth.instance.currentUser!.uid),
    //     initialData: null,
    //     catchError: (context, object) {
    //       throw (object.toString());
    //     },
    //   ),
    // FutureProvider<List<Product>>(
    //   create: (_) async => Cart().productList,
    //   initialData: const [],
    // )
  ];
}
