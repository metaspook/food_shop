import 'package:flutter/cupertino.dart';
import 'package:food_shop/customer_app/pages/views/views.dart';

class BottomNavController extends ChangeNotifier {
  int _currentIndex = 0;

  final _views = const [
    ProductsView(),
    ProfileView(),
  ];
  int get currentIndex => _currentIndex;
  Widget get currentView => _views[_currentIndex];

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
