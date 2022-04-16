import 'package:food_shop/services/database.dart';

class OrdersController {
  OrdersController._();

  static Future<void> remove(String orderId) async {
    await Database.dbRealtime.ref("orders/$orderId").remove();
  }

  static Future<void> changeStatus(String orderId,
      {required String status}) async {
    await Database.dbRealtime.ref("orders/$orderId/status").set(status);
  }
}
