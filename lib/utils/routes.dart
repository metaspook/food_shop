import 'package:food_shop/admin_app/pages/admin_page.dart';
import 'package:food_shop/admin_app/pages/views/products_view.dart';

class Routes {
  Routes._();
  static const initialRoute = '/';
  static final adminRoutes = {
    '/': (_) => const AdminPage(),
    '/home': (_) => const AdminPage(),
    '/home2': (_) => const ProductsView(),
  };
}
