import 'package:firebase_database/firebase_database.dart';
import 'package:food_shop/models/app_user.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/models/product.dart';

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

  static Stream<List<AppUser>> get users {
    return dbRealtime.ref('users').onValue.map(
          (event) => AppUser.fromSnapshotChildren(event.snapshot.children),
        );
  }

  static Future<AppUser> user(String userId) {
    return dbRealtime.ref("users/$userId").get().then(
          (snap) => AppUser.fromSnapshot(snap.value),
        );
  }
}
