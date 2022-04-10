import 'package:flutter/cupertino.dart';

class ProductController extends ChangeNotifier {
  List<bool> editModes = <bool>[];

  void editModeChange(int index, bool mode) {
    editModes[index] = mode;
    notifyListeners();
  }
}
