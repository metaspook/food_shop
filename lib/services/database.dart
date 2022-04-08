import 'package:firebase_database/firebase_database.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/models/user.dart';

class Database {
  Database._();
  static final dbRealtime = FirebaseDatabase.instance;

  static Stream<List<Product>> get products {
    return dbRealtime.ref('products').onValue.map(
          (event) => Product.fromSnapshotChildren(event.snapshot.children),
        );
  }

  static Stream<List<Order>> get orders {
    return dbRealtime.ref('orders').onValue.map(
          (event) => Order.fromSnapshotChildren(event.snapshot.children),
        );
  }

  static Stream<List<User>> get users {
    return dbRealtime.ref('users').onValue.map(
          (event) => User.fromSnapshotChildren(event.snapshot.children),
        );
  }
}
