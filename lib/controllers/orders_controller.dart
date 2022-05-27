import 'package:food_shop/services/database.dart';

class OrdersController {
  OrdersController._();
  factory OrdersController() => OrdersController._();

  Future<void> remove(String orderId) async {
    await Database.dbRealtime.ref("orders/$orderId").remove();
  }

  Future<void> changeStatus(String orderId, {required String status}) async {
    await Database.dbRealtime.ref("orders/$orderId/status").set(status);
  }
}
