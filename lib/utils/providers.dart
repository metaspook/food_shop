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
    StreamProvider<List<User>?>.value(
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
    ChangeNotifierProvider(create: (_) => Cart()),
    StreamProvider<List<Product>?>.value(
      value: Database.products,
      initialData: null,
      catchError: (context, object) {
        throw (object.toString());
      },
    ),
  ];
}
