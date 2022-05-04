import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/customer_app/pages/views/views.dart';
import 'package:food_shop/services/services.dart';

class AuthController extends ChangeNotifier {
  static late String _userId;
  // static String? _userId;
  // String? get userId => _userId;
  // void setUserId(String? userId) {
  //   if (userId != null) {
  //     _userId = userId;
  //     notifyListeners();
  //   }
  // }

  static File? _imageFile;
  File? get imageFile => _imageFile;
  void setImageFile(File? imageFile) {
    if (imageFile != null) {
      _imageFile = imageFile;
      notifyListeners();
    }
  }

  // void initCustomerPage(String userId) {
  //   final appUserProvider = StreamProvider<AppUser?>.value(
  //     value: Database.user(userId),
  //     initialData: null,
  //     catchError: (context, object) {
  //       throw (object.toString());
  //     },
  //   );
  //   if (!Providers.customerProviders.contains(appUserProvider)) {
  //     Providers.customerProviders.add(appUserProvider);
  //   }
  //   print(userId);
  //   notifyListeners();
  // }

  // String get uid => _userId;
  // void setUid(String uid) {
  //   _userId = uid;
  //   notifyListeners();
  // }

  bool _isNewUser = false;
  bool get isNewUser => _isNewUser;
  void setNewUserState(bool isNewUser) {
    _isNewUser = isNewUser;
    notifyListeners();
  }

  // AUTH VIEWS CONTROLLER
  final _views = const {
    "Sign In": SignInView(),
    "Create Account": SignUpView(),
  };
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  Widget get currentView => _views.values.elementAt(_currentIndex);
  String get currentAppTitle => _views.keys.elementAt(_currentIndex);
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Sign out current user.
  Future<void> signOut(BuildContext context) async {
    Methods.snackBar(context, 'Logging Out!');
    try {
      await FirebaseAuth.instance.signOut();
    } catch (err) {
      Methods.snackBar(context, err.toString());
    }
  }

  /// Sign in authenticated user.
  Future<void> signIn(BuildContext context) async {
    Methods.snackBar(context, 'Logging In!');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: XController.email.text,
        password: XController.password.text,
      );
      XController.email.clear();
      XController.password.clear();
      setNewUserState(false);
    } catch (err) {
      Methods.snackBar(context, err.toString());
    }
  }

  Future<void> signUp(
    BuildContext context, {
    required GlobalKey<FormState> formKey,
  }) async {
    if (formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          Methods.snackBar(context, 'Processing Data...');
          // Create new user and set UID.
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: XController.email.text,
                password: XController.password.text,
              )
              .then((userCredential) => _userId = userCredential.user!.uid);
          // } on FirebaseAuthException catch (e) {
          //   if (e.code == 'weak-password') {
          //     print('The password provided is too weak.');
          //   } else if (e.code == 'email-already-in-use') {
          //     print('The account already exists for that email.');
          //   }
          // Set User DB and Storage references.
          final dbRef = Database.dbRealtime.ref("users/$_userId");
          final storageRef =
              FirebaseStorage.instance.ref("images/users/$_userId.jpg");
          // Upload User image to Storage.
          await storageRef.putFile(_imageFile!);
          // Upload User data to DB.
          await dbRef.set({
            "id": _userId,
            "fullName": XController.fullName.text,
            "email": XController.email.text,
            "password": XController.password.text,
            "phone": XController.phone.text,
            "address": XController.address.text,
            "image": await storageRef.getDownloadURL(),
          });
          // FirebaseAuth.instance.signOut();
          Methods.snackBar(context, 'Account Created!');
          // XController.signUpDisposer;
          XController.fullName.clear();
          XController.phone.clear();
          XController.address.clear();
          // XController.email.clear();
          // XController.password.clear();
          _isNewUser = true;
          _currentIndex = 0;
          // setIndex(0);
          notifyListeners();
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => const CustomerApp()),
          //     (Route<dynamic> route) => route.isFirst);

          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const CustomerApp(),
          //   ),
          // );
        } catch (err) {
          Methods.snackBar(context, err.toString());
        }
      } else {
        Methods.snackBar(context, '* Please pick an image!!');
      }
    }
  }
}
