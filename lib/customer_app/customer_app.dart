import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/customer_app/pages/auth_page.dart';
import 'package:food_shop/customer_app/pages/pages.dart';
import 'package:provider/provider.dart';

class CustomerApp extends StatelessWidget {
  /// Customer app is a Mobile (Android, iOS) app.
  const CustomerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<User?>();
    final isNewUser = context.watch<AuthController>().isNewUser;
    // if (authUser != null && FirebaseAuth.instance.currentUser?.uid != null) {
    //   final appUserProvider = StreamProvider<AppUser?>.value(
    //     value: Database.user(authUser.uid),
    //     initialData: null,
    //     catchError: (context, object) {
    //       throw (object.toString());
    //     },
    //   );
    //   if (!Providers.customerProviders.contains(appUserProvider)) {
    //     Providers.customerProviders.add(appUserProvider);
    //   }
    //   print(authUser.uid);
    // }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Shop',
      theme: ThemeData(
        // primarySwatch: Colors.indigo,
        colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.pink,
        ),
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => FoodListPage(prefs: prefs),
      //   '/cart': (context) => CartPage(prefs: prefs),
      // },
      // home: const CartPage(title: 'Your Cart'),
      // home: StreamPage1(),
      // home: const SearchList(),
      home: (isNewUser == false) && (authUser != null)
          ? const CustomerPage()
          : const AuthPage(),

      // (authUser != null && isNewUser == false)
      //     ? const CustomerPage()
      //     : const AuthPage(),
      // home: const SignInPage(),
      // home: const SignUpPage(),
    );
  }
}
