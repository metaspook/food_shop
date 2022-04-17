import 'package:flutter/cupertino.dart';
import 'package:food_shop/customer_app/pages/views/views.dart';

class BottomNavController extends ChangeNotifier {
  int _currentIndex = 0;

  final _views = const {
    "Food Shop": FoodShopView(),
    "Profile": ProfileView(),
    "My Orders": MyOrdersView(),
    "Settings": UserSettingsView(),
  };
  int get currentIndex => _currentIndex;
  Widget get currentView => _views.values.elementAt(_currentIndex);
  String get currentAppTitle => _views.keys.elementAt(_currentIndex);

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
