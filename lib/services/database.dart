import 'package:firebase_database/firebase_database.dart';
import 'package:food_shop/models/app_user.dart';
import 'package:food_shop/models/order.dart';
import 'package:food_shop/models/product.dart';

class Database {
  Database._();
  static final dbRealtime = FirebaseDatabase.instance;

  static Stream<List<Product>> get products {
    return dbRealtime.ref('products').onValue.map<List<Product>>(
          (event) => Product.fromSnapshotChildren(event.snapshot.children),
        );
  }

  static Stream<List<Order>> get orders {
    return dbRealtime.ref('orders').onValue.map<List<Order>>(
          (event) => Order.fromSnapshotChildren(event.snapshot.children),
        );
  }

  static Stream<List<AppUser>> get users {
    return dbRealtime.ref('users').onValue.map<List<AppUser>>(
          (event) => AppUser.fromSnapshotChildren(event.snapshot.children),
        );
  }

  static Future<AppUser> user(String userId) {
    return dbRealtime.ref("users/$userId").get().then<AppUser>(
          (snap) => AppUser.fromSnapshot(snap.value),
        );
  }

  static Future<Order> order(String orderId) {
    return dbRealtime.ref("orders/$orderId").get().then<Order>(
          (snap) => Order.fromSnapshot(snap.value),
        );
  }

  static Stream<List<Order>> ordersByUser(String userId) {
    return dbRealtime
        .ref("orders")
        .orderByChild("customerId")
        .equalTo(userId)
        .onValue
        .map(
          (event) => Order.fromSnapshotChildren(event.snapshot.children),
        );
  }
}
