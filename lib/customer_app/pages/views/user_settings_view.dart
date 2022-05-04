import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:provider/provider.dart';

class UserSettingsView extends StatelessWidget {
  const UserSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.replay_outlined),
          label: const Text('Reset App'),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            await context.read<CartController>().removeCart();
            await context.read<AuthController>().signOut(context);
          },
          icon: const Icon(Icons.logout),
          label: const Text('Sign Out'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.info_outlined),
          label: const Text('About'),
        )
      ],
    );
  }
}
