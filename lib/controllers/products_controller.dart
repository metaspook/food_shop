import 'package:flutter/material.dart';
import 'package:food_shop/services/database.dart';

class ProductsController extends ChangeNotifier {
  List<bool> editModes = <bool>[];

  static List<TextEditingController> updatePrices = <TextEditingController>[];
  static List<TextEditingController> updateStocks = <TextEditingController>[];
  // static final priceInput = TextEditingController();
  // static final stockInput = TextEditingController();

  void editModeOn(int index) {
    // void editModeOn([int index = 0]) {
    editModes[index] = true;
    notifyListeners();
  }

  void editModeOff(int index, String productId) {
    // void editModeOff(String productId, [int index = 0]) {
    editModes[index] = false;

    if (ProductsController.updatePrices[index].text.isNotEmpty) {
      Database.dbRealtime
          .ref("products/$productId/price")
          .set(num.tryParse(ProductsController.updatePrices[index].text));
    }
    if (ProductsController.updateStocks[index].text.isNotEmpty) {
      Database.dbRealtime
          .ref("products/$productId/stock")
          .set(int.tryParse(ProductsController.updateStocks[index].text));
    }

    notifyListeners();
  }
}
