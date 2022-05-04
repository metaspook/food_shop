import 'package:flutter/cupertino.dart';

class SearchController extends ChangeNotifier {
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  void setSearching(bool isSearching) {
    _isSearching = isSearching;
    notifyListeners();
  }
}
