import 'package:flutter/material.dart';
import 'package:food_shop/services/database.dart';

class ProductsController extends ChangeNotifier {
  static int _length = 0;
  final _editModes = <bool>[for (var i = 0; i < length; i++) false];
  static final _updatePrices = <TextEditingController>[
    for (var i = 0; i < length; i++) TextEditingController()
  ];
  static final _updateStocks = <TextEditingController>[
    for (var i = 0; i < length; i++) TextEditingController()
  ];

  static int get length {
    Database.products.listen((event) => _length = event.length);
    return _length;
  }

  static List<TextEditingController> get updatePrices => _updatePrices;
  static List<TextEditingController> get updateStocks => _updateStocks;
  List<bool> get editModes => _editModes;

  void editModeOn(int index) {
    editModes[index] = true;
    notifyListeners();
  }

  Future<void> editModeOff(int index, String productId) async {
    editModes[index] = false;
    notifyListeners();

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
  }
}
