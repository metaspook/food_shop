import 'package:food_shop/controllers/cart_provider.dart';
import 'package:food_shop/models/product.dart';
import 'package:food_shop/utils/variable.dart';

class ProductProvider {
  final _db = Variable.dbRealtime.ref('products');

  Stream<List<Product>> get getProducts {
    return _db.onValue.map(
      (event) => Product.fromSnapshotChildren(event.snapshot.children),
    );
  }
  //  Future<List<Product>> get productFuture {
  //   return _db. map(
  //         (event) => Product.fromSnapshotChildren(event.snapshot.children),
  //       );
  // }

  // Product getProduct({required String id, String? child}) async {
  Future<List<Product>> get getCartProducts async {
    // final path = child == null ? id : "$id/$child";

    final _cartItemList = Cart().itemList;
    // final _cartProductList = [];
    return [
      for (var e in _cartItemList)
        Product.fromSnapshot((await _db.child(e.productId).get()).value)
    ];

    // List.generate(_cartItemList.length, (index) async {
    //   return Product.fromSnapshot(
    //       (await _db.child(_cartItemList[index].itemId).get()).value);
    // });

    // for (var e in _cartItemList) {
    //   final snap = await _db.child(e.itemId).get();
    //   _cartProductList.add(Product.fromSnapshot(snap.value));
    // }

    // Object? product;
    // await _db.child(id).get();
    // return Product.fromSnapshot(product);
  }

  // /// Get the list of all items in the cart.
  // List<CartItem> get itemList => CartItem.fromJsonStringList(_cartItemList);

  // /// Check if an item contains in the cart.
  // bool containItem(CartItem item) =>
  //     _cartItemList.contains(item.toJsonString());

  // /// Add an item in the cart.
  // Future<void> addItem(CartItem item) async {
  //   _cartItemList.add(item.toJsonString());
  //   await Variable.prefs.setStringList("cartItemList", [..._cartItemList]);
  //   notifyListeners();
  // }

  // /// Remove an item from the cart.
  // Future<void> removeItem(CartItem item) async {
  //   _cartItemList.remove(item.toJsonString());
  //   await Variable.prefs.setStringList("cartItemList", [..._cartItemList]);
  //   notifyListeners();
  // }

  // /// Remove the cart with all items.
  // Future<void> removeCart() async {
  //   await Variable.prefs.remove("cartItemList");
  //   _cartItemList.clear();
  //   notifyListeners();
  // }
}
