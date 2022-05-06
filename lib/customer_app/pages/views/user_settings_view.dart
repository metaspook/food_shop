import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/utils/utils.dart';
import 'package:provider/provider.dart';

class UserSettingsView extends StatelessWidget {
  const UserSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outlined, color: Colors.grey.shade600),
                      const SizedBox(width: 5),
                      SelectableText(
                        'About',
                        style: TextStyle(
                            fontSize: 17.5,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    "A Food Shop app with Web admin panel created on Flutter with Provider, SharedPreference, Firebase Realtime Database. Made with ❤️ from 🇧🇩 . It's totally my brain child even the UI (I know it looks kinda nOOb though 😁) Actually I was testing my capabilities while self-learning, feel free to fork this project from GitHub.",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    'Developed by Metaspook  👻',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(elevation: 5),
                onPressed: () {
                  Methods.customDialogText(
                    title: '⚠️ Caution!',
                    subtitle: 'Do you want to reset the app?',
                    context: context,
                    primaryButtonText: 'Cancel',
                    primaryButtonFunction: () => Methods.navPop(context),
                    secondaryButtonText: 'Confirm',
                    secondaryButtonFunction: () async {
                      Methods.snackBar(context, 'Resetting App...');
                      Methods.navPop(context);
                      await context.read<CartController>().removeCart();
                      await Constants.prefs.clear();
                      await context.read<AuthController>().signOut();
                    },
                  );
                },
                icon: const Icon(Icons.replay_outlined),
                label: const Text('Reset App'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(elevation: 5),
                onPressed: () {
                  Methods.customDialogText(
                    title: 'Confirm Sign Out?',
                    context: context,
                    primaryButtonText: 'Cancel',
                    primaryButtonFunction: () => Methods.navPop(context),
                    secondaryButtonText: 'Confirm',
                    secondaryButtonFunction: () async {
                      Methods.snackBar(context, 'Logging Out...');
                      Methods.navPop(context);
                      await context.read<CartController>().removeCart();
                      await context.read<AuthController>().signOut();
                    },
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
