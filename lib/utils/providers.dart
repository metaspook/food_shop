import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/services/services.dart';
import 'package:provider/provider.dart';

class Providers {
  Providers._();
  static final adminProviders = [
    // ChangeNotifierProvider<UserController>(create: (_) => UserController()),
    ChangeNotifierProvider<ProductsController>(
        create: (_) => ProductsController()),

    StreamProvider<List<Order>?>.value(
      value: Database.orders,
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
      // child: const OrdersView(),
    ),
    StreamProvider<List<User>?>.value(
      value: Database.users,
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
      // child: const OrdersView(),
    ),
    StreamProvider<List<Product>?>.value(
      value: Database.products,
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
      // child: const OrdersView(),
    ),

    // FutureProvider<List<Product>>(
    //   create: (_) async => Cart().productList,
    //   initialData: const [],
    // )
    // FutureProvider(
    //   create: (_) => ProductProvider().getCartProducts,
    //   initialData: const CircularProgressIndicator.adaptive(),
    // )
  ];

  static final customerProviders = [
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
  ];
}
