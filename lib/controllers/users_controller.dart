import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_shop/services/services.dart';

class UsersController {
  UsersController._();
  factory UsersController() => UsersController._();
  Future<void> remove(String userId) async {
    await Database.dbRealtime.ref("users/$userId").remove();
    await FirebaseStorage.instance.ref("images/users/$userId.jpg").delete();
  }
}
