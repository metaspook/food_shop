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
  final _views = <Map<String, dynamic>>[
    {
      "title": "Sign In",
      "view": const SignInView(),
    },
    {
      "title": "Create Account",
      "view": const SignUpView(),
    },
  ];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  Widget get currentView => _views[_currentIndex]["view"];
  String get currentAppTitle => _views[_currentIndex]["title"];
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

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

  Future<String?> signUp() async {
    if (_imageFile != null) {
      _isNewUser = true;
      _currentIndex = 0;
      notifyListeners();
      try {
        // Create new user and set UID.
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: XController.email.text,
              password: XController.password.text,
            )
            .then((userCredential) => _userId = userCredential.user!.uid);
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
        XController.fullName.clear();
        XController.phone.clear();
        XController.address.clear();
      } on FirebaseAuthException catch (err) {
        if (err.code == 'weak-password') {
          return 'The password provided is too weak.';
        } else if (err.code == 'email-already-in-use') {
          return 'The account already exists for that email.';
        }
      } catch (err) {
        return err.toString();
      }
    } else {
      return '* Please pick an image!!';
    }
    return 'Account created!';
  }
}
