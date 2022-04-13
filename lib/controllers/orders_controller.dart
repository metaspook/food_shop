import 'package:flutter/material.dart';
import 'package:food_shop/admin_app/pages/order_page.dart';
import 'package:food_shop/models/models.dart';
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

  static navigateOrder(BuildContext context, Order order) {
    // Database.dbRealtime.ref("users/$userId/status")
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderPage(order),
      ),
    );
  }
}
