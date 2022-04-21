import 'package:flutter/material.dart';
import 'package:food_shop/services/database.dart';

class ProductsController extends ChangeNotifier {
  static List<bool> _editModes = [];
  static List<TextEditingController> _updatePrices = [];
  static List<TextEditingController> _updateStocks = [];

  // static int get length => _length;

  static void initCardAdmin(int productsLength) {
    if (_editModes.isEmpty) {
      _editModes = <bool>[for (var i = 0; i < productsLength; i++) false];
    }
    if (_updatePrices.isEmpty) {
      _updatePrices = <TextEditingController>[
        for (var i = 0; i < productsLength; i++) TextEditingController()
      ];
    }

    if (_updateStocks.isEmpty) {
      _updateStocks = <TextEditingController>[
        for (var i = 0; i < productsLength; i++) TextEditingController()
      ];
    }
  }

  // static int get length {
  //   Database.products.listen((event) => _length = event.length);
  //   print(_length);
  //   return _length;
  // }

  static List<TextEditingController> get updatePrices => _updatePrices;
  static List<TextEditingController> get updateStocks => _updateStocks;
  List<bool> get editModes => _editModes;

  void editModeOn(int index) {
    editModes[index] = true;
    notifyListeners();
  }

  Future<void> editModeOff(int index, String productId) async {
    if (ProductsController.updatePrices[index].text.isNotEmpty) {
      await Database.dbRealtime
          .ref("products/$productId/price")
          .set(num.tryParse(ProductsController.updatePrices[index].text));
      ProductsController.updatePrices[index].clear();
    }
    if (ProductsController.updateStocks[index].text.isNotEmpty) {
      await Database.dbRealtime
          .ref("products/$productId/stock")
          .set(int.tryParse(ProductsController.updateStocks[index].text));
      ProductsController.updateStocks[index].clear();
    }
    editModes[index] = false;
    notifyListeners();
  }
}
